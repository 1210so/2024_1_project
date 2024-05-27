import 'package:flutter/material.dart';
import 'training_info_last_page.dart';

class TrainingInfoSecondPage extends StatefulWidget {
  final int userId;
  final String trainingName;
  const TrainingInfoSecondPage({super.key, required this.userId, required this.trainingName});

  @override
  _TrainingInfoSecondPageState createState() => _TrainingInfoSecondPageState();
}

class _TrainingInfoSecondPageState extends State<TrainingInfoSecondPage> {
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("훈련/교육기간 입력"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _dateController,
            decoration: const InputDecoration(
              labelText: '해당 훈련/교육은 언제 받았나요?',
            ),
            keyboardType: TextInputType.number,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton (
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TrainingInfoLastPage(userId: widget.userId, trainingName: widget.trainingName, date: _dateController.text)));
        },
        tooltip: '다음',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
