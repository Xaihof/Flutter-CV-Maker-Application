import 'package:flutter/material.dart';
import 'Database.dart';
import 'Sizes.dart';


class SkillsScreen extends StatefulWidget {
  String fileName;
  SkillsScreen({super.key, required this.fileName});
  @override
  _SkillsScreenState createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  bool flag1 = false;
  final TextEditingController _skillController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> skills = [];


  @override
  Widget build(BuildContext context) {
    Sizes sizes = Sizes(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Skills',
          style: TextStyle(color: sizes.AppBartextColor,fontSize: sizes.fontSize),
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
              border: Border.all(color: sizes.appIconColor)
          ),
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
                                Icon(color: sizes.appBarBgColor,Icons.home_work_outlined,size: sizes.mylisticonSize,),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    controller: _skillController,
                                    decoration: InputDecoration(labelText: 'Skill',
                                      labelStyle: TextStyle(fontSize: sizes.smallfontSize),
                                    ),
                                    style: TextStyle(fontSize: sizes.listFontSize),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a Skill';
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
                          _saveSkills();
                          setState(() {
                            flag1=false;
                          });
                        },
                        child: Text(' Save ',style: TextStyle(color: sizes.AppBartextColor,fontSize: sizes.listFontSize),),
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
                              flag1=true;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(color: sizes.appIconColor),
                                borderRadius: BorderRadius.circular(10),
                              color: sizes.appBarBgColor
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.add_box_outlined,
                                  color: sizes.AppBartextColor,
                                  size: sizes.mylisticonSize,
                                ),
                                const SizedBox(width: 16),
                                Text('Add',style: TextStyle(color: sizes.AppBartextColor,fontSize: sizes.listFontSize),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: skills.length, // Replace with the actual item count you want to display
                        itemBuilder: (context, index) {
                          String skill = skills[index]['skill'];
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
                                    color: sizes.AppBartextColor
                                  ),
                                  child: Center(child: Text(skill,style: TextStyle(color: sizes.appBarBgColor,fontSize: sizes.listFontSize),),),
                                ),
                              ),
                              ),
                              IconButton(onPressed: (){
                                _deleteSkillsbuttons(skill);
                              },
                                  icon: Icon(Icons.delete,size: sizes.iconSize,color: sizes.appBarBgColor,)),
                            ],
                          );
                        },
                      ),
                    ],
                  )
              ),

            ],
          ),
        ),
      ),

    );
  }

  void _saveSkills() async {
    if (_formKey.currentState!.validate()) {
      // Create a map of data
      Map<String, dynamic> Skills = {
        'skill': _skillController.text,
        'fileName': widget.fileName,
        // 'fileName': 'your_file_name_here', // You can add the fileName here
      };

      // Insert data into the Profile table
      String result = await DatabaseHelper.instance.insertSkills(Skills);

      if (result != 'Skill Already Present') {
        // Data inserted successfully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$result!'),backgroundColor: Colors.green,),
        );

        // Clear form fields after successful submission

        _skillController.clear();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SkillsScreen(fileName: widget.fileName), // Replace with your new screen widget
          ),
        );
      } else {
        // Error while inserting data
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Skill Already Present.'),backgroundColor: Colors.red,),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _loadSkillsbuttons();
  }

  void _loadSkillsbuttons() async {
    List<Map<String, dynamic>> skillsdata = await DatabaseHelper.instance.querySkillsRowsByFileName(widget.fileName);
    setState(() {
      skills=skillsdata;
    });
  }

  void _deleteSkillsbuttons(String skill) async {
    String result = await DatabaseHelper.instance.deleteSkills(widget.fileName,skill);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$result!'),backgroundColor: Colors.red,),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SkillsScreen(fileName: widget.fileName), // Replace with your new screen widget
      ),
    );
  }

}