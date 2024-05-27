import 'package:flutter/material.dart';
import 'personal_info_result_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LastPage extends StatefulWidget {
  final String name;
  final String birth;
  final String ssn;
  final String contact;
  final String email;

  const LastPage(
      {Key? key, required this.name, required this.birth, required this.ssn, required this.contact, required this.email}) : super(key: key);

  @override
  _LastPageState createState() => _LastPageState();
}

class _LastPageState extends State<LastPage> {
  final TextEditingController _addressController = TextEditingController();

  Future<void> _sendData() async {
    try {
      var response = await http.post(
        Uri.parse('http://10.0.2.2:50369/personal-info/save'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': widget.name,
          'birth': widget.birth,
          'ssn': widget.ssn,
          'contact': widget.contact,
          'email': widget.email,
          'address': _addressController.text,
        }),
      );

      if (response.statusCode == 201) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PersonalInfoResultPage(userId: data['userId'])),
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
        title: const Text("주소 입력"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _addressController,
            decoration: const InputDecoration(
              labelText: '주소를 입력해주세요!',
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
