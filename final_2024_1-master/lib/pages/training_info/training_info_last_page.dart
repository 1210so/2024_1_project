import 'package:flutter/material.dart';
import 'training_info_result_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TrainingInfoLastPage extends StatefulWidget {
  final int userId;
  final String trainingName;
  final String date;
  const TrainingInfoLastPage({super.key, required this.userId, required this.trainingName, required this.date});

  @override
  _TrainingInfoLastPageState createState() => _TrainingInfoLastPageState();
}

class _TrainingInfoLastPageState extends State<TrainingInfoLastPage> {
  final TextEditingController _agencyController = TextEditingController();

  Future<void> _sendData() async {
    try {
      var response = await http.post(
        Uri.parse('http://10.0.2.2:50369/training-info/save/${widget.userId}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userId': widget.userId.toString(),
          'trainingName': widget.trainingName,
          'date': widget.date,
          'agency': _agencyController.text,
        }),
      );

      if (response.statusCode == 201) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TrainingInfoResultPage(userId: widget.userId)),
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
        title: const Text("훈련/교육기관 입력"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _agencyController,
            decoration: const InputDecoration(
              labelText: '해당 훈련/교육을 주관한 기관의 이름은 무엇인가요?',
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendData,
        tooltip: '완료',
        child: const Icon(Icons.done),
      ),
    );
  }
}
