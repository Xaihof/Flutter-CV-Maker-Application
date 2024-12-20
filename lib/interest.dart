import 'package:flutter/material.dart';

import 'Database.dart';
import 'Sizes.dart';

class InterestsScreen extends StatefulWidget {
  String fileName;

  InterestsScreen({super.key, required this.fileName});

  @override
  _InterestsScreenState createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  bool flag1 = false;
  final TextEditingController _interestController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> interests = [];

  @override
  Widget build(BuildContext context) {
    Sizes sizes = Sizes(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Interests',
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
                                  color: sizes.appIconColor,
                                  Icons.home_work_outlined,
                                  size: sizes.mylisticonSize,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    controller: _interestController,
                                    decoration: InputDecoration(
                                      labelText: 'Interest',
                                      labelStyle: TextStyle(
                                          fontSize: sizes.smallfontSize),
                                    ),
                                    style:
                                        TextStyle(fontSize: sizes.listFontSize),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a Interest';
                                      }
                                      return null;
                                    },
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
                          _saveInterests();
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
                                border: Border.all(color: sizes.appIconColor),
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
                        itemCount: interests.length,
                        // Replace with the actual item count you want to display
                        itemBuilder: (context, index) {
                          String interest = interests[index]['interest'];
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
                                        interest,
                                        style: TextStyle(
                                            color: sizes.appBarBgColor,
                                            fontSize: sizes.listFontSize),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    _deleteInterestsbuttons(interest);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    size: sizes.iconSize,
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

  void _saveInterests() async {
    if (_formKey.currentState!.validate()) {
      // Create a map of data
      Map<String, dynamic> Interests = {
        'interest': _interestController.text,
        'fileName': widget.fileName,
        // 'fileName': 'your_file_name_here', // You can add the fileName here
      };

      // Insert data into the Profile table
      String result = await DatabaseHelper.instance.insertInterest(Interests);

      if (result != 'Interest Already Present') {
        // Data inserted successfully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$result!'),
            backgroundColor: Colors.green,
          ),
        );

        // Clear form fields after successful submission

        _interestController.clear();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => InterestsScreen(
                fileName:
                    widget.fileName), // Replace with your new screen widget
          ),
        );
      } else {
        // Error while inserting data
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Interest Already Present.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _loadInterestsbuttons();
  }

  void _loadInterestsbuttons() async {
    List<Map<String, dynamic>> interestsdata = await DatabaseHelper.instance
        .queryInterestsRowsByFileName(widget.fileName);
    setState(() {
      interests = interestsdata;
    });
  }

  void _deleteInterestsbuttons(String interest) async {
    String result = await DatabaseHelper.instance
        .deleteInterests(widget.fileName, interest);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$result!'),
        backgroundColor: Colors.red,
      ),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => InterestsScreen(
            fileName: widget.fileName), // Replace with your new screen widget
      ),
    );
  }
}