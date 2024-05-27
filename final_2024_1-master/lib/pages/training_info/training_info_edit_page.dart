import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TrainingInfoEditPage extends StatefulWidget {
  final int userId;
  final List<Map<String, dynamic>> trainingInfos;
  final int trainingIndex;

  const TrainingInfoEditPage({super.key, required this.userId, required this.trainingInfos, required this.trainingIndex});

  @override
  _TrainingInfoEditPageState createState() => _TrainingInfoEditPageState();
}

class _TrainingInfoEditPageState extends State<TrainingInfoEditPage> {
  late TextEditingController _trainingNameController;
  late TextEditingController _dateController;
  late TextEditingController _agencyController;

  @override
  void initState() {
    super.initState();
    var trainingInfo = widget.trainingInfos[widget.trainingIndex];
    _trainingNameController = TextEditingController(text: trainingInfo['trainingName']);
    _dateController = TextEditingController(text: trainingInfo['date']);
    _agencyController = TextEditingController(text: trainingInfo['agency']);
  }

  Future<void> _updateData() async {
    widget.trainingInfos[widget.trainingIndex] = {
      'userId': widget.userId,
      'trainingName': _trainingNameController.text,
      'date': _dateController.text,
      'agency': _agencyController.text,
    };

    try {
      var response = await http.post(
        Uri.parse('http://10.0.2.2:50369/training-info/update/${widget.userId}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(widget.trainingInfos),
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
        title: const Text("훈련/교육 정보 수정"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _trainingNameController,
                decoration: const InputDecoration(
                  labelText: '훈련/교육명',
                ),
              ),
              SizedBox(height: 20), // 각 문항 사이에 간격 추가
              TextField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: '훈련/교육 기간',
                ),
              ),
              SizedBox(height: 20), // 각 문항 사이에 간격 추가
              TextField(
                controller: _agencyController,
                decoration: const InputDecoration(
                  labelText: '훈련/교육 기관',
                ),
              ),
              SizedBox(height: 20), // 각 문항 사이에 간격 추가
              ElevatedButton(
                onPressed: _updateData,
                child: const Text('수정 완료'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
