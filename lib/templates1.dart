import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'Sizes.dart';
import 'templates2.dart';

class template1 extends StatefulWidget {
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

  // Constructor.
  template1({super.key, 
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
  _template1State createState() => _template1State();
}

class _template1State extends State<template1> {
  int _selectedIndex = 0;

  // Image Function
  Future<Uint8List> getImageDataFromAsset(String assetName) async {
    final ByteData data = await rootBundle.load(assetName);
    return data.buffer.asUint8List();
  }

  // Generate PDF Function.
  void _generatePdf() async {
    Uint8List? imageData;

    if (widget.file != null) {
      imageData = await widget.file!.readAsBytes();
    } else {
      imageData = await getImageDataFromAsset('assets/placeholder.jpg');
    }
    final pdf = pw.Document();

    // Create a global key for the SingleChildScrollView
    // Add content to the PDF

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        theme: pw.ThemeData.withFont(
          icons: await PdfGoogleFonts.materialIcons(),
        ),
        build: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 3),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Pdf Design Code Starts from Here.
                pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      padding: const pw.EdgeInsets.only(top: 10),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                            padding: const pw.EdgeInsets.only(top: 10),
                            child: pw.Center(
                              child: pw.ClipOval(
                                child: pw.Container(
                                  width: 100,
                                  height: 100,
                                  child: pw.Image(
                                    pw.MemoryImage(imageData!),
                                    fit: pw.BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          pw.SizedBox(width: 5),
                          pw.Container(
                            padding: const pw.EdgeInsets.only(left: 10),
                            child: pw.Stack(
                              children: [
                                pw.Container(
                                  height: 8,
                                  width: 8,
                                  decoration: pw.BoxDecoration(
                                    borderRadius: pw.BorderRadius.circular(4),
                                    border:
                                        pw.Border.all(color: Sizes.bgColor2),
                                    color: Sizes.bgColor2,
                                  ),
                                ),
                                pw.Padding(
                                  padding: const pw.EdgeInsets.only(left: 4),
                                  child: pw.Container(
                                    padding: const pw.EdgeInsets.only(left: 4),
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border(
                                        left: pw.BorderSide(
                                            color: Sizes.bgColor2),
                                      ),
                                    ),
                                    child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Center(
                                          child: pw.Container(
                                            padding: const pw.EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: pw.Text(
                                              '${widget.profile['firstName']}\n${widget.profile['lastName']}',
                                              style: pw.TextStyle(
                                                  fontSize: Sizes.Heading + 4,
                                                  fontWeight:
                                                      pw.FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          child: pw.Text(
                                            '${widget.profile['objective']}',
                                            style: pw.TextStyle(
                                                fontSize: Sizes.Subheading),
                                          ),
                                        ),
                                        pw.SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          pw.SizedBox(height: 15),
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(left: 10),
                            child: pw.Row(
                              children: [
                                pw.Container(
                                  height: 8,
                                  width: 8,
                                  decoration: pw.BoxDecoration(
                                    borderRadius: pw.BorderRadius.circular(4),
                                    border:
                                        pw.Border.all(color: Sizes.bgColor2),
                                    color: Sizes.bgColor2,
                                  ),
                                ),
                                pw.SizedBox(width: 5),
                                pw.Text(
                                  'About Me',
                                  style: pw.TextStyle(
                                    fontSize: Sizes.Heading,
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          pw.SizedBox(width: 5),
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(left: 14),
                            child: pw.Container(
                              padding: const pw.EdgeInsets.only(left: 8),
                              decoration: pw.BoxDecoration(
                                border: pw.Border(
                                  left: pw.BorderSide(color: Sizes.bgColor2),
                                ),
                              ),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Row(
                                    children: [
                                      // Phone Number Icon
                                      pw.Icon(const pw.IconData(0xe0b0),
                                          size: 20, color: Sizes.bgColor2),
                                      pw.Text(
                                        '${widget.profile['phoneNumber']}',
                                        style: pw.TextStyle(
                                            fontSize: Sizes.Paragraph),
                                      ),
                                    ],
                                  ),
                                  pw.SizedBox(width: 5),
                                  pw.Row(
                                    children: [
                                      // Address Icon.
                                      pw.Icon(const pw.IconData(0xe0c8),
                                          size: 20, color: Sizes.bgColor2),
                                      pw.Expanded(
                                        child: pw.Text(
                                          '${widget.profile['address']}',
                                          style: pw.TextStyle(
                                              fontSize: Sizes.Paragraph),
                                        ),
                                      ),
                                    ],
                                  ),
                                  pw.SizedBox(width: 5),
                                  pw.Row(
                                    children: [
                                      // Email Icon.
                                      pw.Icon(const pw.IconData(0xe0e6),
                                          size: 20, color: Sizes.bgColor2),
                                      pw.Expanded(
                                        child: pw.Text(
                                          '${widget.profile['email']}',
                                          style: pw.TextStyle(
                                              fontSize: Sizes.Paragraph),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // References
                          pw.SizedBox(height: 15),
                          widget.flag1
                              ? pw.Column(
                                  children: [
                                    pw.Padding(
                                      padding: const pw.EdgeInsets.only(left: 10),
                                      child: pw.Row(
                                        children: [
                                          pw.Container(
                                            height: 8,
                                            width: 8,
                                            decoration: pw.BoxDecoration(
                                              borderRadius:
                                                  pw.BorderRadius.circular(4),
                                              border: pw.Border.all(
                                                  color: Sizes.bgColor2),
                                              color: Sizes.bgColor2,
                                            ),
                                          ),
                                          pw.SizedBox(width: 5),
                                          pw.Text(
                                            'Reference',
                                            style: pw.TextStyle(
                                              fontSize: Sizes.Heading,
                                              fontWeight: pw.FontWeight.bold,
                                              color: PdfColors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    pw.SizedBox(width: 5),
                                    pw.Padding(
                                      padding: const pw.EdgeInsets.only(left: 14),
                                      child: pw.Container(
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border(
                                            left: pw.BorderSide(
                                                color: Sizes.bgColor2),
                                          ),
                                        ),
                                        child: pw.ListView.builder(
                                          itemCount: widget.reference.length,
                                          itemBuilder: (context, index) {
                                            return pw.Column(
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.start,
                                              children: [
                                                pw.Container(
                                                  padding: const pw.EdgeInsets.only(
                                                      left: 10),
                                                  child: pw.Text(
                                                    '${widget.reference[index]['reference']}',
                                                    style: pw.TextStyle(
                                                        fontSize:
                                                            Sizes.Subheading,
                                                        fontWeight:
                                                            pw.FontWeight.bold),
                                                  ),
                                                ),
                                                pw.Container(
                                                  padding: const pw.EdgeInsets.only(
                                                      left: 10),
                                                  child: pw.Text(
                                                    '${widget.reference[index]['job']}',
                                                    style: pw.TextStyle(
                                                        fontSize:
                                                            Sizes.Paragraph),
                                                  ),
                                                ),
                                                pw.Container(
                                                  padding: const pw.EdgeInsets.only(
                                                      left: 10),
                                                  child: pw.Text(
                                                    '${widget.reference[index]['company']}',
                                                    style: pw.TextStyle(
                                                        fontSize:
                                                            Sizes.Paragraph),
                                                  ),
                                                ),
                                                pw.Container(
                                                  padding: const pw.EdgeInsets.only(
                                                      left: 10),
                                                  child: pw.Text(
                                                    '${widget.reference[index]['email']}',
                                                    style: pw.TextStyle(
                                                        fontSize:
                                                            Sizes.Paragraph),
                                                  ),
                                                ),
                                                pw.Container(
                                                  padding: const pw.EdgeInsets.only(
                                                      left: 10),
                                                  child: pw.Text(
                                                    '${widget.reference[index]['phoneNumber']}',
                                                    style: pw.TextStyle(
                                                        fontSize:
                                                            Sizes.Paragraph),
                                                  ),
                                                ),
                                                pw.Container(
                                                  padding:
                                                      const pw.EdgeInsets.symmetric(
                                                          horizontal: 25),
                                                  child: pw.Divider(
                                                    thickness: 1,
                                                    color: Sizes.bgColor2,
                                                  ),
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : pw.Center(child: pw.Text('')),

                          pw.SizedBox(height: 15),

                          // Languages
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(left: 10),
                            child: pw.Row(
                              children: [
                                pw.Container(
                                  height: 8,
                                  width: 8,
                                  decoration: pw.BoxDecoration(
                                    borderRadius: pw.BorderRadius.circular(4),
                                    border:
                                        pw.Border.all(color: Sizes.bgColor2),
                                    color: Sizes.bgColor2,
                                  ),
                                ),
                                pw.SizedBox(width: 5),
                                pw.Text(
                                  'Languages',
                                  style: pw.TextStyle(
                                    fontSize: Sizes.Heading,
                                    fontWeight: pw.FontWeight.bold,
                                    color: PdfColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          pw.SizedBox(width: 5),
                          pw.Padding(
                            padding: const pw.EdgeInsets.fromLTRB(14, 0, 0, 10),
                            child: pw.Container(
                              padding: const pw.EdgeInsets.only(left: 10),
                              decoration: pw.BoxDecoration(
                                border: pw.Border(
                                  left: pw.BorderSide(color: Sizes.bgColor2),
                                ),
                              ),
                              child: pw.Wrap(
                                spacing: 5, // Adjust spacing as needed
                                runSpacing: 5, // Adjust runSpacing as needed
                                alignment: pw.WrapAlignment.start,
                                children: List.generate(
                                  widget.languages.length,
                                  // Replace with the actual item count you want to display
                                  (index) {
                                    String language =
                                        widget.languages[index]['language'];
                                    // Return your list item widget here
                                    // For example:
                                    return pw.Row(
                                      children: [
                                        pw.Container(
                                          width: 6,
                                          height: 6,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                color: Sizes.bgColor2),
                                            borderRadius:
                                                pw.BorderRadius.circular(3),
                                          ),
                                        ),
                                        pw.SizedBox(width: 5),
                                        pw.Expanded(
                                          child: pw.Text(
                                            language,
                                            style: pw.TextStyle(
                                                fontSize: Sizes.Paragraph),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                pw.Expanded(
                  flex: 2,
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.only(top: 25),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        // Objective
                        pw.SizedBox(width: 5),
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(left: 10),
                          child: pw.Row(
                            children: [
                              pw.Container(
                                height: 8,
                                width: 8,
                                decoration: pw.BoxDecoration(
                                  borderRadius: pw.BorderRadius.circular(4),
                                  border: pw.Border.all(color: Sizes.bgColor2),
                                  color: Sizes.bgColor2,
                                ),
                              ),
                              pw.SizedBox(width: 5),
                              pw.Text(
                                'About Me',
                                style: pw.TextStyle(
                                  fontSize: Sizes.Heading,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(left: 14),
                          child: pw.Container(
                            decoration: pw.BoxDecoration(
                              border: pw.Border(
                                left: pw.BorderSide(color: Sizes.bgColor2),
                              ),
                            ),
                            padding: const pw.EdgeInsets.fromLTRB(25, 5, 0, 5),
                            child: pw.Text(
                              '${widget.objective['objective']}',
                              style: pw.TextStyle(fontSize: Sizes.Paragraph),
                            ),
                          ),
                        ),
                        pw.SizedBox(height: 10),

                        // Education
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(left: 10),
                          child: pw.Row(
                            children: [
                              pw.Container(
                                height: 8,
                                width: 8,
                                decoration: pw.BoxDecoration(
                                  borderRadius: pw.BorderRadius.circular(4),
                                  border: pw.Border.all(color: Sizes.bgColor2),
                                  color: Sizes.bgColor2,
                                ),
                              ),
                              pw.SizedBox(width: 10),
                              pw.Text(
                                'EDUCATION',
                                style: pw.TextStyle(
                                  fontSize: Sizes.Heading,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        pw.SizedBox(width: 5),
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(left: 14),
                          child: pw.Container(
                            decoration: pw.BoxDecoration(
                              border: pw.Border(
                                left: pw.BorderSide(color: Sizes.bgColor2),
                              ),
                            ),
                            child: pw.ListView.builder(
                              itemCount: widget.education.length,
                              itemBuilder: (context, index) {
                                return pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Container(
                                      padding: const pw.EdgeInsets.only(left: 25),
                                      child: pw.Text(
                                        '${widget.education[index]['degree']}',
                                        style: pw.TextStyle(
                                            fontSize: Sizes.Subheading,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                    ),
                                    pw.Container(
                                      padding: const pw.EdgeInsets.only(left: 25),
                                      child: pw.Text(
                                        '${widget.education[index]['institute']}',
                                        style: pw.TextStyle(
                                            fontSize: Sizes.Paragraph),
                                      ),
                                    ),
                                    pw.Container(
                                      padding: const pw.EdgeInsets.only(left: 25),
                                      child: pw.Text(
                                        '${widget.education[index]['university']}',
                                        style: pw.TextStyle(
                                            fontSize: Sizes.Paragraph),
                                      ),
                                    ),
                                    pw.Container(
                                      padding: const pw.EdgeInsets.only(left: 25),
                                      child: pw.Text(
                                        '${widget.education[index]['startdate']}-${widget.education[index]['enddate']}',
                                        style: pw.TextStyle(
                                            fontSize: Sizes.Paragraph),
                                      ),
                                    ),
                                    pw.Container(
                                      padding: const pw.EdgeInsets.symmetric(
                                          horizontal: 25),
                                      child: pw.Divider(
                                          thickness: 1, color: Sizes.bgColor2),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        pw.SizedBox(height: 10),

                        // Experiences
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(left: 10),
                          child: pw.Row(
                            children: [
                              pw.Container(
                                height: 8,
                                width: 8,
                                decoration: pw.BoxDecoration(
                                  borderRadius: pw.BorderRadius.circular(4),
                                  border: pw.Border.all(color: Sizes.bgColor2),
                                  color: Sizes.bgColor2,
                                ),
                              ),
                              pw.SizedBox(width: 5),
                              pw.Text(
                                'EXPERIENCES',
                                style: pw.TextStyle(
                                  fontSize: Sizes.Heading,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        pw.SizedBox(width: 5),
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(left: 14),
                          child: pw.Container(
                            decoration: pw.BoxDecoration(
                              border: pw.Border(
                                left: pw.BorderSide(color: Sizes.bgColor2),
                              ),
                            ),
                            child: pw.ListView.builder(
                              itemCount: widget.experience.length,
                              itemBuilder: (context, index) {
                                return pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Container(
                                      padding: const pw.EdgeInsets.only(left: 25),
                                      child: pw.Text(
                                        '${widget.experience[index]['company']}',
                                        style: pw.TextStyle(
                                            fontSize: Sizes.Subheading),
                                      ),
                                    ),
                                    pw.Container(
                                      padding: const pw.EdgeInsets.only(left: 25),
                                      child: pw.Text(
                                        '${widget.experience[index]['job']}',
                                        style: pw.TextStyle(
                                            fontSize: Sizes.Paragraph),
                                      ),
                                    ),
                                    pw.Container(
                                      padding: const pw.EdgeInsets.only(left: 25),
                                      child: pw.Text(
                                        '${widget.experience[index]['details']}',
                                        style: pw.TextStyle(
                                            fontSize: Sizes.Paragraph),
                                      ),
                                    ),
                                    pw.Container(
                                      padding: const pw.EdgeInsets.only(left: 25),
                                      child: pw.Text(
                                        '${widget.experience[index]['startdate']}-${widget.experience[index]['enddate']}',
                                        style: pw.TextStyle(
                                            fontSize: Sizes.Paragraph),
                                      ),
                                    ),
                                    pw.Container(
                                      padding: const pw.EdgeInsets.symmetric(
                                          horizontal: 25),
                                      child: pw.Divider(
                                          thickness: 1, color: Sizes.bgColor2),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        // Skills
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(left: 10),
                          child: pw.Row(
                            children: [
                              pw.Container(
                                height: 8,
                                width: 8,
                                decoration: pw.BoxDecoration(
                                  borderRadius: pw.BorderRadius.circular(4),
                                  border: pw.Border.all(color: Sizes.bgColor2),
                                  color: Sizes.bgColor2,
                                ),
                              ),
                              pw.SizedBox(width: 5),
                              pw.Text(
                                'SKILLS',
                                style: pw.TextStyle(
                                  fontSize: Sizes.Heading,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        pw.SizedBox(width: 5),
                        pw.Padding(
                          padding: const pw.EdgeInsets.fromLTRB(14, 0, 0, 10),
                          child: pw.Container(
                            padding: const pw.EdgeInsets.only(left: 10),
                            decoration: pw.BoxDecoration(
                              border: pw.Border(
                                left: pw.BorderSide(color: Sizes.bgColor2),
                              ),
                            ),
                            child: pw.Wrap(
                              spacing: 5,
                              runSpacing: 5,
                              alignment: pw.WrapAlignment.start,
                              children: List.generate(
                                widget.skills.length,
                                (index) {
                                  String skill = widget.skills[index]['skill'];
                                  return pw.Row(
                                    children: [
                                      pw.Container(
                                        width: 6,
                                        height: 6,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              color: Sizes.bgColor2),
                                          borderRadius:
                                              pw.BorderRadius.circular(3),
                                        ),
                                      ),
                                      pw.SizedBox(width: 5),
                                      pw.Expanded(
                                        child: pw.Text(
                                          skill,
                                          style: pw.TextStyle(
                                              fontSize: Sizes.Subheading),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        pw.SizedBox(height: 10),
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
  }

  @override
  void initState() {
    super.initState();
    Sizes.setBgColor1(Colors.black);
  }

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
              // UI Design
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.36,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Circle Image
                    Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.04),
                      child: Center(
                          child: ClipOval(
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
                      )),
                    ),

                    // First Name and Last Name and Profession.
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: Stack(
                        children: [
                          Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Sizes.bgColor1),
                              color: Sizes.bgColor1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Container(
                              padding: const EdgeInsets.only(left: 4),
                              decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(color: Sizes.bgColor1))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 15),
                                      child: Text(
                                          '${widget.profile['firstName']}\n${widget.profile['lastName']}',
                                          style: TextStyle(
                                              fontSize: Sizes.Heading + 4,
                                              fontWeight: FontWeight.bold))),
                                  Container(
                                    child: Text(
                                      '${widget.profile['objective']}',
                                      style:
                                          TextStyle(fontSize: Sizes.Subheading),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    // About Me
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Sizes.bgColor1),
                              color: Sizes.bgColor1,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'About Me',
                            style: TextStyle(
                              fontSize: Sizes.Heading,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Container(
                        padding: const EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(color: Sizes.bgColor1),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 20,
                                  color: Sizes.bgColor1,
                                ),
                                Text(
                                  '${widget.profile['phoneNumber']}',
                                  style: TextStyle(
                                    fontSize: Sizes.Paragraph,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  size: 20,
                                  color: Sizes.bgColor1,
                                ),
                                Expanded(
                                  child: Text(
                                    '${widget.profile['address']}',
                                    style: TextStyle(
                                      fontSize: Sizes.Paragraph,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.alternate_email_sharp,
                                  size: 20,
                                  color: Sizes.bgColor1,
                                ),
                                Expanded(
                                  child: Text(
                                    '${widget.profile['email']}',
                                    style: TextStyle(
                                      fontSize: Sizes.Paragraph,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // References
                    const SizedBox(
                      height: 15,
                    ),
                    widget.flag1
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(children: [
                                  Container(
                                    height: 8,
                                    width: 8,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: Sizes.bgColor1),
                                      color: Sizes.bgColor1,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Reference',
                                    style: TextStyle(
                                      fontSize: Sizes.Heading,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 14),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        color: Sizes.bgColor1,
                                      ),
                                    ),
                                  ),
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    // Disable scrolling
                                    shrinkWrap: true,
                                    itemCount: widget.reference.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                                '${widget.reference[index]['reference']}',
                                                style: TextStyle(
                                                    fontSize: Sizes.Subheading,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                                '${widget.reference[index]['job']}',
                                                style: TextStyle(
                                                    fontSize: Sizes.Paragraph)),
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                                '${widget.reference[index]['company']}',
                                                style: TextStyle(
                                                    fontSize: Sizes.Paragraph)),
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                                '${widget.reference[index]['email']}',
                                                style: TextStyle(
                                                    fontSize: Sizes.Paragraph)),
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                                '${widget.reference[index]['phoneNumber']}',
                                                style: TextStyle(
                                                    fontSize: Sizes.Paragraph)),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 25),
                                            child: Divider(
                                              thickness: 1,
                                              color: Sizes.bgColor1,
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const Center(
                            child: Text(''),
                          ),

                    const SizedBox(
                      height: 15,
                    ),

                    // Languages
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                4,
                              ),
                              border: Border.all(
                                color: Sizes.bgColor1,
                              ),
                              color: Sizes.bgColor1,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Languages',
                            style: TextStyle(
                              fontSize: Sizes.Heading,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 0, 10),
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(color: Sizes.bgColor1),
                            ),
                          ),
                          child: Wrap(
                            spacing: 5, // Adjust spacing as needed
                            runSpacing: 5, // Adjust runSpacing as needed
                            alignment: WrapAlignment.start,
                            children: List.generate(
                              widget.languages.length,
                              // Replace with the actual item count you want to display
                              (index) {
                                String language =
                                    widget.languages[index]['language'];
                                // Return your list item widget here
                                // For example:
                                return Row(
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Sizes.bgColor1),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        language,
                                        style: TextStyle(
                                            fontSize: Sizes.Paragraph),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.62,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Objective
                    const SizedBox(width: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(children: [
                        Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Sizes.bgColor1),
                            color: Sizes.bgColor1,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'About Me',
                          style: TextStyle(
                            fontSize: Sizes.Heading,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(color: Sizes.bgColor1),
                          ),
                        ),
                        padding: const EdgeInsets.fromLTRB(25, 5, 0, 5),
                        child: Text(
                          '${widget.objective['objective']}',
                          style: TextStyle(fontSize: Sizes.Paragraph),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // Education
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(children: [
                        Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Sizes.bgColor1),
                            color: Sizes.bgColor1,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'EDUCATION',
                          style: TextStyle(
                            fontSize: Sizes.Heading,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ]),
                    ),
                    const SizedBox(width: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(color: Sizes.bgColor1),
                          ),
                        ),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          // Disable scrolling
                          shrinkWrap: true,
                          itemCount: widget.education.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Text(
                                      '${widget.education[index]['degree']}',
                                      style: TextStyle(
                                          fontSize: Sizes.Subheading,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Text(
                                    '${widget.education[index]['institute']}',
                                    style: TextStyle(fontSize: Sizes.Paragraph),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Text(
                                    '${widget.education[index]['university']}',
                                    style: TextStyle(fontSize: Sizes.Paragraph),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Text(
                                      '${widget.education[index]['startdate']}-${widget.education[index]['enddate']}',
                                      style:
                                          TextStyle(fontSize: Sizes.Paragraph)),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: Divider(
                                    thickness: 1,
                                    color: Sizes.bgColor1,
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // Experiences
                    Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(children: [
                          Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Sizes.bgColor1),
                              color: Sizes.bgColor1,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'EXPERIENCES',
                            style: TextStyle(
                              fontSize: Sizes.Heading,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ])),
                    const SizedBox(width: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(color: Sizes.bgColor1),
                          ),
                        ),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          // Disable scrolling
                          shrinkWrap: true,
                          itemCount: widget.experience.length,
                          // Replace with the actual item count you want to display
                          itemBuilder: (context, index) {
                            // Return your list item widget here
                            // For example:
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Text(
                                    '${widget.experience[index]['company']}',
                                    style:
                                        TextStyle(fontSize: Sizes.Subheading),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Text(
                                    '${widget.experience[index]['job']}',
                                    style: TextStyle(fontSize: Sizes.Paragraph),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Text(
                                    '${widget.experience[index]['details']}',
                                    style: TextStyle(fontSize: Sizes.Paragraph),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Text(
                                    '${widget.experience[index]['startdate']}-${widget.experience[index]['enddate']}',
                                    style: TextStyle(fontSize: Sizes.Paragraph),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: Divider(
                                    thickness: 1,
                                    color: Sizes.bgColor1,
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ),

                    // Skills
                    Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(children: [
                          Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Sizes.bgColor1),
                              color: Sizes.bgColor1,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'SKILLS',
                            style: TextStyle(
                              fontSize: Sizes.Heading,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ])),
                    const SizedBox(width: 5),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 0, 10),
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              border: Border(
                                  left: BorderSide(color: Sizes.bgColor1))),
                          child: Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            alignment: WrapAlignment.start,
                            children: List.generate(
                              widget.skills.length,
                              // Replace with the actual item count you want to display
                              (index) {
                                String skill = widget.skills[index]['skill'];
                                // Return your list item widget here
                                return Row(
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Sizes.bgColor1),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Text(skill,
                                          style: TextStyle(
                                              fontSize: Sizes.Subheading)),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
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
