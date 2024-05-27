import 'package:flutter/material.dart';
import 'personal_info_last_page.dart';

class FifthPage extends StatefulWidget {
  final String name;
  final String birth;
  final String ssn;
  final String contact;
  const FifthPage({super.key, required this.name, required this.birth, required this.ssn, required this.contact});

  @override
  _FifthPageState createState() => _FifthPageState();
}

class _FifthPageState extends State<FifthPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("이메일 주소 입력"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: '이메일 주소를 입력해주세요!(ex> test@naver.com)',
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LastPage(name: widget.name, birth: widget.birth, ssn: widget.ssn, contact: widget.contact, email: _emailController.text)));
        },
        tooltip: '다음',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
