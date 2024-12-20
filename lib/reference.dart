import 'package:flutter/material.dart';

import 'Database.dart';
import 'Sizes.dart';

class ReferencesScreen extends StatefulWidget {
  String fileName;

  ReferencesScreen({super.key, required this.fileName});

  @override
  _ReferencesScreenState createState() => _ReferencesScreenState();
}

class _ReferencesScreenState extends State<ReferencesScreen> {
  bool flag1 = false;
  final TextEditingController _refController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int id = 0;
  List<Map<String, dynamic>> reference = [];

  @override
  Widget build(BuildContext context) {
    Sizes sizes = Sizes(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'References',
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
                        itemCount: reference.length,
                        // Replace with the actual item count you want to display
                        itemBuilder: (context, index) {
                          int ids = reference[index]['id'];
                          String ref = reference[index]['reference'];
                          // Return your list item widget here
                          // For example:
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  _loadReference(ids);
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
                                  ref,
                                  style: TextStyle(
                                      color: sizes.appBarBgColor,
                                      fontSize: sizes.listFontSize),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    _deleteReferencebuttons(ids);
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
                                  Icons.event_note,
                                  size: sizes.mylisticonSize,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    controller: _refController,
                                    decoration: InputDecoration(
                                      labelText: 'References',
                                      labelStyle: TextStyle(
                                          fontSize: sizes.smallfontSize),
                                    ),
                                    style:
                                        TextStyle(fontSize: sizes.listFontSize),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter reference';
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
                                  color: sizes.appIconColor,
                                  Icons.backpack,
                                  size: sizes.mylisticonSize,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    controller: _jobController,
                                    decoration: InputDecoration(
                                      labelText: 'Job Title',
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
                                  color: sizes.appIconColor,
                                  Icons.home_work_outlined,
                                  size: sizes.mylisticonSize,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    controller: _companyController,
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
                                  color: sizes.appIconColor,
                                  Icons.email,
                                  size: sizes.mylisticonSize,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      labelText: 'Email Address',
                                      labelStyle: TextStyle(
                                          fontSize: sizes.smallfontSize),
                                    ),
                                    style:
                                        TextStyle(fontSize: sizes.listFontSize),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter Email';
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
                                  color: sizes.appIconColor,
                                  Icons.phone,
                                  size: sizes.mylisticonSize,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    controller: _phoneController,
                                    decoration: InputDecoration(
                                      labelText: 'Phone Number',
                                      labelStyle: TextStyle(
                                          fontSize: sizes.smallfontSize),
                                    ),
                                    style:
                                        TextStyle(fontSize: sizes.listFontSize),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter Phone Number';
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
                          _saveReference();
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
            ],
          ),
        ),
      ),
    );
  }

  void _saveReference() async {
    if (_formKey.currentState!.validate()) {
      // Create a map of data
      Map<String, dynamic> Reference = {
        'id': id,
        'reference': _refController.text,
        'job': _jobController.text,
        'company': _companyController.text,
        'email': _emailController.text,
        'phoneNumber': _phoneController.text,
        'fileName': widget.fileName,
        // 'fileName': 'your_file_name_here', // You can add the fileName here
      };

      // Insert data into the Profile table
      String result = await DatabaseHelper.instance.insertReference(Reference);
      setState(() {
        id = id + 1;
      });

      if (result !=
          'References saved successfully! OR References Updated Successfully') {
        // Data inserted successfully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$result!'),
            backgroundColor: Colors.green,
          ),
        );

        // Clear form fields after successful submission
        _refController.clear();
        _jobController.clear();
        _companyController.clear();
        _phoneController.clear();
        _phoneController.clear();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ReferencesScreen(
                fileName:
                    widget.fileName), // Replace with your new screen widget
          ),
        );
      } else {
        // Error while inserting data
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Reference Already Present.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _loadReferencebuttons();
  }

  void _loadReferencebuttons() async {
    List<Map<String, dynamic>> referencedata = await DatabaseHelper.instance
        .queryReferenceRowsByFileName(widget.fileName);
    setState(() {
      reference = referencedata;
      id = referencedata.length;
    });
  }

  void _loadReference(int ids) async {
    List<Map<String, dynamic>> referencedata = await DatabaseHelper.instance
        .queryReferenceRowByFileNameAndid(widget.fileName, ids);
    if (referencedata.isNotEmpty) {
      Map<String, dynamic> reference = referencedata[0];
      setState(() {
        id = reference['id'];
        _refController.text = reference['reference'];
        _jobController.text = reference['job'];
        _companyController.text = reference['company'];
        _emailController.text = reference['email'];
        _phoneController.text = reference['phoneNumber'];
      });
    }
  }

  void _deleteReferencebuttons(int ids) async {
    String result =
        await DatabaseHelper.instance.deleteReference(widget.fileName, ids);
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
        builder: (context) => ReferencesScreen(
            fileName: widget.fileName), // Replace with your new screen widget
      ),
    );
  }
}
