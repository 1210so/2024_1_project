import 'package:flutter/material.dart';
import 'training_info_second_page.dart';

class TrainingInfoFirstPage extends StatefulWidget {
  final int userId;
  const TrainingInfoFirstPage({super.key, required this.userId});

  @override
  _TrainingInfoFirstPageState createState() => _TrainingInfoFirstPageState();
}

class _TrainingInfoFirstPageState extends State<TrainingInfoFirstPage> {
  final TextEditingController _trainingNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("훈련/교육 입력"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _trainingNameController,
            decoration: const InputDecoration(
              labelText: '참여하신 훈련/교육의 명칭이 무엇인가요?',
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
                      TrainingInfoSecondPage(userId: widget.userId, trainingName: _trainingNameController.text)));
        },
        tooltip: '다음',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
