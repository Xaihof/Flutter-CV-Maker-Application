import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Database.dart';
import 'Sizes.dart';

class PersonalProfileScreen extends StatefulWidget {
  final String fileName;

  const PersonalProfileScreen({super.key, required this.fileName});

  @override
  _PersonalProfileScreenState createState() => _PersonalProfileScreenState();
}

class _PersonalProfileScreenState extends State<PersonalProfileScreen> {
  String _selectedGender = 'Male'; // Default value
  File? _image;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _objectiveController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Add a global key for the form

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _objectiveController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  Future<void> requestPhotoLibraryPermission(BuildContext context) async {
    PermissionStatus status = await Permission.storage.status;

    if (!status.isGranted) {
      status = await Permission.storage.request();
    }

    if (status.isGranted) {
      _getImage(context);
    } else {
      await showPermissionDeniedDialog(context,
          'Please grant permission to access the photo library in the app settings.');
    }
  }

  Future<void> showPermissionDeniedDialog(
      BuildContext context, String message) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Permission Denied'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await openAppSettings();
              await Future.delayed(const Duration(seconds: 2));
              PermissionStatus status = await Permission.photos.status;
              _handlePermissionStatus(context, status);
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  void _handlePermissionStatus(BuildContext context, PermissionStatus status) {
    if (status.isGranted) {
      _getImage(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permission is still not granted.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _getImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      final int fileSizeInBytes = await imageFile.length();

      if (fileSizeInBytes > 500000) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Image size is too big. Please select an image with size up to 500KB.'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        setState(() {
          _image = imageFile;
        });
        await DatabaseHelper.instance
            .insertOrUpdateImage(widget.fileName, _image!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Sizes sizes = Sizes(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Information',
          style:
              TextStyle(color: sizes.AppBartextColor, fontSize: sizes.fontSize),
        ),
        centerTitle: true,
        backgroundColor: sizes.appBarBgColor,
        toolbarHeight: sizes.barSize,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              colors: [sizes.AppBartextColor, Colors.white],
              stops: const [0.2765, 0.2765],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    colors: [sizes.AppBartextColor, Colors.white],
                    stops: const [1, 1],
                  ),
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: _image != null
                                ? Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/placeholder.jpg',
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 75),
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(Icons.add_circle_outline_rounded,
                                size: sizes.iconSize),
                            onPressed: () {
                              requestPhotoLibraryPermission(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Form Fields
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _firstNameController,
                              decoration: InputDecoration(
                                labelText: 'First Name',
                                labelStyle:
                                    TextStyle(fontSize: sizes.smallfontSize),
                              ),
                              style: TextStyle(fontSize: sizes.listFontSize),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _lastNameController,
                              decoration: InputDecoration(
                                labelText: 'Last Name',
                                labelStyle:
                                    TextStyle(fontSize: sizes.smallfontSize),
                              ),
                              style: TextStyle(fontSize: sizes.listFontSize),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(
                            color: sizes.appBarBgColor,
                            Icons.ac_unit,
                            size: sizes.mylisticonSize,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Profession',
                                labelStyle:
                                    TextStyle(fontSize: sizes.smallfontSize),
                              ),
                              style: TextStyle(fontSize: sizes.listFontSize),
                              controller: _objectiveController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(
                            color: sizes.appBarBgColor,
                            Icons.location_on_outlined,
                            size: sizes.mylisticonSize,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Address',
                                labelStyle:
                                    TextStyle(fontSize: sizes.smallfontSize),
                              ),
                              style: TextStyle(fontSize: sizes.listFontSize),
                              controller: _addressController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(
                            color: sizes.appBarBgColor,
                            Icons.email,
                            size: sizes.mylisticonSize,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email Address',
                                labelStyle:
                                    TextStyle(fontSize: sizes.smallfontSize),
                              ),
                              style: TextStyle(fontSize: sizes.listFontSize),
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(
                            color: sizes.appBarBgColor,
                            Icons.phone,
                            size: sizes.mylisticonSize,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                labelStyle:
                                    TextStyle(fontSize: sizes.smallfontSize),
                              ),
                              style: TextStyle(fontSize: sizes.listFontSize),
                              keyboardType: TextInputType.number,
                              controller: _phoneNumberController,
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
                              decoration: InputDecoration(
                                labelText: 'Date of Birth',
                                labelStyle:
                                    TextStyle(fontSize: sizes.smallfontSize),
                              ),
                              style: TextStyle(fontSize: sizes.listFontSize),
                              controller: _dateOfBirthController,
                              keyboardType: TextInputType.datetime,
                              // Set the keyboard type
                              onTap: () async {
                                final DateTime? pickedDate =
                                    await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );

                                if (pickedDate != null) {
                                  final formattedDate = DateFormat('dd-MM-yyyy')
                                      .format(pickedDate);
                                  _dateOfBirthController.text = formattedDate;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text('Gender:',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: sizes.listFontSize)),
                          ),
                          const SizedBox(width: 40),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Transform.scale(
                                    scale: sizes.radiobuttonsize,
                                    child: Radio<String>(
                                      splashRadius: 5,
                                      value: 'Male',
                                      groupValue: _selectedGender,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedGender = value!;
                                        });
                                      },
                                    ),
                                  ),
                                  Text('Male',
                                      style: TextStyle(
                                          fontSize: sizes.listFontSize)),
                                ],
                              ),
                              Row(
                                children: [
                                  Transform.scale(
                                    scale: sizes.radiobuttonsize,
                                    child: Radio<String>(
                                      splashRadius: 5,
                                      value: 'Female',
                                      groupValue: _selectedGender,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedGender = value!;
                                        });
                                      },
                                    ),
                                  ),
                                  Text('Female',
                                      style: TextStyle(
                                          fontSize: sizes.listFontSize)),
                                ],
                              ),
                              Row(
                                children: [
                                  Transform.scale(
                                    scale: sizes.radiobuttonsize,
                                    child: Radio<String>(
                                      value: 'Other',
                                      groupValue: _selectedGender,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedGender = value!;
                                        });
                                      },
                                    ),
                                  ),
                                  Text('Other',
                                      style: TextStyle(
                                          fontSize: sizes.listFontSize)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: sizes.appBarBgColor,
                        ),
                        onPressed: _saveProfile,
                        child: Text('Save',
                            style: TextStyle(
                                color: sizes.AppBartextColor,
                                fontSize: sizes.listFontSize)),
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

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> profileData = {
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'objective': _objectiveController.text,
        'address': _addressController.text,
        'email': _emailController.text,
        'phoneNumber': _phoneNumberController.text,
        'dateOfBirth': _dateOfBirthController.text,
        'gender': _selectedGender,
        'fileName': widget.fileName,
      };

      String result = await DatabaseHelper.instance.insertProfile(profileData);

      if (result != 'File Name Already Present') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$result!'), backgroundColor: Colors.green),
        );

        _firstNameController.clear();
        _lastNameController.clear();
        _objectiveController.clear();
        _addressController.clear();
        _emailController.clear();
        _phoneNumberController.clear();
        _dateOfBirthController.clear();
        setState(() {
          _selectedGender = 'Male';
        });
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('File Name Already Present.'),
              backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProfileData();
    _getImageFromDatabase();
  }

  Future<void> _getImageFromDatabase() async {
    File? imageFile =
        await DatabaseHelper.instance.getImageByFileName(widget.fileName);
    if (imageFile != null) {
      setState(() {
        _image = imageFile;
      });
    }
  }

  void _loadProfileData() async {
    List<Map<String, dynamic>> profileData = await DatabaseHelper.instance
        .queryProfileRowByFileName(widget.fileName);
    if (profileData.isNotEmpty) {
      Map<String, dynamic> profile = profileData[0];
      setState(() {
        _firstNameController.text = profile['firstName'];
        _lastNameController.text = profile['lastName'];
        _objectiveController.text = profile['objective'];
        _addressController.text = profile['address'];
        _emailController.text = profile['email'];
        _phoneNumberController.text = profile['phoneNumber'];
        _dateOfBirthController.text = profile['dateOfBirth'];
        _selectedGender = profile['gender'];
      });
    }
  }
}
