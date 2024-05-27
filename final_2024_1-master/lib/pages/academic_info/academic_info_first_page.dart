import 'package:flutter/material.dart';
import 'academic_info_second_page.dart';

class AcademicInfoFirstPage extends StatefulWidget {
  final int userId;
  const AcademicInfoFirstPage({super.key, required this.userId});

  @override
  _AcademicInfoFirstPageState createState() => _AcademicInfoFirstPageState();
}

class _AcademicInfoFirstPageState extends State<AcademicInfoFirstPage> {
  final TextEditingController _highestEduController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("최종 학력 입력"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _highestEduController,
            decoration: const InputDecoration(
              labelText: '마지막 학력을 입력해주세요!(ex> 대학교)',
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
                      AcademicInfoSecondPage(userId: widget.userId, highestEdu: _highestEduController.text)));
        },
        tooltip: '다음',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
