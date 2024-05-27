import 'package:flutter/material.dart';
import 'academic_info_result_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AcademicInfoLastPage extends StatefulWidget {
  final int userId;
  final String highestEdu;
  final String schoolName;
  final String major;
  const AcademicInfoLastPage({super.key, required this.userId, required this.highestEdu, required this.schoolName, required this.major});

  @override
  _AcademicInfoLastPageState createState() => _AcademicInfoLastPageState();
}

class _AcademicInfoLastPageState extends State<AcademicInfoLastPage> {
  final TextEditingController _detailedMajorController = TextEditingController();

  Future<void> _sendData() async {
    try {
      var response = await http.post(
          Uri.parse('http://10.0.2.2:50369/academic-info/save/${widget.userId}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String> {
            'userId': widget.userId.toString(),
            'highestEdu' : widget.highestEdu,
            'schoolName' : widget.schoolName,
            'major' : widget.major,
            'detailedMajor' : _detailedMajorController.text,
          })
      );

      if (response.statusCode == 201) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AcademicInfoResultPage(userId: widget.userId)),
        );
      } else {
        print('데이터 저장 실패');
      }
    } catch (e) {
      print('데이터 전송 실패 : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("세부 전공 입력"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _detailedMajorController,
            decoration: const InputDecoration(
              labelText: '세부 전공을 입력해주세요!',
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton (
        onPressed: _sendData,
        tooltip: '완료',
        child: const Icon(Icons.done),
      ),
    );
  }
}
