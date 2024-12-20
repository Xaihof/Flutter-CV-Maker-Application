import 'dart:io';
import 'dart:typed_data';

import 'package:cvmaker/pdfView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Sizes.dart';

class template2 extends StatefulWidget {
  // Variables.
  final File? file;
  final Map<String, dynamic> profile;
  final Map<String, dynamic> objective;
  final List<Map<String, dynamic>> education;
  final List<Map<String, dynamic>> experience;
  final List<Map<String, dynamic>> skills;
  final List<Map<String, dynamic>> interests;
  final List<Map<String, dynamic>> achievements;
  final List<Map<String, dynamic>> languages;
  final List<Map<String, dynamic>> projects;
  final List<Map<String, dynamic>> reference;
  String fileName;
  bool flag1;

  template2({
    super.key,
    required this.file,
    required this.profile,
    required this.objective,
    required this.education,
    required this.experience,
    required this.skills,
    required this.interests,
    required this.achievements,
    required this.languages,
    required this.projects,
    required this.reference,
    required this.fileName,
    required this.flag1,
  });

  @override
  _template2State createState() => _template2State();
}

class _template2State extends State<template2> {
  PdfColor myColor = PdfColor.fromHex('#ff4dff');
  double headingsize = 0;
  double txtsize = 0;
  int _selectedIndex = 0;

  Future<Uint8List> getImageDataFromAsset(String assetName) async {
    final ByteData data = await rootBundle.load(assetName);
    return data.buffer.asUint8List();
  }

