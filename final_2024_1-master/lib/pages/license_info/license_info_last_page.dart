import 'package:flutter/material.dart';
import 'license_info_result_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LicenseInfoLastPage extends StatefulWidget {
  final int userId;
  final String licenseName;
  final String date;
  const LicenseInfoLastPage({super.key, required this.userId, required this.licenseName, required this.date});

  @override
  _LicenseInfoLastPageState createState() => _LicenseInfoLastPageState();
}

class _LicenseInfoLastPageState extends State<LicenseInfoLastPage> {
  final TextEditingController _agencyController = TextEditingController();

  Future<void> _sendData() async {
    try {
      var response = await http.post(
        Uri.parse('http://10.0.2.2:50369/license-info/save/${widget.userId}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userId': widget.userId.toString(),
          'licenseName': widget.licenseName,
          'date': widget.date,
          'agency': _agencyController.text,
        }),
      );

      if (response.statusCode == 201) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LicenseInfoResultPage(userId: widget.userId)),
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
        title: const Text("시행기관 입력"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _agencyController,
            decoration: const InputDecoration(
              labelText: '자격증/면허의 시행기관을 입력해주세요',
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
