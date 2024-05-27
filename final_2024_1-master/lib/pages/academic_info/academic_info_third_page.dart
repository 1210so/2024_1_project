import 'package:flutter/material.dart';
import 'academic_info_last_page.dart';

class AcademicInfoThirdPage extends StatefulWidget {
  final int userId;
  final String highestEdu;
  final String schoolName;
  const AcademicInfoThirdPage({super.key, required this.userId, required this.highestEdu, required this.schoolName});

  @override
  _AcademicInfoThirdPageState createState() => _AcademicInfoThirdPageState();
}

class _AcademicInfoThirdPageState extends State<AcademicInfoThirdPage> {
  final TextEditingController _majorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("전공 입력"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _majorController,
            decoration: const InputDecoration(
              labelText: '전공 분야를 입력해주세요!',
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton (
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AcademicInfoLastPage(userId: widget.userId, highestEdu: widget.highestEdu, schoolName: widget.schoolName, major: _majorController.text)));
        },
        tooltip: '다음',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
