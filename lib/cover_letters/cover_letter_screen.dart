import 'package:flutter/material.dart';
import 'cover_dp_helper.dart';

class CreateCoverLetter extends StatefulWidget {
  const CreateCoverLetter({super.key});

  @override
  _CreateCoverLetterState createState() => _CreateCoverLetterState();
}

class _CreateCoverLetterState extends State<CreateCoverLetter> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _yourNameController = TextEditingController();
  final TextEditingController _yourAddressController = TextEditingController();
  final TextEditingController _yourCityController = TextEditingController();
  final TextEditingController _yourEmailController = TextEditingController();
  final TextEditingController _yourPhoneController = TextEditingController();
  final TextEditingController _employerNameController = TextEditingController();
  final TextEditingController _employerTitleController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _companyAddressController = TextEditingController();
  final TextEditingController _companyCityController = TextEditingController();
  final TextEditingController _contentController = TextEditingController(text: '''
Dear [Mr./Ms./Dr.] [Last Name],

I am writing to apply for the [Job Title] position at [Company's Name], as advertised on [where you found the job posting]. With over [number] years of experience in [your industry or field], I have developed a robust skill set that I am excited to bring to your esteemed company.

In my most recent role at [Previous Company], I successfully [describe a significant achievement or responsibility]. This experience has equipped me with strong [relevant skills], including [skill 1], [skill 2], and [skill 3]. I have consistently demonstrated my ability to [mention a relevant competency], which I am eager to bring to [Company's Name].

What particularly excites me about this opportunity is [something you admire about the company or the role]. I am impressed by [specific aspect of the company’s work], and I am enthusiastic about the prospect of contributing to [specific project or goal of the company].

I am confident that my background, skills, and enthusiasm for [related field or industry] make me a suitable candidate for this role. I look forward to the opportunity to discuss how my experience and abilities align with your needs. I am available for an interview at your convenience and can be reached at [Your Phone Number] or [Your Email Address].

Thank you for considering my application.

Best regards,
[Your Name]
''');

  void _saveCoverLetter() async {
    final title = _titleController.text;
    final yourName = _yourNameController.text;
    final yourAddress = _yourAddressController.text;
    final yourCity = _yourCityController.text;
    final yourEmail = _yourEmailController.text;
    final yourPhone = _yourPhoneController.text;
    final employerName = _employerNameController.text;
    final employerTitle = _employerTitleController.text;
    final companyName = _companyNameController.text;
    final companyAddress = _companyAddressController.text;
    final companyCity = _companyCityController.text;
    final content = _contentController.text;

    if (title.isNotEmpty && yourName.isNotEmpty && yourAddress.isNotEmpty && yourCity.isNotEmpty &&
        yourEmail.isNotEmpty && yourPhone.isNotEmpty && employerName.isNotEmpty &&
        employerTitle.isNotEmpty && companyName.isNotEmpty && companyAddress.isNotEmpty &&
        companyCity.isNotEmpty && content.isNotEmpty) {
      await DatabaseHelper().insertCoverLetter({
        'title': title,
        'yourName': yourName,
        'yourAddress': yourAddress,
        'yourCity': yourCity,
        'yourEmail': yourEmail,
        'yourPhone': yourPhone,
        'employerName': employerName,
        'employerTitle': employerTitle,
        'companyName': companyName,
        'companyAddress': companyAddress,
        'companyCity': companyCity,
        'content': content
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cover letter saved')));
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill in all fields')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Cover Letter'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 20),
              const Text('Personal Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextField(
                controller: _yourNameController,
                decoration: const InputDecoration(labelText: 'Your Name'),
              ),
              TextField(
                controller: _yourAddressController,
                decoration: const InputDecoration(labelText: 'Your Address'),
              ),
              TextField(
                controller: _yourCityController,
                decoration: const InputDecoration(labelText: 'Your City'),
              ),
              TextField(
                controller: _yourEmailController,
                decoration: const InputDecoration(labelText: 'Your Email Address'),
              ),
              TextField(
                controller: _yourPhoneController,
                decoration: const InputDecoration(labelText: 'Your Phone Number'),
              ),
              const SizedBox(height: 20),
              const Text('Company Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextField(
                controller: _employerNameController,
                decoration: const InputDecoration(labelText: "Employer's Name"),
              ),
              TextField(
                controller: _employerTitleController,
                decoration: const InputDecoration(labelText: "Employer's Title"),
              ),
              TextField(
                controller: _companyNameController,
                decoration: const InputDecoration(labelText: "Company's Name"),
              ),
              TextField(
                controller: _companyAddressController,
                decoration: const InputDecoration(labelText: "Company's Address"),
              ),
              TextField(
                controller: _companyCityController,
                decoration: const InputDecoration(labelText: 'City, State, ZIP Code'),
              ),
              const SizedBox(height: 20),
              const Text('Cover Letter Content', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: 'Content'),
                maxLines: 10,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveCoverLetter,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
