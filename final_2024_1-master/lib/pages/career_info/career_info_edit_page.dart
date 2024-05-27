import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CareerInfoEditPage extends StatefulWidget {
  final int userId;
  final List<Map<String, dynamic>> careerInfos;
  final int careerIndex;

  const CareerInfoEditPage({super.key, required this.userId, required this.careerInfos, required this.careerIndex});

  @override
  _CareerInfoEditPageState createState() => _CareerInfoEditPageState();
}

class _CareerInfoEditPageState extends State<CareerInfoEditPage> {
  late TextEditingController _placeController;
  late TextEditingController _periodController;
  late TextEditingController _taskController;

  @override
  void initState() {
    super.initState();
    var careerInfo = widget.careerInfos[widget.careerIndex];
    _placeController = TextEditingController(text: careerInfo['place']);
    _periodController = TextEditingController(text: careerInfo['period']);
    _taskController = TextEditingController(text: careerInfo['task']);
  }

  Future<void> _updateData() async {
    widget.careerInfos[widget.careerIndex] = {
      'userId': widget.userId,
      'place': _placeController.text,
      'period': _periodController.text,
      'task': _taskController.text,
    };

    try {
      var response = await http.post(
        Uri.parse('http://10.0.2.2:50369/career-info/update/${widget.userId}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(widget.careerInfos),
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
        title: const Text("경력 정보 수정"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _placeController,
                decoration: const InputDecoration(
                  labelText: '근무처',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _periodController,
                decoration: const InputDecoration(
                  labelText: '근무 기간',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _taskController,
                decoration: const InputDecoration(
                  labelText: '업무 내용',
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
    );
  }
}
