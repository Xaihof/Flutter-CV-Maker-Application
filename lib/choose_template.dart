import 'dart:io';

import 'package:cvmaker/templates4.dart';
import 'package:cvmaker/templates5.dart';
import 'package:cvmaker/templates3.dart';
import 'package:cvmaker/templates6.dart';
import 'package:cvmaker/templates7.dart';
import 'package:cvmaker/templates8.dart';
import 'package:flutter/material.dart';

import 'Database.dart';
import 'Sizes.dart';
import 'templates1.dart';
import 'templates2.dart';

class ChooseTemplate extends StatefulWidget {
  final String fileName;

  const ChooseTemplate({super.key, required this.fileName});

  @override
  _ChooseTemplateState createState() => _ChooseTemplateState();
}

class _ChooseTemplateState extends State<ChooseTemplate> {
  bool flag1 = false;
  File? _image;
  Map<String, dynamic> profile = {};
  Map<String, dynamic> objective = {};
  List<Map<String, dynamic>> education = [];
  List<Map<String, dynamic>> experience = [];
  List<Map<String, dynamic>> skills = [];
  List<Map<String, dynamic>> interests = [];
  List<Map<String, dynamic>> achievements = [];
  List<Map<String, dynamic>> languages = [];
  List<Map<String, dynamic>> projects = [];
  List<Map<String, dynamic>> reference = [];

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() {
    fetching_data();
  }

  Future<void> _getImageFromDatabase() async {
    File? imageFile =
        await DatabaseHelper.instance.getImageByFileName(widget.fileName);
    if (imageFile != null) {
      setState(() {
        _image = imageFile;
      });
    }
  }

  void fetching_data() {
    _getImageFromDatabase();
    _loadProfileData();
    _loadObjectiveData();
    _loadEducationbuttons();
    _loadExperiencebuttons();
    _loadSkillsbuttons();
    _loadInterestsbuttons();
    _loadLanguagesbuttons();
    _loadAchievementsbuttons();
    _loadProjectsbuttons();
    _loadReferencebuttons();
  }

  void _loadProfileData() async {
    List<Map<String, dynamic>> profileData = await DatabaseHelper.instance
        .queryProfileRowByFileName(widget.fileName);
    setState(() {
      profile = profileData.isNotEmpty
          ? profileData[0]
          : {
              'firstName': '',
              'lastName': '',
              'dateOfBirth': '',
              'gender': '',
              'email': '',
              'phoneNumber': '',
              'objective': '',
              'address': ''
            };
    });
  }

  void _loadObjectiveData() async {
    List<Map<String, dynamic>> objectiveData = await DatabaseHelper.instance
        .queryObjectiveRowByFileName(widget.fileName);
    setState(() {
      objective =
          objectiveData.isNotEmpty ? objectiveData[0] : {'objective': ''};
    });
  }

  void _loadEducationbuttons() async {
    List<Map<String, dynamic>> educationdata = await DatabaseHelper.instance
        .queryEducationRowsByFileName(widget.fileName);
    setState(() {
      education = educationdata;
    });
  }

  void _loadExperiencebuttons() async {
    List<Map<String, dynamic>> experiencedata = await DatabaseHelper.instance
        .queryExperienceRowsByFileName(widget.fileName);
    setState(() {
      experience = experiencedata;
    });
  }

  void _loadSkillsbuttons() async {
    List<Map<String, dynamic>> skillsdata = await DatabaseHelper.instance
        .querySkillsRowsByFileName(widget.fileName);
    setState(() {
      skills = skillsdata;
    });
  }

  void _loadInterestsbuttons() async {
    List<Map<String, dynamic>> interestsdata = await DatabaseHelper.instance
        .queryInterestsRowsByFileName(widget.fileName);
    setState(() {
      interests = interestsdata;
    });
  }

  void _loadLanguagesbuttons() async {
    List<Map<String, dynamic>> languagesdata = await DatabaseHelper.instance
        .queryLanguagesRowsByFileName(widget.fileName);
    setState(() {
      languages = languagesdata;
    });
  }

  void _loadAchievementsbuttons() async {
    List<Map<String, dynamic>> achievementsdata = await DatabaseHelper.instance
        .queryAchievementsRowsByFileName(widget.fileName);
    setState(() {
      achievements = achievementsdata;
    });
  }

