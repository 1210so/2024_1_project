import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LicenseInfoEditPage extends StatefulWidget {
  final int userId;
  final List<Map<String, dynamic>> licenseInfos;
  final int licenseIndex;

  const LicenseInfoEditPage({super.key, required this.userId, required this.licenseInfos, required this.licenseIndex});

  @override
  _LicenseInfoEditPageState createState() => _LicenseInfoEditPageState();
}

class _LicenseInfoEditPageState extends State<LicenseInfoEditPage> {
  late TextEditingController _licenseNameController;
  late TextEditingController _dateController;
  late TextEditingController _agencyController;

  @override
  void initState() {
    super.initState();
    var licenseInfo = widget.licenseInfos[widget.licenseIndex];
    _licenseNameController = TextEditingController(text: licenseInfo['licenseName']);
    _dateController = TextEditingController(text: licenseInfo['date']);
    _agencyController = TextEditingController(text: licenseInfo['agency']);
  }

  Future<void> _updateData() async {
    widget.licenseInfos[widget.licenseIndex] = {
      'userId': widget.userId,
      'licenseName': _licenseNameController.text,
      'date': _dateController.text,
      'agency': _agencyController.text,
    };

    try {
      var response = await http.post(
        Uri.parse('http://10.0.2.2:50369/license-info/update/${widget.userId}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(widget.licenseInfos),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context, true);
      } else {
        print('데이터 업데이트 실패');
      }
    } catch (e) {
      print('데이터 전송 실패 : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("자격증/면허 정보 수정"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _licenseNameController,
                decoration: const InputDecoration(
                  labelText: '자격증/면허',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: '취득일',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _agencyController,
                decoration: const InputDecoration(
                  labelText: '시행 기관',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateData,
                child: const Text('수정 완료'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
