import 'package:flutter/material.dart';
import 'license_info_second_page.dart';

class LicenseInfoFirstPage extends StatefulWidget {
  final int userId;
  const LicenseInfoFirstPage({super.key, required this.userId});

  @override
  _LicenseInfoFirstPageState createState() => _LicenseInfoFirstPageState();
}

class _LicenseInfoFirstPageState extends State<LicenseInfoFirstPage> {
  final TextEditingController _licenseNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("자격증/면허 입력"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _licenseNameController,
            decoration: const InputDecoration(
              labelText: '가지고 계신 자격증이나 면허를 입력해주세요',
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton (
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      LicenseInfoSecondPage(userId: widget.userId, licenseName: _licenseNameController.text)));
        },
        tooltip: '다음',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
