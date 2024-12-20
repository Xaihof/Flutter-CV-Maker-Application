import 'package:flutter/material.dart';

import 'Experience.dart';
import 'Sizes.dart';
import 'achievement.dart';
import 'choose_template.dart';
import 'education.dart';
import 'interest.dart';
import 'languages.dart';
import 'objective.dart';
import 'personal_profile.dart';
import 'projects.dart';
import 'reference.dart';
import 'skill.dart';

class CVInfo extends StatefulWidget {
  final String fileName;

  const CVInfo({super.key, required this.fileName});

  @override
  _CVInfoState createState() => _CVInfoState();
}

class _CVInfoState extends State<CVInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Sizes sizes = Sizes(context);
    String cvName = widget.fileName;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$cvName's CV",
          style:
              TextStyle(color: sizes.AppBartextColor, fontSize: sizes.fontSize),
        ),
        centerTitle: true,
        backgroundColor: sizes.appBarBgColor,
        toolbarHeight: sizes.barSize,
        actions: [
          IconButton(
            icon: Icon(Icons.visibility,
                color: sizes.AppBartextColor, size: sizes.iconSize),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ChooseTemplate(fileName: widget.fileName)),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Wrap(
                  runSpacing: 10.0, // Adjust the spacing between rows
                  children: [
                    CustomIconButton(
                      imagePath: 'assets/create cv.png',
                      text: 'Personal Profile',
                      onPressed: () {
                        _navigateToScreen(context,
                            PersonalProfileScreen(fileName: widget.fileName));
                      },
                    ),
                    CustomIconButton(
                      imagePath: 'assets/create cv.png',
                      text: 'Objective',
                      onPressed: () {
                        _navigateToScreen(context,
                            ObjectiveScreen(fileName: widget.fileName));
                      },
                    ),
                    CustomIconButton(
                      imagePath: 'assets/create cv.png',
                      text: 'Education',
                      onPressed: () {
                        _navigateToScreen(context,
                            EducationScreen(fileName: widget.fileName));
                      },
                    ),
                    CustomIconButton(
                      imagePath: 'assets/create cv.png',
                      text: 'Experiences',
                      onPressed: () {
                        _navigateToScreen(context,
                            ExperienceScreen(fileName: widget.fileName));
                      },
                    ),
                    CustomIconButton(
                      imagePath: 'assets/create cv.png',
                      text: 'Skills',
                      onPressed: () {
                        _navigateToScreen(
                            context, SkillsScreen(fileName: widget.fileName));
                      },
                    ),
                    CustomIconButton(
                      imagePath: 'assets/create cv.png',
                      text: 'Interests',
                      onPressed: () {
                        _navigateToScreen(context,
                            InterestsScreen(fileName: widget.fileName));
                      },
                    ),
                    CustomIconButton(
                      imagePath: 'assets/create cv.png',
                      text: 'Achievements',
                      onPressed: () {
                        _navigateToScreen(context,
                            AchievementsScreen(fileName: widget.fileName));
                      },
                    ),
                    CustomIconButton(
                      imagePath: 'assets/create cv.png',
                      text: 'Languages',
                      onPressed: () {
                        _navigateToScreen(context,
                            LanguagesScreen(fileName: widget.fileName));
                      },
                    ),
                    CustomIconButton(
                      imagePath: 'assets/create cv.png',
                      text: 'References(opt)',
                      onPressed: () {
                        _navigateToScreen(context,
                            ReferencesScreen(fileName: widget.fileName));
                      },
                    ),
                    CustomIconButton(
                      imagePath: 'assets/create cv.png',
                      text: 'Projects',
                      onPressed: () {
                        _navigateToScreen(
                            context, ProjectsScreen(fileName: widget.fileName));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onPressed;

  const CustomIconButton({super.key, 
    required this.imagePath,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Sizes sizes = Sizes(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: sizes.AppBartextColor,
        minimumSize: const Size.fromHeight(75), // Adjust the size as needed
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: sizes.paddingvertical + 10),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: sizes.buttontextColor),
                borderRadius: BorderRadius.circular(5),
                color: sizes.appBarBgColor,
              ),
              child: Image.asset(
                imagePath,
                width: sizes.imageradius - 10,
                height: sizes.imageradius - 10,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: sizes.listFontSize,
                fontWeight: FontWeight.bold,
                color: sizes.buttontextColor,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.arrow_forward_ios,
              size: sizes.iconSize,
              color: sizes.buttontextColor,
            ),
          ),
        ],
      ),
    );
  }
}
