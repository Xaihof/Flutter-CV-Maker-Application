import 'package:flutter/material.dart';

import 'Database.dart';
import 'Sizes.dart';
import 'cv_info.dart';

class EditCvScreen extends StatefulWidget {
  const EditCvScreen({super.key});

  @override
  _EditCvScreenState createState() => _EditCvScreenState();
}

class _EditCvScreenState extends State<EditCvScreen> {
  List<Map<String, dynamic>> _NamesList = [];

  @override
  void initState() {
    super.initState();

    fetchProfiles();
  }

  Future<void> fetchProfiles() async {
    List<Map<String, dynamic>> profiles =
        await DatabaseHelper.instance.queryAllNameRows();
    setState(() {
      _NamesList = profiles;
    });
  }

  @override
  Widget build(BuildContext context) {
    Sizes sizes = Sizes(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit CV',
          style:
              TextStyle(color: sizes.AppBartextColor, fontSize: sizes.fontSize),
        ),
        centerTitle: true,
        backgroundColor: sizes.appBarBgColor,
        toolbarHeight: sizes.barSize,
      ),
      body: ListView.builder(
        itemCount: _NamesList.length,
        itemBuilder: (context, index) {
          String fileName = _NamesList[index]['name'];
          return Container(
            padding: const EdgeInsets.all(10),
            child: CustomIconButton(
              imagePath: 'assets/edit cv.png',
              text: fileName,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CVInfo(fileName: fileName)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
