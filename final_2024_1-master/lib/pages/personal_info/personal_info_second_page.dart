import 'package:flutter/material.dart';
import 'personal_info_third_page.dart';

class SecondPage extends StatefulWidget {
  final String name;
  const SecondPage({super.key, required this.name});

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final TextEditingController _birthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("나이 입력"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _birthController,
            decoration: const InputDecoration(
              labelText: '생년월일을 입력해주세요!(ex> 19600501)',
            ),
            keyboardType: TextInputType.number,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ThirdPage(name: widget.name, birth: _birthController.text)),
          );
        },
        tooltip: '다음',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
