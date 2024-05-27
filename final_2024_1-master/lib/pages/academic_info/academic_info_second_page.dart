import 'package:flutter/material.dart';
import 'academic_info_third_page.dart';

class AcademicInfoSecondPage extends StatefulWidget {
  final int userId;
  final String highestEdu;
  const AcademicInfoSecondPage({super.key, required this.userId, required this.highestEdu});

  @override
  _AcademicInfoSecondPageState createState() => _AcademicInfoSecondPageState();
}

class _AcademicInfoSecondPageState extends State<AcademicInfoSecondPage> {
  final TextEditingController _schoolNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("학교 이름 입력"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _schoolNameController,
            decoration: const InputDecoration(
              labelText: '학교 이름을 입력해주세요!',
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
                      AcademicInfoThirdPage(userId: widget.userId, highestEdu: widget.highestEdu, schoolName: _schoolNameController.text)));
        },
        tooltip: '다음',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
