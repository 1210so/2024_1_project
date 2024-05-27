import 'package:flutter/material.dart';
import 'career_info_result_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CareerInfoLastPage extends StatefulWidget {
  final int userId;
  final String place;
  final String period;
  const CareerInfoLastPage({super.key, required this.userId, required this.place, required this.period});

  @override
  _CareerInfoLastPageState createState() => _CareerInfoLastPageState();
}

class _CareerInfoLastPageState extends State<CareerInfoLastPage> {
  final TextEditingController _taskController = TextEditingController();

  Future<void> _sendData() async {
    try {
      var response = await http.post(
        Uri.parse('http://10.0.2.2:50369/career-info/save/${widget.userId}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userId': widget.userId.toString(),
          'place': widget.place,
          'period': widget.period,
          'task': _taskController.text,
        }),
      );

      if (response.statusCode == 201) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CareerInfoResultPage(userId: widget.userId)),
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
        title: const Text("업무 내용 입력"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _taskController,
            decoration: const InputDecoration(
              labelText: '어떤 종류의 업무를 맡으셨나요?',
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
