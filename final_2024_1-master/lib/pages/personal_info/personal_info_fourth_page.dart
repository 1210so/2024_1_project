import 'package:flutter/material.dart';
import 'personal_info_fifth_page.dart';

class FourthPage extends StatefulWidget {
  final String name;
  final String birth;
  final String ssn;
  const FourthPage({super.key, required this.name, required this.birth, required this.ssn});

  @override
  _FourthPageState createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  final TextEditingController _contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("전화번호 입력"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _contactController,
            decoration: const InputDecoration(
              labelText: '전화번호를 입력해주세요!(ex> 01012345678)',
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
                  builder: (context) => FifthPage(name: widget.name, birth: widget.birth, ssn: widget.ssn, contact: _contactController.text)));
        },
        tooltip: '다음',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
