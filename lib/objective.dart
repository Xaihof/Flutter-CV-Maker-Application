import 'package:flutter/material.dart';
import 'Database.dart';
import 'Sizes.dart';

class ObjectiveScreen extends StatefulWidget {
  String fileName;
  ObjectiveScreen({super.key, required this.fileName});
  @override
  _ObjectiveScreenState createState() => _ObjectiveScreenState();
}

class _ObjectiveScreenState extends State<ObjectiveScreen> {
  final TextEditingController _objectiveController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    Sizes sizes = Sizes(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Objective',
          style: TextStyle(color: sizes.AppBartextColor,fontSize: sizes.fontSize),
        ),
        centerTitle: true,
        backgroundColor: sizes.appBarBgColor,
        toolbarHeight: sizes.barSize,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: sizes.AppBartextColor),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  offset: const Offset(0, 2),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: TextFormField(
              controller: _objectiveController,
              decoration: InputDecoration(
                labelText: 'Objective',
                border: InputBorder.none,

                labelStyle: TextStyle(fontSize: sizes.smallfontSize),
              ),
              style: TextStyle(fontSize: sizes.listFontSize),

              maxLines: 6,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an objective.';
                }
                return null;
              },
            ),
          ),
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: (){
          _saveObjective();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: sizes.appBarBgColor,
          // Adjust the size as needed
        ),
        child: Text(' Save ',style: TextStyle(fontSize: sizes.fontSize,color: sizes.AppBartextColor),),
      ),

    );
  }

  void _saveObjective() async {
    if (_formKey.currentState!.validate()) {
      // Create a map of data
      Map<String, dynamic> Objectives = {
        'objective': _objectiveController.text,
        'fileName': widget.fileName,
        // 'fileName': 'your_file_name_here', // You can add the fileName here
      };

      // Insert data into the Profile table
      String result = await DatabaseHelper.instance.insertObjective(Objectives);

      if (result != 'File Name Already Present') {
        // Data inserted successfully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$result!'),backgroundColor: Colors.green,),
        );

        // Clear form fields after successful submission
        _objectiveController.clear();
        Navigator.pop(context);
      } else {
        // Error while inserting data
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File Name Already Present.'),backgroundColor: Colors.red,),
        );
      }
    }
  }


  @override
  void initState() {
    super.initState();

    _loadObjective();
  }

  void _loadObjective() async {
    List<Map<String, dynamic>> objectivedata = await DatabaseHelper.instance.queryObjectiveRowByFileName(widget.fileName);
    if(objectivedata.isNotEmpty){
      Map<String, dynamic> objective = objectivedata[0];
      setState(() {
        _objectiveController.text = objective['objective'];
      });
    }
  }

}