  void _loadProjectsbuttons() async {
    List<Map<String, dynamic>> projectsdata = await DatabaseHelper.instance
        .queryProjectsRowsByFileName(widget.fileName);
    setState(() {
      projects = projectsdata;
    });
  }

  void _loadReferencebuttons() async {
    List<Map<String, dynamic>> referencedata = await DatabaseHelper.instance
        .queryReferenceRowsByFileName(widget.fileName);
    if (referencedata.isNotEmpty) {
      setState(() {
        reference = referencedata;
        flag1 = true;
      });
    }
  }

  void _navigateToTemplate(
      BuildContext context,
      Widget Function({
        required List<Map<String, dynamic>> achievements,
        required List<Map<String, dynamic>> education,
        required List<Map<String, dynamic>> experience,
        required File? file,
        required String fileName,
        required bool flag1,
        required List<Map<String, dynamic>> interests,
        required List<Map<String, dynamic>> languages,
        required Map<String, dynamic> objective,
        required Map<String, dynamic> profile,
        required List<Map<String, dynamic>> projects,
        required List<Map<String, dynamic>> reference,
        required List<Map<String, dynamic>> skills,
      }) templateBuilder) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => templateBuilder(
          file: _image,
          profile: profile,
          objective: objective,
          education: education,
          experience: experience,
          skills: skills,
          interests: interests,
          achievements: achievements,
          languages: languages,
          projects: projects,
          reference: reference,
          fileName: widget.fileName,
          flag1: flag1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Sizes sizes = Sizes(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Template',
          style:
              TextStyle(color: sizes.AppBartextColor, fontSize: sizes.fontSize),
        ),
        centerTitle: true,
        backgroundColor: sizes.appBarBgColor,
        toolbarHeight: sizes.barSize,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Container(
                alignment: Alignment.center,
                child: Wrap(
                  spacing: 10.0,
                  runSpacing: 12.0,
                  children: [
                    ImageButton(
                      imageAsset: 'assets/template1.jpeg',
                      onPressed: () => _navigateToTemplate(
                        context,
                        ({
                          required achievements,
                          required education,
                          required experience,
                          required file,
                          required fileName,
                          required flag1,
                          required interests,
                          required languages,
                          required objective,
                          required profile,
                          required projects,
                          required reference,
                          required skills,
                        }) =>
                            template1(
                          file: file,
                          profile: profile,
                          objective: objective,
                          education: education,
                          experience: experience,
                          skills: skills,
                          interests: interests,
                          achievements: achievements,
                          languages: languages,
                          projects: projects,
                          reference: reference,
                          fileName: fileName,
                          flag1: flag1,
                        ),
                      ),
                    ),
                    ImageButton(
                      imageAsset: 'assets/template2.jpeg',
                      onPressed: () => _navigateToTemplate(
                        context,
                        ({
                          required achievements,
                          required education,
                          required experience,
                          required file,
                          required fileName,
                          required flag1,
                          required interests,
                          required languages,
                          required objective,
                          required profile,
                          required projects,
                          required reference,
                          required skills,
                        }) =>
                            template2(
                          file: file,
                          profile: profile,
                          objective: objective,
                          education: education,
                          experience: experience,
                          skills: skills,
                          interests: interests,
                          achievements: achievements,
                          languages: languages,
                          projects: projects,
                          reference: reference,
                          fileName: fileName,
                          flag1: flag1,
                        ),
                      ),
                    ),
                    ImageButton(
                      imageAsset: 'assets/template3.jpeg',
                      onPressed: () => _navigateToTemplate(
                        context,
                        ({
                          required achievements,
                          required education,
                          required experience,
                          required file,
                          required fileName,
                          required flag1,
                          required interests,
                          required languages,
                          required objective,
                          required profile,
                          required projects,
                          required reference,
                          required skills,
                        }) =>
                            Template3(
                          file: file,
                          profile: profile,
                          objective: objective,
                          education: education,
                          experience: experience,
                          skills: skills,
                          interests: interests,
                          achievements: achievements,
                          languages: languages,
                          projects: projects,
                          reference: reference,
                          fileName: fileName,
                          flag1: flag1,
                        ),
                      ),
                    ),
                    ImageButton(
                      imageAsset: 'assets/template4.jpeg',
                      onPressed: () => _navigateToTemplate(
                        context,
                        ({
                          required achievements,
                          required education,
                          required experience,
                          required file,
                          required fileName,
                          required flag1,
                          required interests,
                          required languages,
                          required objective,
                          required profile,
                          required projects,
                          required reference,
                          required skills,
                        }) =>
                            Template4(
                          file: file,
                          profile: profile,
                          objective: objective,
                          education: education,
                          experience: experience,
                          skills: skills,
                          interests: interests,
                          achievements: achievements,
                          languages: languages,
                          projects: projects,
                          reference: reference,
                          fileName: fileName,
                          flag1: flag1,
                        ),
                      ),
                    ),
                    ImageButton(
                      imageAsset: 'assets/template5.jpeg',
                      onPressed: () => _navigateToTemplate(
                        context,
                        ({
                          required achievements,
                          required education,
                          required experience,
                          required file,
                          required fileName,
                          required flag1,
                          required interests,
                          required languages,
                          required objective,
                          required profile,
                          required projects,
                          required reference,
                          required skills,
                        }) =>
                            Template5(
                          file: file,
                          profile: profile,
                          objective: objective,
                          education: education,
                          experience: experience,
                          skills: skills,
                          interests: interests,
                          achievements: achievements,
                          languages: languages,
                          projects: projects,
                          reference: reference,
                          fileName: fileName,
                          flag1: flag1,
                        ),
                      ),
                    ),
                    ImageButton(
                      imageAsset: 'assets/template6.jpeg',
                      onPressed: () => _navigateToTemplate(
                        context,
                        ({
                          required achievements,
                          required education,
                          required experience,
                          required file,
                          required fileName,
                          required flag1,
                          required interests,
                          required languages,
                          required objective,
                          required profile,
                          required projects,
                          required reference,
                          required skills,
                        }) =>
                            Template6(
                          file: file,
                          profile: profile,
                          objective: objective,
                          education: education,
                          experience: experience,
                          skills: skills,
                          interests: interests,
                          achievements: achievements,
                          languages: languages,
                          projects: projects,
                          reference: reference,
                          fileName: fileName,
                          flag1: flag1,
                        ),
                      ),
                    ),
                    ImageButton(
                      imageAsset: 'assets/template7.jpeg',
                      onPressed: () => _navigateToTemplate(
                        context,
                        ({
                          required achievements,
                          required education,
                          required experience,
                          required file,
                          required fileName,
                          required flag1,
                          required interests,
                          required languages,
                          required objective,
                          required profile,
                          required projects,
                          required reference,
                          required skills,
                        }) =>
                            Template7(
                          file: file,
                          profile: profile,
                          objective: objective,
                          education: education,
                          experience: experience,
                          skills: skills,
                          interests: interests,
                          achievements: achievements,
                          languages: languages,
                          projects: projects,
                          reference: reference,
                          fileName: fileName,
                          flag1: flag1,
                        ),
                      ),
                    ),
                    ImageButton(
                      imageAsset: 'assets/template7.jpeg',
                      onPressed: () => _navigateToTemplate(
                        context,
                        ({
                          required achievements,
                          required education,
                          required experience,
                          required file,
                          required fileName,
                          required flag1,
                          required interests,
                          required languages,
                          required objective,
                          required profile,
                          required projects,
                          required reference,
                          required skills,
                        }) =>
                            Template8(
                          file: file,
                          profile: profile,
                          objective: objective,
                          education: education,
                          experience: experience,
                          skills: skills,
                          interests: interests,
                          achievements: achievements,
                          languages: languages,
                          projects: projects,
                          reference: reference,
                          fileName: fileName,
                          flag1: flag1,
                        ),
                      ),
                    ),

                    // Add more buttons as needed
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageButton extends StatelessWidget {
  final String imageAsset;
  final VoidCallback onPressed;

  const ImageButton(
      {super.key, required this.imageAsset, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45, // Width of the button
        height:
            MediaQuery.of(context).size.height * 0.3, // Height of the button
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imageAsset),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(12.0), // Button border radius
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2), // Shadow offset
            ),
          ],
        ),
      ),
    );
  }
}
