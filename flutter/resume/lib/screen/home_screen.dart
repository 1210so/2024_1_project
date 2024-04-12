import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _controller = TextEditingController();
  String _responseText = '';

  Future<void> _callLegacyPrompt(String input) async {
    var url = Uri.parse('http://localhost:8080/api/v1/chatGpt/prompt');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({'prompt': input});
    try {
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          _responseText = responseData['choices'][0]['text']; // 응답 결과
        });
      } else {
        setState(() {
          _responseText = 'Error: ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        _responseText = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('자기소개글'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'ChatGpt를 사용해보세요'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _callLegacyPrompt(_controller.text);
              },
              child: Text('입력'),
            ),
            SizedBox(height: 20),
            Text(
              '작성된 자기소개글:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(_responseText),
          ],
        ),
      ),
    );
  }
}
