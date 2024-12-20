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

class Template5 extends StatefulWidget {
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

  Template5({
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
  _Template5State createState() => _Template5State();
}

class _Template5State extends State<Template5> {
  PdfColor myColor = PdfColor.fromHex('#ff4dff');
  double headingsize = 0;
  double txtsize = 0;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Sizes.setBgColor1(Colors.black);
  }

  // Async Function to fetch image from assets.
  Future<Uint8List> getImageDataFromAsset(String assetName) async {
    try {
      final ByteData data = await rootBundle.load(assetName);
      return data.buffer.asUint8List();
    } catch (e) {
      print('Error loading image data: $e');
      rethrow;
    }
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

    // To get Image into variables by using function.
    final phoneCallIcon =
        await getImageDataFromAsset('assets/icons_white/phone_call.png');

    final placeHolderIcon =
        await getImageDataFromAsset('assets/icons_white/placeholder.png');

    final sendLetterIcon =
        await getImageDataFromAsset('assets/icons_white/send_letter_icon.png');

    Sizes sizes = new Sizes(context);
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(5),
        build: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 3),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Pdf Design Code Starts from Here.
                // Top name, profession and contact.
                pw.Container(
                  padding: const pw.EdgeInsets.symmetric(
                    vertical: 7.0,
                    horizontal: 14.0,
                  ),
                  height: 140,
                  width: double.infinity,
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      //Name
                      pw.Text(
                        '${widget.profile['firstName']} ${widget.profile['lastName']}',
                        style: pw.TextStyle(
                          fontSize: Sizes.Heading + 14,
                          fontWeight: pw.FontWeight.bold,
                          color: Sizes.bgColor2,
                        ),
                      ),
                      //Profession and Contact.
                      pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          // Profession
                          pw.Expanded(
                            child: pw.Text(
                              "${widget.profile['objective']}",
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                fontSize: Sizes.Subheading + 2,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                          // Contact
                          pw.Expanded(
                            child: pw.Container(
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  // Phone Number
                                  pw.Row(
                                    children: [
                                      pw.Container(
                                        width: 7,
                                        height: 7,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                            color: Sizes.bgColor2,
                                          ),
                                          borderRadius:
                                              pw.BorderRadius.circular(
                                            3,
                                          ),
                                        ),
                                      ),
                                      pw.SizedBox(width: 7),
                                      pw.Flexible(
                                        child: pw.Text(
                                          '${widget.profile['phoneNumber']}',
                                          style: pw.TextStyle(
                                            fontSize: Sizes.Paragraph,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Email.
                                  pw.Row(
                                    children: [
                                      pw.Container(
                                        width: 7,
                                        height: 7,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                            color: Sizes.bgColor2,
                                          ),
                                          borderRadius:
                                              pw.BorderRadius.circular(
                                            3,
                                          ),
                                        ),
                                      ),
                                      pw.SizedBox(width: 7),
                                      pw.Flexible(
                                        child: pw.Text(
                                          '${widget.profile['email']}',
                                          style: pw.TextStyle(
                                            fontSize: Sizes.Paragraph,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Address.
                                  pw.Row(
                                    children: [
                                      pw.Container(
                                        width: 7,
                                        height: 7,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                            color: Sizes.bgColor2,
                                          ),
                                          borderRadius:
                                              pw.BorderRadius.circular(
                                            3,
                                          ),
                                        ),
                                      ),
                                      pw.SizedBox(width: 7),
                                      pw.Flexible(
                                        child: pw.Text(
                                          '${widget.profile['address']}',
                                          style: pw.TextStyle(
                                            fontSize: Sizes.Paragraph,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                //Bottom Content.
                pw.Container(
                  padding: pw.EdgeInsets.only(top: 7.0),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(
                      top: pw.BorderSide(
                        color: Sizes.bgColor2,
                      ),
                    ),
                  ),
                  child: pw.SizedBox(
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        // Left Content
                        pw.Expanded(
                          flex: 2,
                          child: pw.Column(
                            children: [
                              // Picture.
                              pw.SizedBox(
                                height: 350,
                                width: 350,
                                child: pw.Image(
                                  pw.MemoryImage(imageData!),
                                  fit: pw.BoxFit.fill,
                                ),
                              ),

                              pw.SizedBox(height: 3.5),

                              // Contacts.
                              pw.Container(
                                height: 42,
                                color: Sizes.bgColor2,
                                child: pw.Center(
                                  child: pw.Text(
                                    'Contact',
                                    style: pw.TextStyle(
                                      fontSize: Sizes.Heading,
                                      fontWeight: pw.FontWeight.bold,
                                      color: Sizes.bgColor4,
                                    ),
                                  ),
                                ),
                              ),
                              pw.SizedBox(height: 3.5),
                              pw.Container(
                                padding: pw.EdgeInsets.all(7.0),
                                color: Sizes.bgColor2,
                                child: pw.Column(
                                  children: [
                                    // Contact.
                                    pw.Row(
                                      children: [
                                        pw.Text(
                                          "Contact: ",
                                          style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                            color: Sizes.bgColor4,
                                          ),
                                        ),
                                        pw.Flexible(
                                          child: pw.Text(
                                            '${widget.profile['phoneNumber']}',
                                            style: pw.TextStyle(
                                              fontSize: Sizes.Paragraph,
                                              color: Sizes.bgColor4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Email.
                                    pw.Row(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(
                                          "Email: ",
                                          style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                            color: Sizes.bgColor4,
                                          ),
                                        ),
                                        pw.Flexible(
                                          child: pw.Text(
                                            '${widget.profile['email']}',
                                            style: pw.TextStyle(
                                              fontSize: Sizes.Paragraph,
                                              color: Sizes.bgColor4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Address.
                                    pw.Row(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(
                                          "Address: ",
                                          style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.bold,
                                            color: Sizes.bgColor4,
                                          ),
                                        ),
                                        pw.Flexible(
                                          child: pw.Text(
                                            '${widget.profile['address']}',
                                            style: pw.TextStyle(
                                              fontSize: Sizes.Paragraph,
                                              color: Sizes.bgColor4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // Skills.
                              pw.Container(
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      'Skills',
                                      style: pw.TextStyle(
                                        fontSize: Sizes.Heading,
                                        fontWeight: pw.FontWeight.bold,
                                        color: Sizes.bgColor2,
                                      ),
                                    ),
                                    pw.Container(
                                      padding: pw.EdgeInsets.all(7),
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border(
                                          top: pw.BorderSide(
                                              color: Sizes.bgColor2),
                                        ),
                                      ),
                                      child: pw.Wrap(
                                        spacing: 7,
                                        runSpacing: 7,
                                        alignment: pw.WrapAlignment.start,
                                        children: List.generate(
                                          widget.skills.length,
                                          // Replace with the actual item count you want to display
                                          (index) {
                                            String skill =
                                                widget.skills[index]['skill'];
                                            // Return your list item widget here
                                            return pw.Row(
                                              children: [
                                                pw.Container(
                                                  width: 7,
                                                  height: 7,
                                                  decoration: pw.BoxDecoration(
                                                    border: pw.Border.all(
                                                      color: Sizes.bgColor2,
                                                    ),
                                                    borderRadius:
                                                        pw.BorderRadius
                                                            .circular(3),
                                                  ),
                                                ),
                                                pw.SizedBox(width: 7),
                                                pw.Flexible(
                                                  child: pw.Text(
                                                    skill,
                                                    style: pw.TextStyle(
                                                      fontSize:
                                                          Sizes.Subheading,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Languages.
                              pw.Container(
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      'Languages',
                                      style: pw.TextStyle(
                                        fontSize: Sizes.Heading,
                                        fontWeight: pw.FontWeight.bold,
                                        color: Sizes.bgColor2,
                                      ),
                                    ),
                                    pw.Container(
                                      padding: pw.EdgeInsets.all(7),
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border(
                                          top: pw.BorderSide(
                                              color: Sizes.bgColor2),
                                        ),
                                      ),
                                      child: pw.Wrap(
                                        spacing: 7,
                                        runSpacing: 7,
                                        alignment: pw.WrapAlignment.start,
                                        children: List.generate(
                                          widget.skills.length,
                                          // Replace with the actual item count you want to display
                                          (index) {
                                            String skill = widget
                                                .languages[index]['language'];
                                            // Return your list item widget here
                                            return pw.Row(
                                              children: [
                                                pw.Container(
                                                  width: 7,
                                                  height: 7,
                                                  decoration: pw.BoxDecoration(
                                                    border: pw.Border.all(
                                                      color: Sizes.bgColor2,
                                                    ),
                                                    borderRadius:
                                                        pw.BorderRadius
                                                            .circular(3),
                                                  ),
                                                ),
                                                pw.SizedBox(width: 7),
                                                pw.Flexible(
                                                  child: pw.Text(
                                                    skill,
                                                    style: pw.TextStyle(
                                                      fontSize:
                                                          Sizes.Subheading,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        pw.SizedBox(width: 14),

                        // Right Content.
                        pw.Expanded(
                          flex: 1,
                          child: pw.Column(
                            children: [
                              // About Me.
                              pw.Container(
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      'About Me',
                                      style: pw.TextStyle(
                                        fontSize: Sizes.Heading,
                                        fontWeight: pw.FontWeight.bold,
                                        color: Sizes.bgColor2,
                                      ),
                                    ),
                                    pw.Container(
                                      padding: pw.EdgeInsets.all(7),
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border(
                                          top: pw.BorderSide(
                                              color: Sizes.bgColor2),
                                        ),
                                      ),
                                      child: pw.Flexible(
                                        child: pw.Text(
                                          '${widget.objective['objective']}',
                                          style: pw.TextStyle(
                                            fontSize: Sizes.Paragraph,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Education.
                              pw.Container(
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      'Education',
                                      style: pw.TextStyle(
                                        fontSize: Sizes.Heading,
                                        fontWeight: pw.FontWeight.bold,
                                        color: Sizes.bgColor2,
                                      ),
                                    ),
                                    pw.Container(
                                      padding: pw.EdgeInsets.all(7),
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border(
                                          top: pw.BorderSide(
                                              color: Sizes.bgColor2),
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
                                                padding:
                                                const pw.EdgeInsets.only(left: 25),
                                                child: pw.Text(
                                                    '${widget.education[index]['degree']}',
                                                    style: pw.TextStyle(
                                                        fontSize: Sizes.Subheading,
                                                        fontWeight: pw.FontWeight.bold)),
                                              ),
                                              pw.Container(
                                                padding:
                                                const pw.EdgeInsets.only(left: 25),
                                                child: pw.Text(
                                                  '${widget.education[index]['institute']}',
                                                  style: pw.TextStyle(
                                                      fontSize: Sizes.Paragraph),
                                                ),
                                              ),
                                              pw.Container(
                                                padding:
                                                const pw.EdgeInsets.only(left: 25),
                                                child: pw.Text(
                                                  '${widget.education[index]['university']}',
                                                  style: pw.TextStyle(
                                                      fontSize: Sizes.Paragraph),
                                                ),
                                              ),
                                              pw.Container(
                                                padding:
                                                const pw.EdgeInsets.only(left: 25),
                                                child: pw.Text(
                                                    '${widget.education[index]['startdate']}-${widget.education[index]['enddate']}',
                                                    style: pw.TextStyle(
                                                        fontSize: Sizes.Paragraph)),
                                              ),
                                              pw.Container(
                                                padding: const pw.EdgeInsets.symmetric(
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
                                  ],
                                ),
                              ),

                              // Experience.
                              pw.Container(
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      'Work Experience',
                                      style: pw.TextStyle(
                                        fontSize: Sizes.Heading,
                                        fontWeight: pw.FontWeight.bold,
                                        color: Sizes.bgColor2,
                                      ),
                                    ),
                                    pw.Container(
                                      padding: pw.EdgeInsets.all(7),
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border(
                                          top: pw.BorderSide(
                                            color: Sizes.bgColor2,
                                          ),
                                        ),
                                      ),
                                      child: pw.ListView.builder(
                                        itemCount: widget.experience.length,
                                        // Replace with the actual item count you want to display
                                        itemBuilder: (context, index) {
                                          // Return your list item widget here
                                          // For example:
                                          return pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Row(
                                                children: [
                                                  pw.Container(
                                                    width: 7,
                                                    height: 7,
                                                    decoration:
                                                        pw.BoxDecoration(
                                                      border: pw.Border.all(
                                                        color: Sizes.bgColor2,
                                                      ),
                                                      borderRadius:
                                                          pw.BorderRadius
                                                              .circular(
                                                        3,
                                                      ),
                                                    ),
                                                  ),
                                                  pw.SizedBox(width: 7),
                                                  pw.Container(
                                                    child: pw.Flexible(
                                                      child: pw.Text(
                                                        '${widget.experience[index]['company']}',
                                                        style: pw.TextStyle(
                                                          fontSize:
                                                              Sizes.Subheading,
                                                          fontWeight: pw
                                                              .FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              pw.Text(
                                                '${widget.experience[index]['startdate']}-${widget.experience[index]['enddate']}',
                                                style: pw.TextStyle(
                                                  fontSize: Sizes.Paragraph,
                                                ),
                                              ),
                                              pw.Text(
                                                '${widget.experience[index]['job']}',
                                                style: pw.TextStyle(
                                                  fontSize: Sizes.Paragraph,
                                                ),
                                              ),
                                              pw.Text(
                                                '${widget.experience[index]['details']}',
                                                style: pw.TextStyle(
                                                  fontSize: Sizes.Paragraph,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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
          style: TextStyle(
            color: sizes.AppBartextColor,
            fontSize: sizes.fontSize,
          ),
        ),
        centerTitle: true,
        backgroundColor: Sizes.bgColor1,
        toolbarHeight: sizes.barSize,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 7,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Code of UI.

              // Top name, profession and contact.
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 7.0,
                  horizontal: 14.0,
                ),
                height: 140,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Name
                    Text(
                      '${widget.profile['firstName']} ${widget.profile['lastName']}',
                      style: TextStyle(
                        fontSize: Sizes.Heading + 14,
                        fontWeight: FontWeight.bold,
                        color: Sizes.bgColor1,
                      ),
                    ),
                    //Profession and Contact.
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profession
                        Expanded(
                          child: Text(
                            "${widget.profile['objective']}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: Sizes.Subheading + 2,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        // Contact
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Phone Number
                                Row(
                                  children: [
                                    Container(
                                      width: 7,
                                      height: 7,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Sizes.bgColor1,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          3,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 7),
                                    Flexible(
                                      child: Text(
                                        '${widget.profile['phoneNumber']}',
                                        style: TextStyle(
                                          fontSize: Sizes.Paragraph,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Email.
                                Row(
                                  children: [
                                    Container(
                                      width: 7,
                                      height: 7,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Sizes.bgColor1,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          3,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 7),
                                    Flexible(
                                      child: Text(
                                        '${widget.profile['email']}',
                                        style: TextStyle(
                                          fontSize: Sizes.Paragraph,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Address.
                                Row(
                                  children: [
                                    Container(
                                      width: 7,
                                      height: 7,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Sizes.bgColor1,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          3,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 7),
                                    Flexible(
                                      child: Text(
                                        '${widget.profile['address']}',
                                        style: TextStyle(
                                          fontSize: Sizes.Paragraph,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),

              //Bottom Content.
              Container(
                padding: EdgeInsets.only(top: 7.0),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Sizes.bgColor1,
                    ),
                  ),
                ),
                child: SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left Content
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            // Picture.
                            widget.file != null
                                ? Image.file(
                                    widget.file!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/placeholder.jpg',
                                    fit: BoxFit.fill,
                                  ),
                            SizedBox(height: 3.5),

                            // Contacts.
                            Container(
                              height: 42,
                              color: Sizes.bgColor1,
                              child: Center(
                                child: Text(
                                  'Contact',
                                  style: TextStyle(
                                    fontSize: Sizes.Heading,
                                    fontWeight: FontWeight.bold,
                                    color: Sizes.bgColor3,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 3.5),
                            Container(
                              padding: EdgeInsets.all(7.0),
                              color: Sizes.bgColor1,
                              child: Column(
                                children: [
                                  // Contact.
                                  Row(
                                    children: [
                                      Text(
                                        "Contact: ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Sizes.bgColor3,
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          '${widget.profile['phoneNumber']}',
                                          style: TextStyle(
                                            fontSize: Sizes.Paragraph,
                                            color: Sizes.bgColor3,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Email.
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Email: ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Sizes.bgColor3,
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          '${widget.profile['email']}',
                                          style: TextStyle(
                                            fontSize: Sizes.Paragraph,
                                            color: Sizes.bgColor3,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Address.
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Address: ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Sizes.bgColor3,
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          '${widget.profile['address']}',
                                          style: TextStyle(
                                            fontSize: Sizes.Paragraph,
                                            color: Sizes.bgColor3,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Skills.
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Skills',
                                    style: TextStyle(
                                      fontSize: Sizes.Heading,
                                      fontWeight: FontWeight.bold,
                                      color: Sizes.bgColor1,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(color: Sizes.bgColor1),
                                      ),
                                    ),
                                    child: Wrap(
                                      spacing: 7,
                                      runSpacing: 7,
                                      alignment: WrapAlignment.start,
                                      children: List.generate(
                                        widget.skills.length,
                                        // Replace with the actual item count you want to display
                                        (index) {
                                          String skill =
                                              widget.skills[index]['skill'];
                                          // Return your list item widget here
                                          return Row(
                                            children: [
                                              Container(
                                                width: 7,
                                                height: 7,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Sizes.bgColor1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                ),
                                              ),
                                              const SizedBox(width: 7),
                                              Flexible(
                                                child: Text(
                                                  skill,
                                                  style: TextStyle(
                                                    fontSize: Sizes.Subheading,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Languages.
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Languages',
                                    style: TextStyle(
                                      fontSize: Sizes.Heading,
                                      fontWeight: FontWeight.bold,
                                      color: Sizes.bgColor1,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(color: Sizes.bgColor1),
                                      ),
                                    ),
                                    child: Wrap(
                                      spacing: 7,
                                      runSpacing: 7,
                                      alignment: WrapAlignment.start,
                                      children: List.generate(
                                        widget.skills.length,
                                        // Replace with the actual item count you want to display
                                        (index) {
                                          String skill = widget.languages[index]
                                              ['language'];
                                          // Return your list item widget here
                                          return Row(
                                            children: [
                                              Container(
                                                width: 7,
                                                height: 7,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Sizes.bgColor1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                ),
                                              ),
                                              const SizedBox(width: 7),
                                              Flexible(
                                                child: Text(
                                                  skill,
                                                  style: TextStyle(
                                                    fontSize: Sizes.Subheading,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 14),

                      // Right Content.
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            // About Me.
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'About Me',
                                    style: TextStyle(
                                      fontSize: Sizes.Heading,
                                      fontWeight: FontWeight.bold,
                                      color: Sizes.bgColor1,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(color: Sizes.bgColor1),
                                      ),
                                    ),
                                    child: Flexible(
                                      child: Text(
                                        '${widget.objective['objective']}',
                                        style: TextStyle(
                                          fontSize: Sizes.Paragraph,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Education.
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Education',
                                    style: TextStyle(
                                      fontSize: Sizes.Heading,
                                      fontWeight: FontWeight.bold,
                                      color: Sizes.bgColor1,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(color: Sizes.bgColor1),
                                      ),
                                    ),
                                    child:  ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      // Disable scrolling
                                      shrinkWrap: true,
                                      itemCount: widget.education.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding:
                                              const EdgeInsets.only(left: 25),
                                              child: Text(
                                                  '${widget.education[index]['degree']}',
                                                  style: TextStyle(
                                                      fontSize: Sizes.Subheading,
                                                      fontWeight: FontWeight.bold)),
                                            ),
                                            Container(
                                              padding:
                                              const EdgeInsets.only(left: 25),
                                              child: Text(
                                                '${widget.education[index]['institute']}',
                                                style: TextStyle(
                                                    fontSize: Sizes.Paragraph),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                              const EdgeInsets.only(left: 25),
                                              child: Text(
                                                '${widget.education[index]['university']}',
                                                style: TextStyle(
                                                    fontSize: Sizes.Paragraph),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                              const EdgeInsets.only(left: 25),
                                              child: Text(
                                                  '${widget.education[index]['startdate']}-${widget.education[index]['enddate']}',
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
                                ],
                              ),
                            ),

                            // Experience.
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Work Experience',
                                    style: TextStyle(
                                      fontSize: Sizes.Heading,
                                      fontWeight: FontWeight.bold,
                                      color: Sizes.bgColor1,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(color: Sizes.bgColor1),
                                      ),
                                    ),
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      // Disable scrolling
                                      shrinkWrap: true,
                                      itemCount: widget.experience.length,
                                      // Replace with the actual item count you want to display
                                      itemBuilder: (context, index) {
                                        // Return your list item widget here
                                        // For example:
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 7,
                                                  height: 7,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Sizes.bgColor1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      3,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 7,
                                                ),
                                                Container(
                                                  child: Flexible(
                                                    child: Text(
                                                      '${widget.experience[index]['company']}',
                                                      style: TextStyle(
                                                          fontSize:
                                                              Sizes.Subheading,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              '${widget.experience[index]['startdate']}-${widget.experience[index]['enddate']}',
                                              style: TextStyle(
                                                fontSize: Sizes.Paragraph,
                                              ),
                                            ),
                                            Text(
                                              '${widget.experience[index]['job']}',
                                              style: TextStyle(
                                                fontSize: Sizes.Paragraph,
                                              ),
                                            ),
                                            Text(
                                              '${widget.experience[index]['details']}',
                                              style: TextStyle(
                                                fontSize: Sizes.Paragraph,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          if (_selectedIndex == 0)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                height: 70.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ColorButton(
                      color: Colors.red,
                      onPressed: () {
                        setState(
                          () {
                            Sizes.setBgColor1(
                              Colors.red,
                            );
                          },
                        );
                      },
                    ),
                    ColorButton(
                      color: Colors.green,
                      onPressed: () {
                        setState(
                          () {
                            Sizes.setBgColor1(
                              Colors.green,
                            );
                          },
                        );
                      },
                    ),
                    ColorButton(
                      color: Colors.blue,
                      onPressed: () {
                        setState(
                          () {
                            Sizes.setBgColor1(
                              Colors.blue,
                            );
                          },
                        );
                      },
                    ),
                    ColorButton(
                      color: Colors.yellow,
                      onPressed: () {
                        setState(
                          () {
                            Sizes.setBgColor1(
                              Colors.yellow,
                            );
                          },
                        );
                      },
                    ),
                    ColorButton(
                      color: Colors.orange,
                      onPressed: () {
                        setState(
                          () {
                            Sizes.setBgColor1(
                              Colors.orange,
                            );
                          },
                        );
                      },
                    ),
                    ColorButton(
                      color: Colors.purple,
                      onPressed: () {
                        setState(
                          () {
                            Sizes.setBgColor1(
                              Colors.purple,
                            );
                          },
                        );
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
                                style: TextStyle(
                                  fontSize: sizes.listFontSize,
                                ),
                              ),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: Sizes.bgColor1,
                                  onColorChanged: (
                                    Color color,
                                  ) {
                                    setState(
                                      () {
                                        Sizes.setBgColor1(
                                          color,
                                        );
                                      },
                                    );
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
                                  child: const Text(
                                    ' Ok ',
                                  ),
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (_selectedIndex == 1)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
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
                              setState(
                                () {
                                  if (Sizes.Heading > 14) {
                                    Sizes.decreaseHeading();
                                  }
                                },
                              );
                            },
                            onIncrease: () {
                              setState(
                                () {
                                  if (Sizes.Heading < 16) {
                                    Sizes.increaseHeading();
                                  }
                                },
                              );
                            },
                          ),

                          // SubHeading Size Controls
                          TextSizeControl(
                            label: "SubHeading Size",
                            size: Sizes.Subheading,
                            onDecrease: () {
                              setState(
                                () {
                                  if (Sizes.Subheading > 12) {
                                    Sizes.decreaseSubheading();
                                  }
                                },
                              );
                            },
                            onIncrease: () {
                              setState(
                                () {
                                  if (Sizes.Subheading < 14) {
                                    Sizes.increaseSubheading();
                                  }
                                },
                              );
                            },
                          ),

                          // Paragraph Size Controls
                          TextSizeControl(
                            label: "Paragraph Size",
                            size: Sizes.Paragraph,
                            onDecrease: () {
                              setState(
                                () {
                                  if (Sizes.Paragraph > 10) {
                                    Sizes.decreaseParagraph();
                                  }
                                },
                              );
                            },
                            onIncrease: () {
                              setState(
                                () {
                                  if (Sizes.Paragraph < 11) {
                                    Sizes.increaseParagraph();
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
      padding: const EdgeInsets.all(
        8.0,
      ),
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
        Text(
          "$label: $size",
        ),
        IconButton(
          icon: const Icon(
            Icons.remove,
          ),
          onPressed: onDecrease,
        ),
        IconButton(
          icon: const Icon(
            Icons.add,
          ),
          onPressed: onIncrease,
        ),
      ],
    );
  }
}
