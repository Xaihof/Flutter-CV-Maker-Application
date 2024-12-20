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

class Template3 extends StatefulWidget {
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

  Template3({
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
  _Template3State createState() => _Template3State();
}

class _Template3State extends State<Template3> {
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

                pw.SizedBox(height: 14),
                // Image and Names.
                pw.Row(
                  children: [
                    // Circle Image
                    pw.Container(
                      padding: const pw.EdgeInsets.only(
                        left: 14,
                      ),
                      // Image
                      child: pw.Center(
                        child: pw.ClipOval(
                          child: pw.Container(
                            width: 70,
                            height: 70,
                            child: pw.Image(
                              pw.MemoryImage(imageData!),
                              fit: pw.BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    pw.SizedBox(
                      width: 14,
                    ),
                    // Name and Profession.
                    pw.Container(
                      padding: const pw.EdgeInsets.only(
                        left: 14,
                        right: 14,
                      ),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(
                          top: pw.BorderSide(
                            color: Sizes.bgColor2,
                          ),
                          bottom: pw.BorderSide(
                            color: Sizes.bgColor2,
                          ),
                        ),
                      ),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                            padding: const pw.EdgeInsets.symmetric(
                              vertical: 7,
                            ),
                            child: pw.Text(
                              '${widget.profile['firstName']} ${widget.profile['lastName']}',
                              style: pw.TextStyle(
                                fontSize: Sizes.Heading + 4,
                                fontWeight: pw.FontWeight.bold,
                                color: Sizes.bgColor2,
                              ),
                            ),
                          ),
                          pw.Container(
                            child: pw.Text(
                              '${widget.profile['objective']}',
                              style: pw.TextStyle(
                                fontSize: Sizes.Subheading,
                              ),
                            ),
                          ),
                          pw.SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                pw.SizedBox(
                  height: 14,
                ),
                // Bottom Content.
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    // Left Content.
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          // About Me.
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(
                              left: 7,
                            ),
                            child: pw.Row(
                              children: [
                                // Round Dot.
                                pw.Container(
                                  height: 7,
                                  width: 7,
                                  decoration: pw.BoxDecoration(
                                    borderRadius: pw.BorderRadius.circular(
                                      3.5,
                                    ),
                                    border: pw.Border.all(
                                      color: Sizes.bgColor2,
                                    ),
                                    color: Sizes.bgColor2,
                                  ),
                                ),
                                pw.SizedBox(
                                  width: 7,
                                ),
                                pw.Text(
                                  'About Me',
                                  style: pw.TextStyle(
                                    fontSize: Sizes.Heading,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Sizes.bgColor2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(
                              left: 7,
                            ),
                            child: pw.Container(
                              padding: const pw.EdgeInsets.only(
                                left: 7,
                                top: 7,
                                bottom: 7,
                              ),
                              decoration: pw.BoxDecoration(
                                border: pw.Border(
                                  left: pw.BorderSide(
                                    color: Sizes.bgColor2,
                                  ),
                                ),
                              ),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Row(
                                    children: [
                                      // Phone Number Icon.
                                      pw.Image(
                                        pw.MemoryImage(phoneCallIcon),
                                        // Replace with the path to your PNG image
                                        width: sizes.listiconSize - 6,
                                        // Adjust width as needed
                                        height: sizes.listiconSize - 6,

                                        // Adjust height as needed
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
                                  pw.SizedBox(height: 7),
                                  pw.Row(
                                    children: [
                                      // Address Icon.
                                      pw.Image(
                                        pw.MemoryImage(placeHolderIcon),
                                        // Replace with the path to your PNG image
                                        width: sizes.listiconSize - 6,
                                        // Adjust width as needed
                                        height: sizes.listiconSize - 6,

                                        // Adjust height as needed
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
                                  pw.SizedBox(height: 7),
                                  pw.Row(
                                    // Email Icon
                                    children: [
                                      pw.Image(
                                        pw.MemoryImage(sendLetterIcon),
                                        // Replace with the path to your PNG image
                                        width: sizes.listiconSize - 6,
                                        // Adjust width as needed
                                        height: sizes.listiconSize - 6,

                                        // Adjust height as needed
                                      ),
                                      pw.SizedBox(width: 7),
                                      pw.Flexible(
                                        child: pw.Text(
                                          '${widget.profile['email']}',
                                          style: pw.TextStyle(
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

                          // Work Experience.
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(
                              left: 7,
                            ),
                            child: pw.Row(
                              children: [
                                // Round Dot.
                                pw.Container(
                                  height: 7,
                                  width: 7,
                                  decoration: pw.BoxDecoration(
                                    borderRadius: pw.BorderRadius.circular(
                                      3.5,
                                    ),
                                    border: pw.Border.all(
                                      color: Sizes.bgColor2,
                                    ),
                                    color: Sizes.bgColor2,
                                  ),
                                ),
                                pw.SizedBox(
                                  width: 7,
                                ),
                                pw.Text(
                                  'Work Experiences',
                                  style: pw.TextStyle(
                                    fontSize: Sizes.Heading,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Sizes.bgColor2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(
                              left: 7,
                            ),
                            child: pw.Container(
                              padding: const pw.EdgeInsets.only(
                                left: 7,
                                top: 7,
                                bottom: 7,
                              ),
                              decoration: pw.BoxDecoration(
                                border: pw.Border(
                                  left: pw.BorderSide(
                                    color: Sizes.bgColor2,
                                  ),
                                ),
                              ),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.ListView.builder(
                                    itemCount: widget.experience.length,
                                    // Replace with the actual item count you want to display
                                    itemBuilder: (context, index) {
                                      // Return your list item widget here
                                      // For example:
                                      return pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Container(
                                            child: pw.Text(
                                              '${widget.experience[index]['company']}',
                                              style: pw.TextStyle(
                                                fontSize: Sizes.Subheading,
                                              ),
                                            ),
                                          ),
                                          pw.Container(
                                            child: pw.Text(
                                              '${widget.experience[index]['job']}',
                                              style: pw.TextStyle(
                                                fontSize: Sizes.Paragraph,
                                              ),
                                            ),
                                          ),
                                          pw.Container(
                                            child: pw.Text(
                                              '${widget.experience[index]['details']}',
                                              style: pw.TextStyle(
                                                fontSize: Sizes.Paragraph,
                                              ),
                                            ),
                                          ),
                                          pw.Container(
                                            child: pw.Text(
                                              '${widget.experience[index]['startdate']}-${widget.experience[index]['enddate']}',
                                              style: pw.TextStyle(
                                                fontSize: Sizes.Paragraph,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // References.
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(
                              left: 7,
                            ),
                            child: pw.Row(
                              children: [
                                // Round Dot.
                                pw.Container(
                                  height: 7,
                                  width: 7,
                                  decoration: pw.BoxDecoration(
                                    borderRadius: pw.BorderRadius.circular(
                                      3.5,
                                    ),
                                    border: pw.Border.all(
                                      color: Sizes.bgColor2,
                                    ),
                                    color: Sizes.bgColor2,
                                  ),
                                ),
                                pw.SizedBox(
                                  width: 7,
                                ),
                                pw.Text(
                                  'References',
                                  style: pw.TextStyle(
                                    fontSize: Sizes.Heading,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Sizes.bgColor2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(
                              left: 7,
                            ),
                            child: pw.Container(
                              padding: const pw.EdgeInsets.only(
                                left: 7,
                                top: 7,
                                bottom: 7,
                              ),
                              decoration: pw.BoxDecoration(
                                border: pw.Border(
                                  left: pw.BorderSide(
                                    color: Sizes.bgColor2,
                                  ),
                                ),
                              ),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.ListView.builder(
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
                                                    fontSize: Sizes.Subheading,
                                                    fontWeight:
                                                        pw.FontWeight.bold)),
                                          ),
                                          pw.Container(
                                            padding: const pw.EdgeInsets.only(
                                                left: 10),
                                            child: pw.Text(
                                              '${widget.reference[index]['job']}',
                                              style: pw.TextStyle(
                                                fontSize: Sizes.Paragraph,
                                              ),
                                            ),
                                          ),
                                          pw.Container(
                                            padding: const pw.EdgeInsets.only(
                                                left: 10),
                                            child: pw.Text(
                                              '${widget.reference[index]['company']}',
                                              style: pw.TextStyle(
                                                fontSize: Sizes.Paragraph,
                                              ),
                                            ),
                                          ),
                                          pw.Container(
                                            padding: const pw.EdgeInsets.only(
                                                left: 10),
                                            child: pw.Text(
                                              '${widget.reference[index]['email']}',
                                              style: pw.TextStyle(
                                                fontSize: Sizes.Paragraph,
                                              ),
                                            ),
                                          ),
                                          pw.Container(
                                            padding: const pw.EdgeInsets.only(
                                                left: 10),
                                            child: pw.Text(
                                              '${widget.reference[index]['phoneNumber']}',
                                              style: pw.TextStyle(
                                                fontSize: Sizes.Paragraph,
                                              ),
                                            ),
                                          ),
                                          pw.Container(
                                            padding:
                                                const pw.EdgeInsets.symmetric(
                                              horizontal: 14,
                                            ),
                                            child: pw.Divider(
                                              thickness: 1,
                                              color: Sizes.bgColor2,
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Education.
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(
                              left: 7,
                            ),
                            child: pw.Row(
                              children: [
                                // Round Dot.
                                pw.Container(
                                  height: 7,
                                  width: 7,
                                  decoration: pw.BoxDecoration(
                                    borderRadius: pw.BorderRadius.circular(
                                      3.5,
                                    ),
                                    border: pw.Border.all(
                                      color: Sizes.bgColor2,
                                    ),
                                    color: Sizes.bgColor2,
                                  ),
                                ),
                                pw.SizedBox(
                                  width: 7,
                                ),
                                pw.Text(
                                  'Eduaction',
                                  style: pw.TextStyle(
                                    fontSize: Sizes.Heading,
                                    fontWeight: pw.FontWeight.bold,
                                    color: Sizes.bgColor2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(
                              left: 7,
                            ),
                            child: pw.Container(
                              padding: const pw.EdgeInsets.only(
                                left: 7,
                                top: 7,
                                bottom: 7,
                              ),
                              decoration: pw.BoxDecoration(
                                border: pw.Border(
                                  left: pw.BorderSide(
                                    color: Sizes.bgColor2,
                                  ),
                                ),
                              ),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.ListView.builder(
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
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Right Content
                    pw.Column(
                      children: [
                        // About.
                        pw.Container(
                          padding: const pw.EdgeInsets.all(
                            7,
                          ),
                          width: 140,
                          color: Sizes.bgColor2,
                          child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                'CONTACT',
                                style: pw.TextStyle(
                                  fontSize: Sizes.Heading,
                                  fontWeight: pw.FontWeight.bold,
                                  color: Sizes.bgColor4,
                                ),
                              ),
                              pw.SizedBox(
                                height: 7,
                              ),
                              pw.Row(
                                children: [
                                  // Phone Number Icon.
                                  pw.Image(
                                    pw.MemoryImage(phoneCallIcon),
                                    // Replace with the path to your PNG image
                                    width: sizes.listiconSize - 6,
                                    // Adjust width as needed
                                    height: sizes.listiconSize - 6,

                                    // Adjust height as needed
                                  ),
                                  pw.SizedBox(
                                    width: 7,
                                  ),
                                  pw.Text(
                                    '${widget.profile['phoneNumber']}',
                                    style: pw.TextStyle(
                                        fontSize: Sizes.Paragraph,
                                        color: Sizes.bgColor4),
                                  ),
                                ],
                              ),
                              pw.SizedBox(
                                height: 7,
                              ),
                              pw.Row(
                                children: [
                                  // Address Icon.
                                  pw.Image(
                                    pw.MemoryImage(placeHolderIcon),
                                    // Replace with the path to your PNG image
                                    width: sizes.listiconSize - 6,
                                    // Adjust width as needed
                                    height: sizes.listiconSize - 6,

                                    // Adjust height as needed
                                  ),
                                  pw.SizedBox(
                                    width: 7,
                                  ),
                                  pw.Flexible(
                                    child: pw.Text(
                                      '${widget.profile['address']}',
                                      style: pw.TextStyle(
                                        color: Sizes.bgColor4,
                                        fontSize: Sizes.Paragraph,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              pw.SizedBox(
                                height: 7,
                              ),
                              pw.Row(
                                children: [
                                  // Email Icon.
                                  pw.Image(
                                    pw.MemoryImage(sendLetterIcon),
                                    // Replace with the path to your PNG image
                                    width: sizes.listiconSize - 6,
                                    // Adjust width as needed
                                    height: sizes.listiconSize - 6,

                                    // Adjust height as needed
                                  ),
                                  pw.SizedBox(
                                    width: 7,
                                  ),
                                  pw.Flexible(
                                    child: pw.Text(
                                      '${widget.profile['email']}',
                                      style: pw.TextStyle(
                                        fontSize: Sizes.Paragraph,
                                        color: Sizes.bgColor4,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                        pw.SizedBox(
                          height: 1.75,
                        ),

                        // Skills.
                        pw.Container(
                          padding: const pw.EdgeInsets.all(
                            7,
                          ),
                          width: 140,
                          color: Sizes.bgColor2,
                          child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                'SKILLS',
                                style: pw.TextStyle(
                                  fontSize: Sizes.Heading,
                                  fontWeight: pw.FontWeight.bold,
                                  color: Sizes.bgColor4,
                                ),
                              ),
                              pw.SizedBox(
                                height: 7,
                              ),
                              pw.Wrap(
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
                                              color: Sizes.bgColor4,
                                            ),
                                            borderRadius:
                                                pw.BorderRadius.circular(
                                              3,
                                            ),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 7,
                                        ),
                                        pw.Expanded(
                                          child: pw.Text(
                                            skill,
                                            style: pw.TextStyle(
                                              fontSize: Sizes.Subheading,
                                              color: Sizes.bgColor4,
                                            ),
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

                        pw.SizedBox(
                          height: 1.75,
                        ),

                        // Languages.
                        pw.Container(
                          padding: const pw.EdgeInsets.all(
                            7,
                          ),
                          width: 140,
                          color: Sizes.bgColor2,
                          child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                'LANGUAGE',
                                style: pw.TextStyle(
                                  fontSize: Sizes.Heading,
                                  fontWeight: pw.FontWeight.bold,
                                  color: Sizes.bgColor4,
                                ),
                              ),
                              pw.SizedBox(
                                height: 7,
                              ),
                              pw.Wrap(
                                spacing: 7,
                                runSpacing: 7,
                                alignment: pw.WrapAlignment.start,
                                children: List.generate(
                                  widget.skills.length,
                                  // Replace with the actual item count you want to display
                                  (index) {
                                    String skill =
                                        widget.languages[index]['language'];
                                    // Return your list item widget here
                                    return pw.Row(
                                      children: [
                                        pw.Container(
                                          width: 7,
                                          height: 7,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                              color: Sizes.bgColor4,
                                            ),
                                            borderRadius:
                                                pw.BorderRadius.circular(
                                              3,
                                            ),
                                          ),
                                        ),
                                        pw.SizedBox(
                                          width: 7,
                                        ),
                                        pw.Expanded(
                                          child: pw.Text(
                                            skill,
                                            style: pw.TextStyle(
                                              fontSize: Sizes.Subheading,
                                              color: Sizes.bgColor4,
                                            ),
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
                    )
                  ],
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
          style:
              TextStyle(color: sizes.AppBartextColor, fontSize: sizes.fontSize),
        ),
        centerTitle: true,
        backgroundColor: Sizes.bgColor1,
        toolbarHeight: sizes.barSize,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 3,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Code of UI.
              const SizedBox(
                height: 14,
              ),
              // Image and Names.
              Row(
                children: [
                  // Circle Image
                  Container(
                    padding: const EdgeInsets.only(
                      left: 14,
                    ),
                    child: Center(
                      child: ClipOval(
                        child: SizedBox(
                          width: 70,
                          height: 70,
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
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  // Name and Profession.
                  Container(
                    padding: const EdgeInsets.only(
                      left: 14,
                      right: 14,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Sizes.bgColor1,
                        ),
                        bottom: BorderSide(
                          color: Sizes.bgColor1,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 7,
                          ),
                          child: Text(
                            '${widget.profile['firstName']} ${widget.profile['lastName']}',
                            style: TextStyle(
                              fontSize: Sizes.Heading + 4,
                              fontWeight: FontWeight.bold,
                              color: Sizes.bgColor1,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            '${widget.profile['objective']}',
                            style: TextStyle(
                              fontSize: Sizes.Subheading,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              // Bottom Content.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left Content.
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // About Me.
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 7,
                          ),
                          child: Row(
                            children: [
                              // Round Dot.
                              Container(
                                height: 7,
                                width: 7,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    3.5,
                                  ),
                                  border: Border.all(
                                    color: Sizes.bgColor1,
                                  ),
                                  color: Sizes.bgColor1,
                                ),
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Text(
                                'About Me',
                                style: TextStyle(
                                  fontSize: Sizes.Heading,
                                  fontWeight: FontWeight.bold,
                                  color: Sizes.bgColor1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 7,
                          ),
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 7,
                              top: 7,
                              bottom: 7,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: Sizes.bgColor1,
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      size: 21,
                                      color: Sizes.bgColor1,
                                    ),
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
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_rounded,
                                      size: 21,
                                      color: Sizes.bgColor1,
                                    ),
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
                                Row(
                                  children: [
                                    Icon(
                                      Icons.alternate_email_sharp,
                                      size: 20,
                                      color: Sizes.bgColor1,
                                    ),
                                    Flexible(
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

                        // Work Experience.
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 7,
                          ),
                          child: Row(
                            children: [
                              // Round Dot.
                              Container(
                                height: 7,
                                width: 7,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    3.5,
                                  ),
                                  border: Border.all(
                                    color: Sizes.bgColor1,
                                  ),
                                  color: Sizes.bgColor1,
                                ),
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Text(
                                'Work Experiences',
                                style: TextStyle(
                                  fontSize: Sizes.Heading,
                                  fontWeight: FontWeight.bold,
                                  color: Sizes.bgColor1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 7,
                          ),
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 7,
                              top: 7,
                              bottom: 7,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: Sizes.bgColor1,
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
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
                                        Container(
                                          child: Text(
                                            '${widget.experience[index]['company']}',
                                            style: TextStyle(
                                              fontSize: Sizes.Subheading,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            '${widget.experience[index]['job']}',
                                            style: TextStyle(
                                              fontSize: Sizes.Paragraph,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            '${widget.experience[index]['details']}',
                                            style: TextStyle(
                                              fontSize: Sizes.Paragraph,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            '${widget.experience[index]['startdate']}-${widget.experience[index]['enddate']}',
                                            style: TextStyle(
                                              fontSize: Sizes.Paragraph,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),

                        // References.
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 7,
                          ),
                          child: Row(
                            children: [
                              // Round Dot.
                              Container(
                                height: 7,
                                width: 7,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    3.5,
                                  ),
                                  border: Border.all(
                                    color: Sizes.bgColor1,
                                  ),
                                  color: Sizes.bgColor1,
                                ),
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Text(
                                'References',
                                style: TextStyle(
                                  fontSize: Sizes.Heading,
                                  fontWeight: FontWeight.bold,
                                  color: Sizes.bgColor1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 7,
                          ),
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 7,
                              top: 7,
                              bottom: 7,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: Sizes.bgColor1,
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
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
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
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
                                              fontSize: Sizes.Paragraph,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14),
                                          child: Divider(
                                            thickness: 1,
                                            color: Sizes.bgColor1,
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Education.
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 7,
                          ),
                          child: Row(
                            children: [
                              // Round Dot.
                              Container(
                                height: 7,
                                width: 7,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    3.5,
                                  ),
                                  border: Border.all(
                                    color: Sizes.bgColor1,
                                  ),
                                  color: Sizes.bgColor1,
                                ),
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Text(
                                'Eduaction',
                                style: TextStyle(
                                  fontSize: Sizes.Heading,
                                  fontWeight: FontWeight.bold,
                                  color: Sizes.bgColor1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 7,
                          ),
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 7,
                              top: 7,
                              bottom: 7,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  color: Sizes.bgColor1,
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.builder(
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Right Content
                  Column(
                    children: [
                      // About Me.
                      Container(
                        width: 140,
                        padding: const EdgeInsets.all(
                          7,
                        ),
                        color: Sizes.bgColor1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CONTACT',
                              style: TextStyle(
                                fontSize: Sizes.Heading,
                                fontWeight: FontWeight.bold,
                                color: Sizes.bgColor3,
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 21,
                                  color: Sizes.bgColor3,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  '${widget.profile['phoneNumber']}',
                                  style: TextStyle(
                                    fontSize: Sizes.Paragraph,
                                    color: Sizes.bgColor3,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  size: 21,
                                  color: Sizes.bgColor3,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Flexible(
                                  child: Text(
                                    '${widget.profile['address']}',
                                    style: TextStyle(
                                      color: Sizes.bgColor3,
                                      fontSize: Sizes.Paragraph,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.alternate_email_sharp,
                                  size: 20,
                                  color: Sizes.bgColor3,
                                ),
                                const SizedBox(
                                  width: 7,
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
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 1.75,
                      ),

                      // Skills.
                      Container(
                        padding: const EdgeInsets.all(
                          7,
                        ),
                        width: 140,
                        color: Sizes.bgColor1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SKILLS',
                              style: TextStyle(
                                fontSize: Sizes.Heading,
                                fontWeight: FontWeight.bold,
                                color: Sizes.bgColor3,
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Wrap(
                              spacing: 7,
                              runSpacing: 7,
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
                                        width: 7,
                                        height: 7,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Sizes.bgColor3,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            3,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      Flexible(
                                        child: Text(
                                          skill,
                                          style: TextStyle(
                                            fontSize: Sizes.Subheading,
                                            color: Sizes.bgColor3,
                                          ),
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

                      const SizedBox(
                        height: 1.75,
                      ),

                      // Languages.
                      Container(
                        padding: const EdgeInsets.all(
                          7,
                        ),
                        width: 140,
                        color: Sizes.bgColor1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'LANGUAGE',
                              style: TextStyle(
                                fontSize: Sizes.Heading,
                                fontWeight: FontWeight.bold,
                                color: Sizes.bgColor3,
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Wrap(
                              spacing: 7,
                              runSpacing: 7,
                              alignment: WrapAlignment.start,
                              children: List.generate(
                                widget.skills.length,
                                // Replace with the actual item count you want to display
                                (index) {
                                  String skill =
                                      widget.languages[index]['language'];
                                  // Return your list item widget here
                                  return Row(
                                    children: [
                                      Container(
                                        width: 7,
                                        height: 7,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Sizes.bgColor3,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            3,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      Flexible(
                                        child: Text(
                                          skill,
                                          style: TextStyle(
                                            fontSize: Sizes.Subheading,
                                            color: Sizes.bgColor3,
                                          ),
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
                  )
                ],
              ),
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
