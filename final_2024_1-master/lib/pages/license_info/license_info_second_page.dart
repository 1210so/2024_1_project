import 'package:flutter/material.dart';
import 'license_info_last_page.dart';

class LicenseInfoSecondPage extends StatefulWidget {
  final int userId;
  final String licenseName;
  const LicenseInfoSecondPage({super.key, required this.userId, required this.licenseName});

  @override
  _LicenseInfoSecondPageState createState() => _LicenseInfoSecondPageState();
}

class _LicenseInfoSecondPageState extends State<LicenseInfoSecondPage> {
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("취득일 입력"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _dateController,
            decoration: const InputDecoration(
              labelText: '취득하신 날짜를 입력해주세요!',
            ),
            keyboardType: TextInputType.number,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton (
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      LicenseInfoLastPage(userId: widget.userId, licenseName: widget.licenseName, date: _dateController.text)));
        },
        tooltip: '다음',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
