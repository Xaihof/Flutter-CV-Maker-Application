import 'package:flutter/material.dart';
import 'Database.dart';
import 'Sizes.dart';

class SocialLinksScreen extends StatefulWidget {
  String fileName;
  SocialLinksScreen({super.key, required this.fileName});
  @override
  _SocialLinksScreenState createState() => _SocialLinksScreenState();
}

class _SocialLinksScreenState extends State<SocialLinksScreen> {
  final TextEditingController _linkController = TextEditingController();
  final TextEditingController _linkController1 = TextEditingController();
  final TextEditingController _linkController2 = TextEditingController();
  final TextEditingController _linkController3 = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Sizes sizes = Sizes(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Social Links',
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
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: sizes.appIconColor)
          ),
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),

              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(color: sizes.appIconColor,Icons.facebook_outlined),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _linkController,
                          decoration: const InputDecoration(labelText: 'Facebook.com/'),

                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(color: sizes.appIconColor,Icons.facebook_outlined),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _linkController1,
                          decoration: const InputDecoration(labelText: 'Linkin.com/'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(color: sizes.appIconColor,Icons.facebook_outlined),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _linkController2,
                          decoration: const InputDecoration(labelText: 'Twitter.com/'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(color: sizes.appIconColor,Icons.facebook_outlined),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _linkController3,
                          decoration: const InputDecoration(labelText: 'Instagram.com/'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          )
        ),
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: 150,
          child: FloatingActionButton(
            onPressed: (){
              _saveSocialLinks();
            },
            child: Text('Save',style: TextStyle(fontSize: sizes.listFontSize),),
          ),
        )
    );
  }

  void _saveSocialLinks() async {
    if (_formKey.currentState!.validate()) {
      // Create a map of data
      Map<String, dynamic> SocialLinks = {
        'fblink': _linkController.text,
        'linkedinlink': _linkController1.text,
        'twitterlink': _linkController2.text,
        'instalink': _linkController3.text,
        'fileName': widget.fileName,
        // 'fileName': 'your_file_name_here', // You can add the fileName here
      };

      // Insert data into the Profile table
      String result = await DatabaseHelper.instance.insertSocialLinks(SocialLinks);

      if (result != 'File Name Already Present') {
        // Data inserted successfully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$result!'),backgroundColor: Colors.green,),
        );

        // Clear form fields after successful submission
        _linkController.clear();
        _linkController1.clear();
        _linkController2.clear();
        _linkController3.clear();
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
    _loadSocialLinks();
  }

  void _loadSocialLinks() async {
    List<Map<String, dynamic>> objectivedata = await DatabaseHelper.instance.querySocialLinksRowByFileName(widget.fileName);
    if(objectivedata.isNotEmpty){
      Map<String, dynamic> objective = objectivedata[0];
      setState(() {
        _linkController.text = objective['fblink'];
        _linkController1.text = objective['linkedinlink'];
        _linkController2.text = objective['twitterlink'];
        _linkController3.text = objective['instalink'];
      });
    }
  }


}