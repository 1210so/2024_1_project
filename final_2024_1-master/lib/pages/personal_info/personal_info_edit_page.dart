import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PersonalInfoEditPage extends StatefulWidget {
  final int userId;
  final Map<String, dynamic> personalInfo;

  const PersonalInfoEditPage({super.key, required this.userId, required this.personalInfo});

  @override
  _PersonalInfoEditPageState createState() => _PersonalInfoEditPageState();
}

class _PersonalInfoEditPageState extends State<PersonalInfoEditPage> {
  late TextEditingController _nameController;
  late TextEditingController _birthController;
  late TextEditingController _ssnController;
  late TextEditingController _contactController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.personalInfo['name']);
    _birthController = TextEditingController(text: widget.personalInfo['birth']);
    _ssnController = TextEditingController(text: widget.personalInfo['ssn']);
    _contactController = TextEditingController(text: widget.personalInfo['contact']);
    _emailController = TextEditingController(text: widget.personalInfo['email']);
    _addressController = TextEditingController(text: widget.personalInfo['address']);
  }

  Future<void> _updateData() async {
    try {
      var response = await http.post(
        Uri.parse('http://10.0.2.2:50369/personal-info/update/${widget.userId}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'userId': widget.userId.toString(),
          'name': _nameController.text,
          'birth': _birthController.text,
          'ssn': _ssnController.text,
          'contact': _contactController.text,
          'email': _emailController.text,
          'address': _addressController.text,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context, true);
      } else {
        print('데이터 업데이트 실패');
      }
    } catch (e) {
      print('데이터 전송 실패 : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("개인정보 수정"),
      ),
      body: SingleChildScrollView( // 스크롤 가능하도록 수정
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '이름',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _birthController,
              decoration: const InputDecoration(
                labelText: '생년월일',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _ssnController,
              decoration: const InputDecoration(
                labelText: '주민등록번호',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _contactController,
              decoration: const InputDecoration(
                labelText: '전화번호',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: '이메일주소',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: '주소',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateData,
              child: const Text('수정 완료'),
            ),
          ],
        ),
      ),
    );
  }
}
