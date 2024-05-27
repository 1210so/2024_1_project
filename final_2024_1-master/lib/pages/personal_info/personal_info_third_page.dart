import 'package:flutter/material.dart';
import 'personal_info_fourth_page.dart';

class ThirdPage extends StatefulWidget {
  final String name;
  final String birth;
  const ThirdPage({super.key, required this.name, required this.birth});

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  final TextEditingController _ssnController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("주민등록번호 입력"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _ssnController,
            decoration: const InputDecoration(
              labelText: '주민등록번호를 입력해주세요!(ex> 6810201234567)',
            ),
            keyboardType: TextInputType.number,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FourthPage(name: widget.name, birth: widget.birth, ssn: _ssnController.text)));
        },
        tooltip: '다음',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
