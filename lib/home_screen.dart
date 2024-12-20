import 'package:flutter/material.dart';

import 'Database.dart';
import 'Sizes.dart';
import 'cover_letters/my_cover_letter.dart';
import 'cv_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool cvcreated = false;
  String fileName = '';
  final _formKey = GlobalKey<FormState>();

  Future<void> _showFileNameDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        Sizes sizes = Sizes(context);

        return WillPopScope(
          child: AlertDialog(
            title: const Text('Enter CV Name'),
            content: Form(
              key: _formKey,
              child: TextFormField(
                onChanged: (value) {
                  fileName = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a CV name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'CV Name',
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel',
                    style: TextStyle(color: sizes.appBarBgColor)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child:
                    Text('Save', style: TextStyle(color: sizes.appBarBgColor)),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      fileName = fileName;
                    });
                    String result = await DatabaseHelper.insertName(fileName);
                    if (result != 'File Name Already Present') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Name saved successfully!'),
                            backgroundColor: Colors.green),
                      );
                      Navigator.of(context).pop();
                      setState(() {
                        cvcreated = true;
                      });
                      movescreen();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('File Name Already Present.'),
                            backgroundColor: Colors.red),
                      );
                      setState(() {
                        cvcreated = false;
                      });
                      Navigator.of(context).pop();
                    }
                  }
                },
              ),
            ],
          ),
          onWillPop: () async {
            return false;
          },
        );
      },
    );
  }

  void movescreen() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CVInfo(fileName: fileName)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("CV Maker")),
      ),
      body: Center(
        child: Card.outlined(
          child: SizedBox(
            width: 280,
            height: 280,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Select To Start Creating",
                  style: TextStyle(fontSize: 21),
                ),
                SizedBox(
                  width: 210,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyCoverLettersProfiles(),
                        ),
                      );
                    },
                    child: const Text("Cover Letter Maker"),
                  ),
                ),
                // CV
                SizedBox(
                  width: 210,
                  child: OutlinedButton(
                    onPressed: () {
                      movescreen();
                    },
                    child: const Text("CV Maker"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
