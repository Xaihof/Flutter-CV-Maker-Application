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
import 'cover_dp_helper.dart';
import '../templates2.dart';

class Template2Screen extends StatefulWidget {
  final int coverLetterId;

  const Template2Screen({super.key, required this.coverLetterId});

  @override
  _Template1ScreenState createState() => _Template1ScreenState();
}

class _Template1ScreenState extends State<Template2Screen> {
  int _selectedIndex = 0;
  late Future<Map<String, dynamic>?> _coverLetter;
  String dateText = "Tap to write Date";

  @override
  void initState() {
    super.initState();
    _coverLetter = DatabaseHelper().getCoverLetter(widget.coverLetterId);
    Sizes.setBgColor1(Colors.black);
  }

  void _enterDate(BuildContext context) {
    TextEditingController controller = TextEditingController();

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

  Future<Uint8List> getImageDataFromAsset(String assetName) async {
    try {
      final ByteData data = await rootBundle.load(assetName);
      return data.buffer.asUint8List();
    } catch (e) {
      print('Error loading image data: $e');
      rethrow;
    }
  }

  void _generatePdf(Map<String, dynamic> coverLetter) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.notoSansRegular();
    final fontBold = await PdfGoogleFonts.notoSansBold();

    Uint8List? backgroundImage;
    try {
      backgroundImage = await getImageDataFromAsset('assets/cover/bg1.jpg');
    } catch (e) {
      print('Error loading background image: $e');
      return;
    }

    if (backgroundImage.isEmpty) {
      print('Background image is null or empty.');
      return;
    }

    // Print the length of the image data to check if it's valid
    print(
        'Background image loaded successfully, length: ${backgroundImage.length}');

    // Test with a known-good image if the original fails
    Uint8List? fallbackImage;
    try {
      fallbackImage = await getImageDataFromAsset(
          'assets/cover/cover1.png'); // Replace with a path to a known-good image
    } catch (e) {
      print('Error loading fallback image: $e');
    }

    try {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(20),
          theme: pw.ThemeData.withFont(
            base: font,
            bold: fontBold,
            icons: await PdfGoogleFonts.materialIcons(),
          ),
          build: (pw.Context context) {
            return pw.Stack(
              children: [
                pw.Positioned.fill(
                  child: pw.Image(
                    pw.MemoryImage(backgroundImage!),
                    fit: pw.BoxFit.cover,
                  ),
                ),
                pw.Column(
                  children: [
                    // Add your other widgets here
                  ],
                ),
              ],
            );
          },
        ),
      );

      String path = (await getTemporaryDirectory()).path;
      File pdfFile = await File('$path/${coverLetter['id']}.pdf').create();
      pdfFile.writeAsBytesSync(await pdf.save());

      // Open the saved PDF using the default PDF viewer
      OpenFile.open('$path/${coverLetter['id']}.pdf');
    } catch (e) {
      print('Error generating PDF: $e');

      // Try generating the PDF with the fallback image
      if (fallbackImage != null) {
        try {
          pdf.addPage(
            pw.Page(
              pageFormat: PdfPageFormat.a4,
              margin: const pw.EdgeInsets.all(20),
              theme: pw.ThemeData.withFont(
                base: font,
                bold: fontBold,
                icons: await PdfGoogleFonts.materialIcons(),
              ),
              build: (pw.Context context) {
                return pw.Stack(
                  children: [
                    pw.Positioned.fill(
                      child: pw.Image(
                        pw.MemoryImage(fallbackImage!),
                        fit: pw.BoxFit.cover,
                      ),
                    ),
                    pw.Column(
                      children: [
                        // Add your other widgets here
                      ],
                    ),
                  ],
                );
              },
            ),
          );

          String path = (await getTemporaryDirectory()).path;
          File pdfFile = await File('$path/${coverLetter['id']}.pdf').create();
          pdfFile.writeAsBytesSync(await pdf.save());

          // Open the saved PDF using the default PDF viewer
          OpenFile.open('$path/${coverLetter['id']}.pdf');
        } catch (e) {
          print('Error generating PDF with fallback image: $e');
        }
      }
    }
  }

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

  @override
  Widget build(BuildContext context) {
    Sizes sizes = Sizes(context);

    return FutureBuilder(
      future: _coverLetter,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Template 1'),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
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
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/cover/bg1.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                    const Column(
                      children: [
                        // Add your other widgets here
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
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Template 1'),
            ),
            body: const Center(child: Text('No data found')),
          );
        }
      },
    );
  }
}
