import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../Sizes.dart';
import '../templates2.dart';
import 'cover_dp_helper.dart';

class Template6Screen extends StatefulWidget {
  // Variable.
  final int coverLetterId;

  // Constructor.
  const Template6Screen({super.key, required this.coverLetterId});

  @override
  _Template6ScreenState createState() => _Template6ScreenState();
}

class _Template6ScreenState extends State<Template6Screen> {
  // Variables
  int _selectedIndex = 0;
  late Future<Map<String, dynamic>?> _coverLetter;
  String dateText = "Tap to write Date";

  @override
  void initState() {
    super.initState();
    _coverLetter = DatabaseHelper().getCoverLetter(widget.coverLetterId);
    Sizes.setBgColor1(Colors.black);
  }

  // Enter Date(Dialog) Function
  void _enterDate(BuildContext context) {
    // Controller.
    TextEditingController controller = TextEditingController();

    // Enter Date Dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Date'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
                hintText: "Enter date (e.g., 12, September, 2024)"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  dateText = controller.text;
                });
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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

  // Function to generate PDF
  void _generatePdf(Map<String, dynamic> coverLetter) async {
    // Variables
    final pdf = pw.Document(); // To Create PDF
    final font = await PdfGoogleFonts.notoSansRegular(); // To Load Font for PDF
    final fontBold =
        await PdfGoogleFonts.notoSansBold(); // To Load Font for PDF

    // To get Image into variables by using function.
    final expIcon =
        await getImageDataFromAsset('assets/icons_white/reputation.png');
    final aboutMeIcon =
        await getImageDataFromAsset('assets/icons_white/about_me.png');
    final objectiveIcon =
        await getImageDataFromAsset('assets/icons_white/objective.png');
    final educationIcon =
        await getImageDataFromAsset('assets/icons_white/education.png');
    final referenceIcon =
        await getImageDataFromAsset('assets/icons_white/reference.png');
    final skillIcon =
        await getImageDataFromAsset('assets/icons_white/skill.png');
    final hobbyIcon =
        await getImageDataFromAsset('assets/icons_white/hobbies.png');
    final achieveIcon =
        await getImageDataFromAsset('assets/icons_white/achievement.png');
    final languageIcon =
        await getImageDataFromAsset('assets/icons_white/language.png');
    final projectIcon =
        await getImageDataFromAsset('assets/icons_white/projects.png');
    final phoneCallIcon =
        await getImageDataFromAsset('assets/icons_white/phone_call.png');
    final placeHolderIcon =
        await getImageDataFromAsset('assets/icons_white/placeholder.png');
    final sendLetterIcon =
        await getImageDataFromAsset('assets/icons_white/send_letter_icon.png');

    // UI of PDF.
    Sizes sizes = Sizes(context); // Sizes Object
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4, // Page size.
        margin: const pw.EdgeInsets.all(20),
        theme: pw.ThemeData.withFont(
          base: font,
          bold: fontBold,
          icons: await PdfGoogleFonts.materialIcons(),
        ),
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.only(right: 7, top: 14),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    // Top Left Details.
                    pw.Align(
                      alignment: pw.Alignment.topLeft,
                      child: pw.Container(
                        width: 182,
                        child: pw.Column(
                          children: [
                            // Top Left Name and Email Container.
                            pw.Container(
                              height: 48,
                              color: Sizes.bgColor2,
                              child: pw.Align(
                                alignment: pw.Alignment.topLeft,
                                child: pw.Padding(
                                  padding: const pw.EdgeInsets.only(left: 14),
                                  child: pw.Column(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        coverLetter['yourName'] ??
                                            'KAREN THOMAS',
                                        style: pw.TextStyle(
                                          fontSize: Sizes.Heading,
                                          fontWeight: pw.FontWeight.bold,
                                          color: Sizes.bgColor4,
                                        ),
                                      ),
                                      pw.Text(
                                        coverLetter['yourEmail'] ??
                                            'PROFESSIONAL TITLE',
                                        style: pw.TextStyle(
                                          fontSize: Sizes.Paragraph,
                                          color: Sizes.bgColor4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            pw.SizedBox(height: 14),
                            // Top Left Other Details (name, email, contact, etc.)
                            pw.Container(
                              padding: const pw.EdgeInsets.only(
                                left: 7,
                              ),
                              alignment: pw.Alignment.topLeft,
                              child: pw.Text(
                                "To",
                                style: pw.TextStyle(
                                    fontStyle: pw.FontStyle.italic,
                                    color: PdfColors.grey,
                                    fontSize: Sizes.Paragraph),
                              ),
                            ),
                            pw.Container(
                              padding: const pw.EdgeInsets.only(
                                left: 7,
                              ),
                              alignment: pw.Alignment.topLeft,
                              child: pw.Text(
                                coverLetter['employerName'],
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                    fontSize: Sizes.Paragraph,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ),
                            pw.Container(
                              padding: const pw.EdgeInsets.only(
                                left: 7,
                              ),
                              alignment: pw.Alignment.topLeft,
                              child: pw.Text(
                                coverLetter['employerTitle'],
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                    fontSize: Sizes.Paragraph,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ),
                            pw.Container(
                              padding: const pw.EdgeInsets.only(
                                left: 7,
                              ),
                              alignment: pw.Alignment.topLeft,
                              child: pw.Text(
                                coverLetter['companyName'],
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                    fontSize: Sizes.Paragraph,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ),
                            pw.Container(
                              padding: const pw.EdgeInsets.only(
                                left: 7,
                              ),
                              alignment: pw.Alignment.topLeft,
                              child: pw.Text(
                                coverLetter['companyAddress'],
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: Sizes.Paragraph,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Top Right Details.
                    // Top Right Details.
                    pw.Align(
                      alignment: pw.Alignment.topRight,
                      child: pw.Container(
                        width: sizes.screenWidth * 0.4,
                        decoration: pw.BoxDecoration(
                          borderRadius: pw.BorderRadius.circular(7),
                        ),
                        child: pw.Align(
                          alignment: pw.Alignment.topRight,
                          child: pw.Column(
                            children: [
                              pw.Padding(
                                padding: const pw.EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4,
                                ),
                                child: pw.Row(
                                  children: [
                                    pw.Expanded(
                                      child: pw.Align(
                                        alignment: pw.Alignment.topLeft,
                                        child: pw.Flexible(
                                          child: pw.Text(
                                            coverLetter['yourPhone'],
                                            style: pw.TextStyle(
                                                fontSize: Sizes.Paragraph),
                                          ),
                                        ),
                                      ),
                                    ),
                                     pw.SizedBox(width: 5),
                                    pw.Container(
                                      decoration: pw.BoxDecoration(
                                        shape: pw.BoxShape.circle,
                                        color: Sizes
                                            .bgColor2, // Background color of the circular box
                                      ),
                                      padding:  const pw.EdgeInsets.all(6),
                                      // Adjust padding to manage the icon size inside the box
                                      child: pw.Image(
                                        pw.MemoryImage(phoneCallIcon),
                                        // Replace with the path to your PNG image
                                        width: sizes.listiconSize - 6,
                                        // Adjust width as needed
                                        height: sizes.listiconSize - 6,

                                        // Adjust height as needed
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              pw.Padding(
                                padding: const pw.EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4),
                                child: pw.Row(
                                  children: [
                                    pw.Expanded(
                                      child: pw.Align(
                                        alignment: pw.Alignment.topLeft,
                                        child: pw.Flexible(
                                          child: pw.Text(
                                            coverLetter['yourEmail'],
                                            style: pw.TextStyle(
                                                fontSize: Sizes.Paragraph),
                                          ),
                                        ),
                                      ),
                                    ),
                                     pw.SizedBox(width: 5),
                                    pw.Container(
                                      decoration: pw.BoxDecoration(
                                        shape: pw.BoxShape.circle,
                                        color: Sizes
                                            .bgColor2, // Background color of the circular box
                                      ),
                                      padding: const pw.EdgeInsets.all(6),
                                      // Adjust padding to manage the icon size inside the box
                                      child: pw.Image(
                                        pw.MemoryImage(sendLetterIcon),
                                        // Replace with the path to your PNG image
                                        width: sizes.listiconSize - 6,
                                        // Adjust width as needed
                                        height: sizes.listiconSize - 6,

                                        // Adjust height as needed
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              pw.Padding(
                                padding: const pw.EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4,
                                ),
                                child: pw.Row(
                                  children: [
                                    pw.Expanded(
                                      child: pw.Align(
                                        alignment: pw.Alignment.topLeft,
                                        child: pw.Flexible(
                                          child: pw.Text(
                                            '${coverLetter['yourAddress']}, ${coverLetter['yourCity']}',
                                            style: pw.TextStyle(
                                                fontSize: Sizes.Paragraph),
                                          ),
                                        ),
                                      ),
                                    ),
                                    pw.SizedBox(width: 5),
                                    pw.Container(
                                      decoration: pw.BoxDecoration(
                                        shape: pw.BoxShape.circle,
                                        color: Sizes
                                            .bgColor2, // Background color of the circular box
                                      ),
                                      padding: const pw.EdgeInsets.all(6),
                                      // Adjust padding to manage the icon size inside the box

                                      child: pw.Image(
                                        pw.MemoryImage(placeHolderIcon),
                                        // Replace with the path to your PNG image
                                        width: sizes.listiconSize - 6,
                                        // Adjust width as needed
                                        height: sizes.listiconSize - 6,

                                        // Adjust height as needed
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              pw.Padding(
                                padding: const pw. EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4,
                                ),
                                child: pw.Row(
                                  children: [
                                    pw.Expanded(
                                      child: pw.Align(
                                        alignment: pw.Alignment.topLeft,
                                        child: pw.Flexible(
                                          child: pw.Text(
                                            coverLetter['yourCity'],
                                            style: pw.TextStyle(
                                              fontSize: Sizes.Paragraph,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                     pw.SizedBox(width: 5),
                                    pw.Container(
                                      decoration: pw.BoxDecoration(
                                        shape: pw.BoxShape.circle,
                                        color: Sizes
                                            .bgColor2, // Background color of the circular box
                                      ),
                                      padding: const pw.EdgeInsets.all(6),
                                      // Adjust padding to manage the icon size inside the box
                                      child: pw.Image(
                                        pw.MemoryImage(placeHolderIcon),
                                        // Replace with the path to your PNG image
                                        width: sizes.listiconSize - 6,
                                        // Adjust width as needed
                                        height: sizes.listiconSize - 6,

                                        // Adjust height as needed
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 14),
              // Date alert dialog
              pw.Container(
                padding: const pw.EdgeInsets.only(
                  left: 21,
                  top: 7,
                  right: 21,
                ),
                alignment: pw.Alignment.topRight,
                child: pw.Text(
                  dateText,
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: Sizes.Paragraph,
                  ),
                ),
              ),
              // Content
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 7.0),
                child: pw.Row(
                  children: [
                    pw.Flexible(
                      child: pw.Text(
                        coverLetter['content'],
                        style: pw.TextStyle(
                            color: PdfColors.black, fontSize: Sizes.Paragraph),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    // To get a temporary Directory and its path.
    String path = (await getTemporaryDirectory()).path;

    // Create pdf with path (path end is file name).
    File pdfFile = await File('$path/${widget.coverLetterId}.pdf').create();

    // Save pdf
    pdfFile.writeAsBytesSync(await pdf.save());

    // Open the saved PDF using the default PDF viewer
    OpenFile.open('$path/${widget.coverLetterId}.pdf');
  }

  // to set the global variables (_selectIndex and _coverLetter(future<Map>))
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 2) {
      _coverLetter.then((coverLetter) {
        if (coverLetter != null) {
          _generatePdf(coverLetter);
        }
      });
    }
  }

  // App UI to show PDF layout.
  @override
  Widget build(BuildContext context) {
    Sizes sizes = Sizes(context);

    return FutureBuilder(
      future: _coverLetter,
      builder: (context, snapshot) {
        // UI(progress indicator) to show when _coverLetter future is waiting.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Template 3'),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );

          // UI(CoverLetter Content) to show when _coverLetter future is completed.
        } else if (snapshot.hasData) {
          final coverLetter = snapshot.data as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'CV Editor',
                style: TextStyle(color: Colors.black, fontSize: sizes.fontSize),
              ),
              centerTitle: true,
              backgroundColor: Sizes.bgColor1,
              toolbarHeight: sizes.barSize,
            ),
            body: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 7, top: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Top Left Details.
                          Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              width: 182,
                              child: Column(
                                children: [
                                  // Top Left Name and Email Container.
                                  Container(
                                    height: 48,
                                    color: Sizes.bgColor1,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 14),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              coverLetter['yourName'] ??
                                                  'KAREN THOMAS',
                                              style: TextStyle(
                                                fontSize: Sizes.Heading,
                                                fontWeight: FontWeight.bold,
                                                color: Sizes.bgColor3,
                                              ),
                                            ),
                                            Text(
                                              coverLetter['yourEmail'] ??
                                                  'PROFESSIONAL TITLE',
                                              style: TextStyle(
                                                fontSize: Sizes.Paragraph,
                                                color: Sizes.bgColor3,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  // Top Left Other Details (name, email, contact, etc.)
                                  Container(
                                    padding: const EdgeInsets.only(
                                      left: 7,
                                    ),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "To",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.grey,
                                          fontSize: Sizes.Paragraph),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      left: 7,
                                    ),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      coverLetter['employerName'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: Sizes.Paragraph,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      left: 7,
                                    ),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      coverLetter['employerTitle'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: Sizes.Paragraph,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      left: 7,
                                    ),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      coverLetter['companyName'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: Sizes.Paragraph,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      left: 7,
                                    ),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      coverLetter['companyAddress'],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: Sizes.Paragraph,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Top Right Details.
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: sizes.screenWidth * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                        vertical: 4,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Flexible(
                                                child: Text(
                                                  coverLetter['yourPhone'],
                                                  style: TextStyle(
                                                      fontSize: Sizes.Paragraph),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Sizes
                                                  .bgColor1, // Background color of the circular box
                                            ),
                                            padding: const EdgeInsets.all(6),
                                            // Adjust padding to manage the icon size inside the box
                                            child: Image.asset(
                                              'assets/icons_white/phone_call.png',
                                              // Replace with the path to your PNG image
                                              width: sizes.listiconSize - 6,
                                              // Adjust width as needed
                                              height: sizes.listiconSize - 6,
                                              color: Colors.white,
                                              // Adjust height as needed
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Flexible(
                                                child: Text(
                                                  coverLetter['yourEmail'],
                                                  style: TextStyle(
                                                      fontSize: Sizes.Paragraph),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Sizes
                                                  .bgColor1, // Background color of the circular box
                                            ),
                                            padding: const EdgeInsets.all(6),
                                            // Adjust padding to manage the icon size inside the box
                                            child: Image.asset(
                                              'assets/icons_white/send_letter_icon.png',
                                              // Replace with the path to your PNG image
                                              width: sizes.listiconSize - 6,
                                              // Adjust width as needed
                                              height: sizes.listiconSize - 6,
                                              color: Colors.white,
                                              // Adjust height as needed
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                        vertical: 4,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Flexible(
                                                child: Text(
                                                  '${coverLetter['yourAddress']}, ${coverLetter['yourCity']}',
                                                  style: TextStyle(
                                                      fontSize: Sizes.Paragraph),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Sizes
                                                  .bgColor1, // Background color of the circular box
                                            ),
                                            padding: const EdgeInsets.all(6),
                                            // Adjust padding to manage the icon size inside the box

                                            child: Image.asset(
                                              'assets/icons_white/placeholder.png',
                                              // Replace with the path to your PNG image
                                              width: sizes.listiconSize - 6,
                                              // Adjust width as needed
                                              height: sizes.listiconSize - 6,
                                              color: Colors.white,
                                              // Adjust height as needed
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                        vertical: 4,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Flexible(
                                                child: Text(
                                                  coverLetter['yourCity'],
                                                  style: TextStyle(
                                                    fontSize: Sizes.Paragraph,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Sizes
                                                  .bgColor1, // Background color of the circular box
                                            ),
                                            padding: const EdgeInsets.all(6),
                                            // Adjust padding to manage the icon size inside the box
                                            child: Image.asset(
                                              'assets/icons_white/placeholder.png',
                                              // Replace with the path to your PNG image
                                              width: sizes.listiconSize - 6,
                                              // Adjust width as needed
                                              height: sizes.listiconSize - 6,
                                              color: Colors.white,
                                              // Adjust height as needed
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    // Date alert dialog
                    Container(
                      padding: const EdgeInsets.only(
                        left: 21,
                        top: 7,
                        right: 21,
                      ),
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () => _enterDate(context),
                        child: Text(
                          dateText,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: Sizes.Paragraph,
                          ),
                        ),
                      ),
                    ),
                    // Content
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.0),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              coverLetter['content'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Sizes.Paragraph),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Add other sections as needed
                  ],
                ),
              ),
            ),

            // To show bottom floating customization.
            floatingActionButton: Stack(
              children: [
                // To show colors and customise them when bottom navigation index = 0(i.e. colors.)
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
                                      style: TextStyle(
                                          fontSize: sizes.listFontSize),
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
                                        child: const Text('Ok'),
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

                // To show text settings and customize them when bottom navigation index = 1 (i.e. Text Settings)
                if (_selectedIndex == 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          // Positioning above the BottomNavigationBar
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
                    ),
                  ),
              ],
            ),

            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.color_lens, size: sizes.mylisticonSize),
                  label: 'Colors',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.text_fields, size: sizes.mylisticonSize),
                  label: 'Text Settings',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.picture_as_pdf, size: sizes.mylisticonSize),
                  label: 'PDF',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: sizes.AppBartextColor,
              unselectedItemColor: sizes.appBarBgColor,
              onTap: _onItemTapped,
            ),
          );

          // UI(Error Message) to show when _coverLetter future has an error.
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Template 3'),
            ),
            body: const Center(child: Text('No data found')),
          );
        }
      },
    );
  }
}
