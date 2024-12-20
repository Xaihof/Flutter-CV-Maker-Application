import 'package:flutter/material.dart';
import 'cover_dp_helper.dart';
import 'cover_templates.dart';


class CoverLetterProfile extends StatefulWidget {
  final int id;

  const CoverLetterProfile({super.key, required this.id});

  @override
  _CoverLetterProfileState createState() => _CoverLetterProfileState();
}

class _CoverLetterProfileState extends State<CoverLetterProfile> {
  late Future<Map<String, dynamic>?> _coverLetter;
  bool _isEditingContent = false;
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCoverLetter();
  }

  void _loadCoverLetter() {
    _coverLetter = DatabaseHelper().getCoverLetter(widget.id);
  }

  void _deleteCoverLetter() async {
    await DatabaseHelper().deleteCoverLetter(widget.id);
    Navigator.pop(context, true);
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Cover Letter'),
          content: const Text('Do you want to delete this cover letter?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                _deleteCoverLetter(); // Delete the cover letter
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _editField(String field, String currentValue) {
    TextEditingController controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $field'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: field),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await DatabaseHelper().updateCoverLetterField(widget.id, field, controller.text);
                setState(() {
                  _loadCoverLetter();
                });
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _toggleEditContent(String currentValue) {
    setState(() {
      _isEditingContent = !_isEditingContent;
      _contentController.text = currentValue;
    });
  }

  void _updateContent() async {
    await DatabaseHelper().updateCoverLetterField(widget.id, 'content', _contentController.text);
    setState(() {
      _isEditingContent = false;
      _loadCoverLetter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cover Letter Details'),
      ),
      body: FutureBuilder(
        future: _coverLetter,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final coverLetter = snapshot.data as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text('Title: ${coverLetter['title']}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, size: 20),
                          onPressed: () => _editField('title', coverLetter['title']),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text('Personal Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ..._buildEditableField('Name', coverLetter['yourName']),
                    ..._buildEditableField('Address', coverLetter['yourAddress']),
                    ..._buildEditableField('City', coverLetter['yourCity']),
                    ..._buildEditableField('Email', coverLetter['yourEmail']),
                    ..._buildEditableField('Phone', coverLetter['yourPhone']),
                    const SizedBox(height: 20),
                    const Text('Company Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ..._buildEditableField("Employer's Name", coverLetter['employerName']),
                    ..._buildEditableField("Employer's Title", coverLetter['employerTitle']),
                    ..._buildEditableField("Company's Name", coverLetter['companyName']),
                    ..._buildEditableField("Company's Address", coverLetter['companyAddress']),
                    ..._buildEditableField('City', coverLetter['companyCity']),
                    const SizedBox(height: 20),
                    const Text('Cover Letter Content', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    _isEditingContent
                        ? Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _contentController,
                            maxLines: 10,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.done, size: 20),
                          onPressed: _updateContent,
                        ),
                      ],
                    )
                        : Row(
                      children: [
                        Expanded(
                          child: Text(coverLetter['content']),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, size: 20),
                          onPressed: () => _toggleEditContent(coverLetter['content']),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: 'Delete',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create),
            label: 'Create Template',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            _confirmDelete();
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CoverTemplates(coverLetterId: widget.id),
              ),
            );
          }
        },
      ),
    );
  }

  List<Widget> _buildEditableField(String fieldName, String fieldValue) {
    return [
      Row(
        children: [
          Expanded(
            child: Text('$fieldName: $fieldValue'),
          ),
          IconButton(
            icon: const Icon(Icons.edit, size: 20),
            onPressed: () => _editField(fieldName.toLowerCase(), fieldValue),
          ),
        ],
      ),
      const SizedBox(height: 10),
    ];
  }
}
