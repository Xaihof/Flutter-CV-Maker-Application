import 'package:flutter/material.dart';
import 'cover_dp_helper.dart';
import 'cover_letter_screen.dart';
import 'cover_profile.dart';

class MyCoverLettersProfiles extends StatefulWidget {
  const MyCoverLettersProfiles({super.key});

  @override
  _MyCoverLettersProfilesState createState() => _MyCoverLettersProfilesState();
}

class _MyCoverLettersProfilesState extends State<MyCoverLettersProfiles> {
  late Future<List<Map<String, dynamic>>> _coverLetters;

  @override
  void initState() {
    super.initState();
    _loadCoverLetters();
  }

  Future<void> _loadCoverLetters() async {
    setState(() {
      _coverLetters = DatabaseHelper().getCoverLetters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cover Letters'),
      ),
      body: FutureBuilder(
        future: _coverLetters,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final coverLetters = snapshot.data as List<Map<String, dynamic>>;
            return ListView.builder(
              itemCount: coverLetters.length,
              itemBuilder: (context, index) {
                final coverLetter = coverLetters[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(coverLetter['title']),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CoverLetterProfile(id: coverLetter['id']),
                        ),
                      );
                      if (result == true) {
                        _loadCoverLetters();
                      }
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No cover letters found'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateCoverLetter(),
            ),
          );
          if (result == true) {
            _loadCoverLetters();
          }
        },
        tooltip: 'New Create',
        child: const Icon(Icons.add),
      ),
    );
  }
}
