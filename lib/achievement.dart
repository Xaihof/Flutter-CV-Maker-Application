import 'package:flutter/material.dart';

import 'Database.dart';
import 'Sizes.dart';

class AchievementsScreen extends StatefulWidget {
  String fileName;

  AchievementsScreen({super.key, required this.fileName});

  @override
  _AchievementsScreenState createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  bool flag1 = false;
  final TextEditingController _achievementsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> achievements = [];

  @override
  Widget build(BuildContext context) {
    Sizes sizes = Sizes(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Achievements',
          style:
              TextStyle(color: sizes.AppBartextColor, fontSize: sizes.fontSize),
        ),
        centerTitle: true,
        backgroundColor: sizes.appBarBgColor,
        toolbarHeight: sizes.barSize,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black)),
          child: Column(
            children: [
              Visibility(
                visible: flag1,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  color: sizes.appIconColor,
                                  Icons.home_work_outlined,
                                  size: sizes.mylisticonSize,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    controller: _achievementsController,
                                    decoration: InputDecoration(
                                      labelText: 'Achievement',
                                      labelStyle: TextStyle(
                                          fontSize: sizes.smallfontSize),
                                    ),
                                    style:
                                        TextStyle(fontSize: sizes.listFontSize),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: sizes.appBarBgColor,
                          // Adjust the size as needed
                        ),
                        onPressed: () {
                          // Handle form submission
                          _saveAchievement();
                          setState(() {
                            flag1 = false;
                          });
                        },
                        child: Text(
                          ' Save ',
                          style: TextStyle(
                              color: sizes.AppBartextColor,
                              fontSize: sizes.listFontSize),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                  visible: !flag1,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              flag1 = true;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: sizes.appBarBgColor),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.add_box_outlined,
                                  color: sizes.AppBartextColor,
                                  size: sizes.mylisticonSize,
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  'Add',
                                  style: TextStyle(
                                      color: sizes.AppBartextColor,
                                      fontSize: sizes.listFontSize),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: achievements.length,
                        // Replace with the actual item count you want to display
                        itemBuilder: (context, index) {
                          String achievement =
                              achievements[index]['achievement'];
                          // Return your list item widget here
                          // For example:
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Card(
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  width: 200,
                                  height: 75,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: sizes.AppBartextColor),
                                  child: Center(
                                    child: Text(
                                      achievement,
                                      style: TextStyle(
                                          color: sizes.appBarBgColor,
                                          fontSize: sizes.listFontSize),
                                    ),
                                  ),
                                ),
                              )),
                              IconButton(
                                  onPressed: () {
                                    _deleteAchievementsbuttons(achievement);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    size: 40,
                                    color: sizes.appBarBgColor,
                                  )),
                            ],
                          );
                        },
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _saveAchievement() async {
    if (_formKey.currentState!.validate()) {
      // Create a map of data
      Map<String, dynamic> Achievement = {
        'achievement': _achievementsController.text,
        'fileName': widget.fileName,
        // 'fileName': 'your_file_name_here', // You can add the fileName here
      };

      // Insert data into the Profile table
      String result =
          await DatabaseHelper.instance.insertAchievement(Achievement);

      if (result != 'Achievement Already Present') {
        // Data inserted successfully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$result!'),
            backgroundColor: Colors.green,
          ),
        );

        // Clear form fields after successful submission

        _achievementsController.clear();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AchievementsScreen(
                fileName:
                    widget.fileName), // Replace with your new screen widget
          ),
        );
      } else {
        // Error while inserting data
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Achievement Already Present.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _loadAchievementsbuttons();
  }

  void _loadAchievementsbuttons() async {
    List<Map<String, dynamic>> achievementsdata = await DatabaseHelper.instance
        .queryAchievementsRowsByFileName(widget.fileName);
    setState(() {
      achievements = achievementsdata;
    });
  }

  void _deleteAchievementsbuttons(String achievement) async {
    String result = await DatabaseHelper.instance
        .deleteAchievements(widget.fileName, achievement);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$result!'),
        backgroundColor: Colors.red,
      ),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AchievementsScreen(
            fileName: widget.fileName), // Replace with your new screen widget
      ),
    );
  }
}
