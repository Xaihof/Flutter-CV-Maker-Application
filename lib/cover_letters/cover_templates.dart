import 'package:cvmaker/cover_letters/template1_screen.dart';
import 'package:cvmaker/cover_letters/template2_screen.dart';
import 'package:cvmaker/cover_letters/template3_screen.dart';
import 'package:cvmaker/cover_letters/template4_screen.dart';
import 'package:cvmaker/cover_letters/template5_screen.dart';
import 'package:cvmaker/cover_letters/template6_screen.dart';
import 'package:cvmaker/cover_letters/template7_screen.dart';
import 'package:flutter/material.dart';

class CoverTemplates extends StatelessWidget {
  final int coverLetterId;

  const CoverTemplates({super.key, required this.coverLetterId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cover Templates'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.6, // Adjust the aspect ratio for portrait view
          ),
          itemCount: templates.length, // Display the number of templates
          itemBuilder: (context, index) {
            final template = templates[index];
            return GestureDetector(
              onTap: () {
                // Navigate to the corresponding template screen on item click
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => template.screenBuilder(coverLetterId),
                  ),
                );
              },
              child: Image.asset(
                template.imagePath,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}

class Template {
  final String imagePath;
  final Widget Function(int coverLetterId) screenBuilder;

  Template({required this.imagePath, required this.screenBuilder});
}

final List<Template> templates = [

  Template(
    imagePath: 'assets/cover/cover1.png',
    screenBuilder: (id) => Template1Screen(coverLetterId: id),
  ),

  // Add more templates with their corresponding screens
  Template(
    imagePath: 'assets/cover/cover1.png',
    screenBuilder: (id) => Template2Screen(coverLetterId: id),
  ),

  Template(
    imagePath: 'assets/cover/cover1.png',
    screenBuilder: (id) => Template3Screen(coverLetterId: id),
  ),

  Template(
    imagePath: 'assets/cover/cover1.png',
    screenBuilder: (id) => Template4Screen(coverLetterId: id),
  ),

  Template(
    imagePath: 'assets/cover/cover1.png',
    screenBuilder: (id) => Template5Screen(coverLetterId: id),
  ),

  Template(
    imagePath: 'assets/cover/cover1.png',
    screenBuilder: (id) => Template6Screen(coverLetterId: id),
  ),

  Template(
    imagePath: 'assets/cover/cover1.png',
    screenBuilder: (id) => Template7Screen(coverLetterId: id),
  ),

  // Repeat for 10 templates
];
