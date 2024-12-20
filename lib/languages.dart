import 'package:flutter/material.dart';
import 'Database.dart';
import 'Sizes.dart';

class LanguagesScreen extends StatefulWidget {
  String fileName;

  LanguagesScreen({super.key, required this.fileName});

  @override
  _LanguagesScreenState createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  bool flag1 = false;
  final TextEditingController _languageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> languages = [];

  @override
  Widget build(BuildContext context) {
    Sizes sizes = Sizes(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Languages',
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
                        itemCount: languages.length,
                        // Replace with the actual item count you want to display
                        itemBuilder: (context, index) {
                          String language = languages[index]['language'];
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
                                        language,
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
                                    _deleteLanguagesbuttons(language);
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
                                  color: sizes.appBarBgColor,
                                  Icons.home_work_outlined,
                                  size: sizes.mylisticonSize,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    controller: _languageController,
                                    decoration: InputDecoration(
                                      labelText: 'Language',
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
                          _saveLanguages();
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

  void _saveLanguages() async {
    if (_formKey.currentState!.validate()) {
      // Create a map of data
      Map<String, dynamic> language = {
        'language': _languageController.text,
        'fileName': widget.fileName,
        // 'fileName': 'your_file_name_here', // You can add the fileName here
      };

      // Insert data into the Profile table
      String result = await DatabaseHelper.instance.insertLanguages(language);

      if (result != 'Language Already Present') {
        // Data inserted successfully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$result!'),
            backgroundColor: Colors.green,
          ),
        );

        // Clear form fields after successful submission

        _languageController.clear();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LanguagesScreen(
                fileName:
                    widget.fileName), // Replace with your new screen widget
          ),
        );
      } else {
        // Error while inserting data
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Language Already Present.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _loadLanguagesbuttons();
  }

  void _loadLanguagesbuttons() async {
    List<Map<String, dynamic>> languagesdata = await DatabaseHelper.instance
        .queryLanguagesRowsByFileName(widget.fileName);
    setState(() {
      languages = languagesdata;
    });
  }

  void _deleteLanguagesbuttons(String achievement) async {
    String result = await DatabaseHelper.instance
        .deleteLanguages(widget.fileName, achievement);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$result!'),
        backgroundColor: Colors.red,
      ),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LanguagesScreen(
            fileName: widget.fileName), // Replace with your new screen widget
      ),
    );
  }
}
