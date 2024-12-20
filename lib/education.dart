import 'package:flutter/material.dart';

import 'Database.dart';
import 'Sizes.dart';

class EducationScreen extends StatefulWidget {
  String fileName;

  EducationScreen({super.key, required this.fileName});

  @override
  _EducationScreenState createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  final TextEditingController _instituteController = TextEditingController();
  final TextEditingController _degreeController = TextEditingController();
  final TextEditingController _marksController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> education = [];
  bool flag1 = false;
  int id = 0;

  @override
  Widget build(BuildContext context) {
    Sizes sizes = Sizes(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Education',
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
                                    color: sizes.appBarBgColor,
                                    Icons.home_work_outlined,
                                    size: sizes.mylisticonSize,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _instituteController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                        labelText: 'Institute',
                                        labelStyle: TextStyle(
                                            fontSize: sizes.smallfontSize),
                                      ),
                                      style: TextStyle(
                                          fontSize: sizes.listFontSize),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter Institute Name';
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
                                    Icons.school,
                                    size: sizes.mylisticonSize,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _degreeController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                        labelText: 'Course/Degree',
                                        labelStyle: TextStyle(
                                            fontSize: sizes.smallfontSize),
                                      ),
                                      style: TextStyle(
                                          fontSize: sizes.listFontSize),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter a Degree';
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
                                    Icons.home_work_outlined,
                                    size: sizes.mylisticonSize,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _marksController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                        labelText: 'Marks Percentage/CGPA',
                                        labelStyle: TextStyle(
                                            fontSize: sizes.smallfontSize),
                                      ),
                                      style: TextStyle(
                                          fontSize: sizes.listFontSize),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter Marks Percentage/CGPA';
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
                                      style: TextStyle(
                                          fontSize: sizes.listFontSize),
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
                                      style: TextStyle(
                                          fontSize: sizes.listFontSize),
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
                            _saveEducation();
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
                  )),
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
                      itemCount: education.length,
                      // Replace with the actual item count you want to display
                      itemBuilder: (context, index) {
                        String institute = education[index]['institute'];
                        int ids = education[index]['id'];
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
                                    _loadEducation(ids);
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
                                    institute,
                                    style: TextStyle(
                                        color: sizes.appBarBgColor,
                                        fontSize: sizes.listFontSize),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    _deleteEducationbuttons(ids);
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveEducation() async {
    // Check if the table already has 3 rows
    if (_formKey.currentState!.validate()) {
      // Create a map of data
      Map<String, dynamic> Education = {
        'id': id,
        'institute': _instituteController.text,
        'degree': _degreeController.text,
        'university': _marksController.text,
        'startdate': _startController.text,
        'enddate': _endController.text,
        'fileName': widget.fileName,
        // 'fileName': 'your_file_name_here', // You can add the fileName here
      };

      // Insert data into the Profile table
      String result = await DatabaseHelper.instance.insertEducation(Education);
      setState(() {
        id = id + 1;
      });

      if (result == 'Education limit exceeds') {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Education Limit Full'),
              content: const Text('You cannot add more than 3 education entries.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EducationScreen(
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$result!'),
            backgroundColor: Colors.green,
          ),
        );

        // Clear form fields after successful submission
        _instituteController.clear();
        _degreeController.clear();
        _marksController.clear();
        _startController.clear();
        _endController.clear();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EducationScreen(
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

    _loadEducationbuttons();
  }

  void _loadEducationbuttons() async {
    List<Map<String, dynamic>> educationdata = await DatabaseHelper.instance
        .queryEducationRowsByFileName(widget.fileName);
    setState(() {
      education = educationdata;
      id = educationdata.length;
    });
  }

  void _loadEducation(int ids) async {
    List<Map<String, dynamic>> educationdata = await DatabaseHelper.instance
        .queryEducationRowByFileNameAndInstitute(widget.fileName, ids);
    if (educationdata.isNotEmpty) {
      Map<String, dynamic> education = educationdata[0];
      setState(() {
        id = education['id'];
        _instituteController.text = education['institute'];
        _degreeController.text = education['degree'];
        _marksController.text = education['university'];
        _startController.text = education['startdate'];
        _endController.text = education['enddate'];
      });
    }
  }

  void _deleteEducationbuttons(int ids) async {
    String result =
        await DatabaseHelper.instance.deleteEducation(widget.fileName, ids);
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
        builder: (context) => EducationScreen(
            fileName: widget.fileName), // Replace with your new screen widget
      ),
    );
  }
}
