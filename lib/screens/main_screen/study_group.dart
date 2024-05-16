import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lmsystem_app/models/study_group_model.dart';

class CreateStudyGoup extends StatefulWidget {
  const CreateStudyGoup({super.key});

  @override
  State<CreateStudyGoup> createState() => _CreateStudyGoupState();
}

class _CreateStudyGoupState extends State<CreateStudyGoup> {
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _membersController = TextEditingController();

  Future<void> createStudyGroup() async{
    const apiUrl = 'https://3ef37e6c65e7e0e1107cc66bb673f0d0.serveo.net/create_study_group/';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        StudyGroup(
          name: _groupNameController.text,
          members: _membersController.text.split(','),
        ).toJson()
      ),
    );
    if (response.statusCode == 201){
      print('Study group created successfully');
    }else {
      print('Failed to create study group: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Study Group'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _groupNameController,
              decoration: const InputDecoration(labelText: 'Group Name'),
            ),
            TextField(
              controller: _membersController,
              decoration: const InputDecoration(labelText: 'Members (comma-separated)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: createStudyGroup,
              child: const Text('Create Study Group'),
            ),
          ],
        ),
      ),
    );
  }
}