  void _generatePdf() async {
    final pdf = pw.Document();
    Uint8List? imageData;

    if (widget.file != null) {
      imageData = await widget.file!.readAsBytes();
    } else {
      imageData = await getImageDataFromAsset('assets/placeholder.jpg');
    }
    // Create a global key for the SingleChildScrollView
    // Add content to the PDF

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(5),
        build: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 3),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                    flex: 2,
                    child: pw.Container(
                      color: Sizes.bgColor2,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(
                            height: 20,
                          ),
                          pw.Center(
                            child: pw.Container(
                              width: 140,
                              height: 140,
                              padding: const pw.EdgeInsets.only(top: 10),
                              child: pw.Image(
                                pw.MemoryImage(imageData!),
                                fit: pw.BoxFit.fill,
                              ),
                            ),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(left: 10),
                            child: pw.Text(
                              'Education',
                              style: pw.TextStyle(
                                fontSize: Sizes.Heading,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.white,
                              ),
                            ),
                          ),
                          pw.Container(
                            padding: const pw.EdgeInsets.only(left: 10),
                            child: pw.Divider(
                                thickness: 0.5, color: PdfColors.yellow),
                          ),
                          pw.ListView.builder(
                            itemCount: widget.education.length,
                            // Replace with the actual item count you want to display
                            itemBuilder: (context, index) {
                              // Return your list item widget here
                              // For example:
                              return pw.Padding(
                                padding:
                                    const pw.EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: pw.Container(
                                  padding: const pw.EdgeInsets.only(bottom: 10),
                                  child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Container(
                                        padding: const pw.EdgeInsets.fromLTRB(
                                            10, 0, 5, 0),
                                        child: pw.Text(
                                          '${widget.education[index]['degree']}',
                                          style: pw.TextStyle(
                                              fontSize: Sizes.Subheading,
                                              color: PdfColors.white),
                                        ),
                                      ),
                                      pw.Container(
                                        padding: const pw.EdgeInsets.fromLTRB(
                                            10, 0, 5, 0),
                                        child: pw.Text(
                                          '${widget.education[index]['institute']}',
                                          style: pw.TextStyle(
                                              fontSize: Sizes.Paragraph,
                                              color: PdfColors.white),
                                        ),
                                      ),
                                      pw.Container(
                                        padding: const pw.EdgeInsets.fromLTRB(
                                            10, 0, 5, 0),
                                        child: pw.Text(
                                          '${widget.education[index]['university']}',
                                          style: pw.TextStyle(
                                              fontSize: Sizes.Paragraph,
                                              color: PdfColors.white),
                                        ),
                                      ),
                                      pw.Container(
                                        padding: const pw.EdgeInsets.fromLTRB(
                                            10, 0, 5, 0),
                                        child: pw.Text(
                                          '${widget.education[index]['startdate']}-${widget.education[index]['enddate']}',
                                          style: pw.TextStyle(
                                              fontSize: Sizes.Paragraph,
                                              color: PdfColors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          widget.flag1
                              ? pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                      pw.Container(
                                        padding:
                                            const pw.EdgeInsets.only(left: 10),
                                        child: pw.Text(
                                          'REFERENCE',
                                          style: pw.TextStyle(
                                            fontSize: Sizes.Heading,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColors.white,
                                          ),
                                        ),
                                      ),
                                      pw.Container(
                                        padding:
                                            const pw.EdgeInsets.only(left: 10),
                                        child: pw.Divider(
                                            thickness: 0.5,
                                            color: PdfColors.yellow),
                                      ),
                                      pw.ListView.builder(
                                        itemCount: widget.reference.length,
                                        // Replace with the actual item count you want to display
                                        itemBuilder: (context, index) {
                                          // Return your list item widget here
                                          // For example:
                                          return pw.Padding(
                                            padding:
                                                const pw.EdgeInsets.fromLTRB(
                                                    15, 0, 5, 5),
                                            child: pw.Column(
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.start,
                                              children: [
                                                pw.Text(
                                                  '${widget.reference[index]['reference']}',
                                                  style: pw.TextStyle(
                                                    fontSize: Sizes.Subheading,
                                                    color: PdfColors.white,
                                                  ),
                                                ),
                                                pw.Text(
                                                  '${widget.reference[index]['job']}',
                                                  style: pw.TextStyle(
                                                    fontSize: Sizes.Subheading,
                                                    color: PdfColors.white,
                                                  ),
                                                ),
                                                pw.Text(
                                                  '${widget.reference[index]['company']}',
                                                  style: pw.TextStyle(
                                                    fontSize: Sizes.Paragraph,
                                                    color: PdfColors.white,
                                                  ),
                                                ),
                                                pw.Text(
                                                  '${widget.reference[index]['email']}',
                                                  style: pw.TextStyle(
                                                    fontSize: Sizes.Paragraph,
                                                    color: PdfColors.white,
                                                  ),
                                                ),
                                                pw.Text(
                                                  '${widget.reference[index]['phoneNumber']}',
                                                  style: pw.TextStyle(
                                                    fontSize: Sizes.Paragraph,
                                                    color: PdfColors.white,
                                                  ),
                                                ),
                                                pw.Center(
                                                  child: pw.Text(
                                                      '-----------------'),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ])
                              : pw.Center(child: pw.Text('')),
                          pw.SizedBox(
                            height: 10,
                          ),
                          pw.SizedBox(height: 10),
                          pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.Row(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Container(
                                    width: 25,
                                    height: 12,
                                    color: PdfColors.yellow,
                                  ),
                                  pw.SizedBox(width: 10),
                                  pw.Expanded(
                                    child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Container(
                                          padding: const pw.EdgeInsets.only(
                                              right: 5),
                                          child: pw.Text(
                                            'Phone:',
                                            style: pw.TextStyle(
                                              fontSize: Sizes.Paragraph,
                                              fontWeight: pw.FontWeight.bold,
                                              color: PdfColors.white,
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          padding: const pw.EdgeInsets.only(
                                              right: 5),
                                          child: pw.Text(
                                            '${widget.profile['phoneNumber']}',
                                            style: pw.TextStyle(
                                              fontSize: Sizes.Paragraph,
                                              color: PdfColors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              pw.SizedBox(height: 10),
                              pw.Row(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Container(
                                    width: 25,
                                    height: 12,
                                    color: PdfColors.yellow,
                                  ),
                                  pw.SizedBox(width: 10),
                                  pw.Expanded(
                                    child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Container(
                                          padding: const pw.EdgeInsets.only(
                                              right: 5),
                                          child: pw.Text(
                                            'Email:',
                                            style: pw.TextStyle(
                                              fontSize: Sizes.Paragraph,
                                              fontWeight: pw.FontWeight.bold,
                                              color: PdfColors.white,
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          padding: const pw.EdgeInsets.only(
                                              right: 5),
                                          child: pw.Text(
                                            '${widget.profile['email']}',
                                            style: pw.TextStyle(
                                              fontSize: Sizes.Paragraph,
                                              color: PdfColors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              pw.SizedBox(height: 10),
                              pw.Row(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Container(
                                    width: 25,
                                    height: 12,
                                    color: PdfColors.yellow,
                                  ),
                                  pw.SizedBox(width: 10),
                                  pw.Expanded(
                                    child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Container(
                                          padding: const pw.EdgeInsets.only(
                                              right: 5),
                                          child: pw.Text(
                                            'Address:',
                                            style: pw.TextStyle(
                                              fontSize: Sizes.Paragraph,
                                              fontWeight: pw.FontWeight.bold,
                                              color: PdfColors.white,
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          padding: const pw.EdgeInsets.only(
                                              right: 5),
                                          child: pw.Text(
                                            '${widget.profile['address']}',
                                            style: pw.TextStyle(
                                              fontSize: Sizes.Paragraph,
                                              color: PdfColors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                pw.Expanded(
                  flex: 3,
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.only(top: 25),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(
                          height: 20,
                        ),
                        pw.Container(
                          padding: const pw.EdgeInsets.fromLTRB(10, 10, 5, 0),
                          color: PdfColors.yellow,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                            children: [
                              pw.Container(
                                child: pw.Text(
                                  '${widget.profile['firstName']} ${widget.profile['lastName']}',
                                  style: pw.TextStyle(
                                      fontSize: Sizes.Heading + 4,
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.black),
                                ),
                              ),
                              pw.SizedBox(height: 5),
                              pw.Container(
                                child: pw.Text(
                                  '${widget.profile['objective']}',
                                  style: pw.TextStyle(
                                      fontSize: Sizes.Subheading,
                                      color: PdfColors.black),
                                ),
                              ),
                              pw.SizedBox(height: 5),
                            ],
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(left: 10),
                          child: pw.Text(
                            'About Me',
                            style: pw.TextStyle(
                              fontSize: Sizes.Heading,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black,
                            ),
                          ),
                        ),
                        pw.Container(
                          child: pw.Divider(
                              thickness: 0.5, color: PdfColors.black),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(left: 14),
                          child: pw.Container(
                            padding: const pw.EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: pw.Text(
                              '${widget.objective['objective']}',
                              style: pw.TextStyle(fontSize: Sizes.Paragraph),
                            ),
                          ),
                        ),
                        pw.SizedBox(height: 15),
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(left: 10),
                          child: pw.Text(
                            'EXPERIENCES',
                            style: pw.TextStyle(
                              fontSize: Sizes.Heading,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black,
                            ),
                          ),
                        ),
                        pw.Container(
                          child: pw.Divider(
                              thickness: 0.5, color: PdfColors.black),
                        ),
                        pw.ListView.builder(
                          itemCount: widget.experience.length,
                          // Replace with the actual item count you want to display
                          itemBuilder: (context, index) {
                            // Return your list item widget here
                            // For example:
                            return pw.Container(
                              padding: const pw.EdgeInsets.only(bottom: 10),
                              child: pw.Row(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                children: [
                                  pw.Container(
                                    padding: const pw.EdgeInsets.only(left: 10),
                                    child: pw.Text(
                                      '${widget.experience[index]['startdate']}-${widget.experience[index]['enddate']}',
                                      style: pw.TextStyle(
                                          fontSize: Sizes.Paragraph),
                                    ),
                                  ),
                                  pw.SizedBox(width: 10),
                                  pw.Expanded(
                                    child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Container(
                                          child: pw.Text(
                                            '${widget.experience[index]['job']}',
                                            style: pw.TextStyle(
                                                fontSize: Sizes.Subheading),
                                          ),
                                        ),
                                        pw.Container(
                                          child: pw.Text(
                                            '${widget.experience[index]['company']}',
                                            style: pw.TextStyle(
                                                fontSize: Sizes.Subheading),
                                          ),
                                        ),
                                        pw.Container(
                                          padding: const pw.EdgeInsets.fromLTRB(
                                              0, 5, 0, 5),
                                          child: pw.Text(
                                            '${widget.experience[index]['details']}',
                                            style: pw.TextStyle(
                                                fontSize: Sizes.Subheading),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        pw.SizedBox(height: 15),
                        pw.Container(
                          padding: const pw.EdgeInsets.only(left: 10),
                          child: pw.Text(
                            'SKILLS',
                            style: pw.TextStyle(
                              fontSize: Sizes.Heading,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black,
                            ),
                          ),
                        ),
                        pw.Container(
                          child: pw.Divider(
                              thickness: 0.5, color: PdfColors.black),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.fromLTRB(14, 0, 0, 10),
                          child: pw.Container(
                            padding: const pw.EdgeInsets.only(left: 10),
                            child: pw.Wrap(
                              spacing: 5,
                              runSpacing: 5,
                              alignment: pw.WrapAlignment.start,
                              children: List.generate(
                                widget.skills.length,
                                (index) {
                                  String skill = widget.skills[index]['skill'];
                                  return pw.Row(
                                    mainAxisSize: pw.MainAxisSize.min,
                                    children: [
                                      pw.Container(
                                        width: 6,
                                        height: 6,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              color: PdfColors.black),
                                          borderRadius:
                                              pw.BorderRadius.circular(3),
                                        ),
                                      ),
                                      pw.Expanded(
                                        child: pw.Container(
                                          padding: const pw.EdgeInsets.only(
                                              left: 10),
                                          child: pw.Text(skill,
                                              style: pw.TextStyle(
                                                  fontSize: Sizes.Subheading)),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    // To get a temporary Directory and its path.
    String path = (await getTemporaryDirectory()).path;
    // Create pdf with path (path end is file name).
    File pdfFile = await File('$path/${widget.fileName}.pdf').create();
    // Save pdf
    pdfFile.writeAsBytesSync(await pdf.save());

    // Open the saved PDF using the default PDF viewer
    OpenFile.open('$path/${widget.fileName}.pdf');

    final pdfData = await pdf.save();

    // Save the PDF data to a temporary file
    pdfFile = File('${(await getTemporaryDirectory()).path}/example.pdf');
    await pdfFile.writeAsBytes(pdfData);
    Navigator.pop(context);

    // Display the PDF
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfView(pdfFile: pdfFile),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Sizes.setBgColor1(Colors.black);
  }

  // to set the global variables _selectIndex and generate PDF)
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 2) {
      _generatePdf();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use the received data to create a PDF or perform other operations
    // Example: Create a PDF using the data
    Sizes sizes = Sizes(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CV Preview',
          style:
              TextStyle(color: sizes.AppBartextColor, fontSize: sizes.fontSize),
        ),
        centerTitle: true,
        backgroundColor: Sizes.bgColor1,
        toolbarHeight: sizes.barSize,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Code of UI.
              Container(
                  width: MediaQuery.of(context).size.width * 0.36,
                  height: MediaQuery.of(context).size.height,
                  color: Sizes.bgColor1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // To display profile Picture.
                      Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.04),
                        child: Center(
                          child: SizedBox(
                            width: 80,
                            height: 80,
                            child: widget.file != null
                                ? Image.file(
                                    widget.file!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/placeholder.jpg',
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Education',
                          style: TextStyle(
                            fontSize: Sizes.Heading,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        child:
                            const Divider(thickness: 0.5, color: Colors.yellow),
                      ),
                      // Education
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        // Disable scrolling
                        shrinkWrap: true,
                        itemCount: widget.education.length,
                        // Replace with the actual item count you want to display
                        itemBuilder: (context, index) {
                          // Return your list item widget here
                          // For example:
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                            child: Container(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    child: Text(
                                      '${widget.education[index]['degree']}',
                                      style: TextStyle(
                                          fontSize: Sizes.Subheading,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    child: Text(
                                      '${widget.education[index]['institute']}',
                                      style: TextStyle(
                                          fontSize: Sizes.Paragraph,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    child: Text(
                                      '${widget.education[index]['university']}',
                                      style: TextStyle(
                                          fontSize: Sizes.Paragraph,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    child: Text(
                                      '${widget.education[index]['startdate']}-${widget.education[index]['enddate']}',
                                      style: TextStyle(
                                          fontSize: Sizes.Paragraph,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      Visibility(
                        visible: widget.flag1,
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'REFERENCE',
                            style: TextStyle(
                              fontSize: Sizes.Heading,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.flag1,
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: const Divider(
                              thickness: 0.5, color: Colors.yellow),
                        ),
                      ),
                      Visibility(
                        visible: widget.flag1,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.reference.length,
                          // Replace with the actual item count you want to display
                          itemBuilder: (context, index) {
                            // Return your list item widget here
                            // For example:
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 5, 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${widget.reference[index]['reference']}',
                                      style: TextStyle(
                                          fontSize: Sizes.Subheading,
                                          color: Colors.white)),
                                  Text('${widget.reference[index]['job']}',
                                      style: TextStyle(
                                          fontSize: Sizes.Subheading,
                                          color: Colors.white)),
                                  Text('${widget.reference[index]['company']}',
                                      style: TextStyle(
                                          fontSize: Sizes.Paragraph,
                                          color: Colors.white)),
                                  Text('${widget.reference[index]['email']}',
                                      style: TextStyle(
                                          fontSize: Sizes.Paragraph,
                                          color: Colors.white)),
                                  Text(
                                      '${widget.reference[index]['phoneNumber']}',
                                      style: TextStyle(
                                          fontSize: Sizes.Paragraph,
                                          color: Colors.white)),
                                  const SizedBox(height: 15),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 25,
                                height: 12,
                                color: Colors.yellow,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Text(
                                        'Phone:',
                                        style: TextStyle(
                                          fontSize: Sizes.Paragraph,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Text(
                                        '${widget.profile['phoneNumber']}',
                                        style: TextStyle(
                                          fontSize: Sizes.Paragraph,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 25,
                                height: 12,
                                color: Colors.yellow,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Text(
                                        'Email:',
                                        style: TextStyle(
                                          fontSize: Sizes.Paragraph,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Text(
                                        '${widget.profile['email']}',
                                        style: TextStyle(
                                          fontSize: Sizes.Paragraph,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 25,
                                height: 12,
                                color: Colors.yellow,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Text(
                                        'Address:',
                                        style: TextStyle(
                                          fontSize: Sizes.Paragraph,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Text(
                                        '${widget.profile['address']}',
                                        style: TextStyle(
                                          fontSize: Sizes.Paragraph,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.62,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.045),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 5, 0),
                            color: Colors.yellow,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    child: Text(
                                      '${widget.profile['firstName']} ${widget.profile['lastName']}',
                                      style: TextStyle(
                                          fontSize: Sizes.Heading + 4,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    child: Text(
                                      '${widget.profile['objective']}',
                                      style: TextStyle(
                                          fontSize: Sizes.Subheading,
                                          color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ])),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'About Me',
                            style: TextStyle(
                              fontSize: Sizes.Heading,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          child: const Divider(
                              thickness: 0.5, color: Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Text(
                              '${widget.objective['objective']}',
                              style: TextStyle(fontSize: Sizes.Paragraph),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'EXPERIENCES',
                            style: TextStyle(
                              fontSize: Sizes.Heading,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          child: const Divider(
                              thickness: 0.5, color: Colors.black),
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          // Disable scrolling
                          shrinkWrap: true,
                          itemCount: widget.experience.length,
                          // Replace with the actual item count you want to display
                          itemBuilder: (context, index) {
                            // Return your list item widget here
                            // For example:
                            return Container(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      '${widget.experience[index]['startdate']}-${widget.experience[index]['enddate']}',
                                      style:
                                          TextStyle(fontSize: Sizes.Paragraph),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            '${widget.experience[index]['job']}',
                                            style: TextStyle(
                                                fontSize: Sizes.Subheading),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            '${widget.experience[index]['company']}',
                                            style: TextStyle(
                                                fontSize: Sizes.Subheading),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 5, 0, 5),
                                          child: Text(
                                            '${widget.experience[index]['details']}',
                                            style: TextStyle(
                                                fontSize: Sizes.Subheading),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'SKILLS',
                            style: TextStyle(
                              fontSize: Sizes.Heading,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          child: const Divider(
                              thickness: 0.5, color: Colors.black),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14, 0, 0, 10),
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Wrap(
                              spacing: 5,
                              runSpacing: 5,
                              alignment: WrapAlignment.start,
                              children: List.generate(
                                widget.skills.length,
                                (index) {
                                  String skill = widget.skills[index]['skill'];
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(skill,
                                              style: TextStyle(
                                                  fontSize: Sizes.Subheading)),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          if (_selectedIndex == 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: 50.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ColorButton(
                      color: Colors.red,
                      onPressed: () {
                        setState(() {
                          Sizes.setBgColor1(Colors.red);
                        });
                      },
                    ),
                    ColorButton(
                      color: Colors.green,
                      onPressed: () {
                        setState(() {
                          Sizes.setBgColor1(Colors.green);
                        });
                      },
                    ),
                    ColorButton(
                      color: Colors.blue,
                      onPressed: () {
                        setState(() {
                          Sizes.setBgColor1(Colors.blue);
                        });
                      },
                    ),
                    ColorButton(
                      color: Colors.yellow,
                      onPressed: () {
                        setState(() {
                          Sizes.setBgColor1(Colors.yellow);
                        });
                      },
                    ),
                    ColorButton(
                      color: Colors.orange,
                      onPressed: () {
                        setState(() {
                          Sizes.setBgColor1(Colors.orange);
                        });
                      },
                    ),
                    ColorButton(
                      color: Colors.purple,
                      onPressed: () {
                        setState(() {
                          Sizes.setBgColor1(Colors.purple);
                        });
                      },
                    ),
                    TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'Select a color',
                                  style:
                                      TextStyle(fontSize: sizes.listFontSize),
                                ),
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    pickerColor: Sizes.bgColor1,
                                    onColorChanged: (Color color) {
                                      setState(() {
                                        Sizes.setBgColor1(color);
                                      });
                                    },
                                    showLabel: true,
                                    pickerAreaHeightPercent: 0.8,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(' Ok '),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Image.asset(
                          'assets/color-wheel.png',
                          width: sizes.iconSize,
                          height: sizes.iconSize,
                        )),
                  ],
                ),
              ),
            ),
          if (_selectedIndex == 1)
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0, // Positioning above the BottomNavigationBar
                      left: 5,
                      right: 5,
                      child: Container(
                        color: Colors.white,
                        // Background color for the floating panel
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Heading Size Controls
                            TextSizeControl(
                              label: "Heading Size",
                              size: Sizes.Heading,
                              onDecrease: () {
                                setState(() {
                                  if (Sizes.Heading > 14) {
                                    Sizes.decreaseHeading();
                                  }
                                });
                              },
                              onIncrease: () {
                                setState(() {
                                  if (Sizes.Heading < 16) {
                                    Sizes.increaseHeading();
                                  }
                                });
                              },
                            ),

                            // SubHeading Size Controls
                            TextSizeControl(
                              label: "SubHeading Size",
                              size: Sizes.Subheading,
                              onDecrease: () {
                                setState(() {
                                  if (Sizes.Subheading > 12) {
                                    Sizes.decreaseSubheading();
                                  }
                                });
                              },
                              onIncrease: () {
                                setState(() {
                                  if (Sizes.Subheading < 14) {
                                    Sizes.increaseSubheading();
                                  }
                                });
                              },
                            ),

                            // Paragraph Size Controls
                            TextSizeControl(
                              label: "Paragraph Size",
                              size: Sizes.Paragraph,
                              onDecrease: () {
                                setState(() {
                                  if (Sizes.Paragraph > 10) {
                                    Sizes.decreaseParagraph();
                                  }
                                });
                              },
                              onIncrease: () {
                                setState(() {
                                  if (Sizes.Paragraph < 11) {
                                    Sizes.increaseParagraph();
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.color_lens,
              size: sizes.mylisticonSize,
            ),
            label: 'Colors',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.text_fields,
              size: sizes.mylisticonSize,
            ),
            label: 'Text Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.picture_as_pdf,
              size: sizes.mylisticonSize,
            ),
            label: 'PDF',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: sizes.AppBartextColor,
        unselectedItemColor: sizes.appBarBgColor,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ColorButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;

  const ColorButton({super.key, required this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Sizes sizes = Sizes(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onPressed,
        // Call the onPressed callback when the button is tapped
        child: Container(
          width: sizes.mylisticonSize,
          height: sizes.mylisticonSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
      ),
    );
  }
}

class TextSizeControl extends StatelessWidget {
  final String label;
  final double size;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const TextSizeControl({
    super.key,
    required this.label,
    required this.size,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("$label: $size"),
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: onDecrease,
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: onIncrease,
        ),
      ],
    );
  }
}
