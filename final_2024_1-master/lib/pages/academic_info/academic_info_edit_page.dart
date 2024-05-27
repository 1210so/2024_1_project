import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AcademicInfoEditPage extends StatefulWidget {
  final int userId;
  final Map<String, dynamic> academicInfo;

  const AcademicInfoEditPage({super.key, required this.userId, required this.academicInfo});

  @override
  _AcademicInfoEditPageState createState() => _AcademicInfoEditPageState();
}

class _AcademicInfoEditPageState extends State<AcademicInfoEditPage> {
  late TextEditingController _highestEduController;
  late TextEditingController _schoolNameController;
  late TextEditingController _majorController;
  late TextEditingController _detailedMajorController;

  @override
  void initState() {
    super.initState();
    _highestEduController = TextEditingController(text: widget.academicInfo['highestEdu']);
    _schoolNameController = TextEditingController(text: widget.academicInfo['schoolName']);
    _majorController = TextEditingController(text: widget.academicInfo['major']);
    _detailedMajorController = TextEditingController(text: widget.academicInfo['detailedMajor']);
  }

  Future<void> _updateData() async {
    try {
      var response = await http.post(
        Uri.parse('http://10.0.2.2:50369/academic-info/update/${widget.userId}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'userId': widget.userId,
          'highestEdu': _highestEduController.text,
          'schoolName': _schoolNameController.text,
          'major': _majorController.text,
          'detailedMajor': _detailedMajorController.text,
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
        title: const Text("학력 정보 수정"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView( // 스크롤 가능하도록 수정
            child: Column(
              children: [
                TextField(
                  controller: _highestEduController,
                  decoration: const InputDecoration(
                    labelText: '최종 학력',
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _schoolNameController,
                  decoration: const InputDecoration(
                    labelText: '학교 이름',
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _majorController,
                  decoration: const InputDecoration(
                    labelText: '전공 계열',
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _detailedMajorController,
                  decoration: const InputDecoration(
                    labelText: '세부 전공',
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
        ),
      ),
    );
  }
}
