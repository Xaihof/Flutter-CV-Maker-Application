import 'package:flutter/material.dart';

import 'Database.dart';
import 'Sizes.dart';

class ExperienceScreen extends StatefulWidget {
  String fileName;

  ExperienceScreen({super.key, required this.fileName});

  @override
  _ExperienceScreenState createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> experience = [];
  bool flag1 = false;
  int id = 0;

  @override
  Widget build(BuildContext context) {
    Sizes sizes = Sizes(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Experiences',
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
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: sizes.appIconColor)),
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
                                  color: sizes.appBarBgColor,
                                  Icons.home_work_outlined,
                                  size: sizes.mylisticonSize,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    controller: _companyController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      labelText: 'Company Name',
                                      labelStyle: TextStyle(
                                          fontSize: sizes.smallfontSize),
                                    ),
                                    style:
                                        TextStyle(fontSize: sizes.listFontSize),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter Company Name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(
                                  color: sizes.appBarBgColor,
                                  Icons.backpack,
                                  size: sizes.mylisticonSize,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    controller: _jobController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      labelText: 'Job Designation',
                                      labelStyle: TextStyle(
                                          fontSize: sizes.smallfontSize),
                                    ),
                                    style:
                                        TextStyle(fontSize: sizes.listFontSize),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter Job Title';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(
                                  color: sizes.appBarBgColor,
                                  Icons.event_note,
                                  size: sizes.mylisticonSize,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    controller: _detailController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      labelText: 'Details',
                                      labelStyle: TextStyle(
                                          fontSize: sizes.smallfontSize),
                                    ),
                                    style:
                                        TextStyle(fontSize: sizes.listFontSize),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter Job Detail';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(
                                  color: sizes.appBarBgColor,
                                  Icons.calendar_today,
                                  size: sizes.mylisticonSize,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    controller: _startController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      labelText: 'Start Date',
                                      labelStyle: TextStyle(
                                          fontSize: sizes.smallfontSize),
                                    ),
                                    style:
                                        TextStyle(fontSize: sizes.listFontSize),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      _startController.text = value;
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter Start Date';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Icon(
                                  color: sizes.appBarBgColor,
                                  Icons.calendar_today,
                                  size: sizes.mylisticonSize,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    controller: _endController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      labelText: 'End Date',
                                      labelStyle: TextStyle(
                                          fontSize: sizes.smallfontSize),
                                    ),
                                    style:
                                        TextStyle(fontSize: sizes.listFontSize),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      _endController.text = value;
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter end Date';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
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
                          _saveExperience();
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
                        itemCount: experience.length,
                        // Replace with the actual item count you want to display
                        itemBuilder: (context, index) {
                          String company = experience[index]['company'];
                          int ids = experience[index]['id'];
                          // Return your list item widget here
                          // For example:
                          return Container(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _loadExperience(ids);
                                      setState(() {
                                        flag1 = true;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      backgroundColor: sizes.AppBartextColor,
                                      minimumSize: const Size(
                                          200, 75), // Adjust the size as needed
                                    ),
                                    child: Text(
                                      company,
                                      style: TextStyle(
                                          color: sizes.appBarBgColor,
                                          fontSize: sizes.listFontSize),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      _deleteExperiencebuttons(ids);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      size: sizes.iconSize,
                                      color: sizes.appBarBgColor,
                                    )),
                              ],
                            ),
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

  void _saveExperience() async {
    if (_formKey.currentState!.validate()) {
      // Create a map of data
      Map<String, dynamic> Experience = {
        'id': id,
        'company': _companyController.text,
        'job': _jobController.text,
        'details': _detailController.text,
        'startdate': _startController.text,
        'enddate': _endController.text,
        'fileName': widget.fileName,
        // 'fileName': 'your_file_name_here', // You can add the fileName here
      };

      // Insert data into the Profile table
      String result =
          await DatabaseHelper.instance.insertExperience(Experience);
      setState(() {
        id = id + 1;
      });

      if (result == 'Experience limit exceeds') {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Experience Limit Full'),
              content: const Text('You cannot add more than 3 experience entries.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExperienceScreen(
                            fileName: widget
                                .fileName), // Replace with your new screen widget
                      ),
                    );
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Data inserted successfully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$result!'),
            backgroundColor: Colors.green,
          ),
        );

        // Clear form fields after successful submission
        _companyController.clear();
        _jobController.clear();
        _detailController.clear();
        _startController.clear();
        _endController.clear();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ExperienceScreen(
                fileName:
                    widget.fileName), // Replace with your new screen widget
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _loadExperiencebuttons();
  }

  void _loadExperiencebuttons() async {
    List<Map<String, dynamic>> experiencedata = await DatabaseHelper.instance
        .queryExperienceRowsByFileName(widget.fileName);
    setState(() {
      experience = experiencedata;
      id = experiencedata.length;
    });
  }

  void _loadExperience(int ids) async {
    List<Map<String, dynamic>> experiencedata = await DatabaseHelper.instance
        .queryExperienceRowByFileNameAndInstitute(widget.fileName, ids);
    if (experiencedata.isNotEmpty) {
      Map<String, dynamic> experience = experiencedata[0];
      setState(() {
        id = experience['id'];
        _companyController.text = experience['company'];
        _jobController.text = experience['job'];
        _detailController.text = experience['details'];
        _startController.text = experience['startdate'];
        _endController.text = experience['enddate'];
      });
    }
  }

  void _deleteExperiencebuttons(int ids) async {
    String result =
        await DatabaseHelper.instance.deleteExperience(widget.fileName, ids);
    setState(() {
      id = id - 1;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$result!'),
        backgroundColor: Colors.red,
      ),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ExperienceScreen(
            fileName: widget.fileName), // Replace with your new screen widget
      ),
    );
  }
}
