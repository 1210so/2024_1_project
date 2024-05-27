import 'package:flutter/material.dart';
import 'package:final_2024_1/pages/academic_info/academic_info_first_page.dart';
import 'package:final_2024_1/pages/personal_info/personal_info_edit_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PersonalInfoResultPage extends StatefulWidget {
  final int userId;

  const PersonalInfoResultPage({Key? key, required this.userId}) : super(key: key);

  @override
  _PersonalInfoResultPageState createState() => _PersonalInfoResultPageState();
}

class _PersonalInfoResultPageState extends State<PersonalInfoResultPage> {
  late Future<Map<String, dynamic>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = _fetchData();
  }

  Future<Map<String, dynamic>> _fetchData() async {
    var response = await http.get(
      Uri.parse('http://10.0.2.2:50369/personal-info/${widget.userId}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('데이터 페치 실패');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("개인정보 입력 결과")),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            var data = snapshot.data!;
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "이름: ${data['name']}\n생년월일: ${data['birth']}\n주민등록번호: ${data['ssn']}\n"
                          "전화번호: ${data['contact']}\n이메일주소: ${data['email']}\n주소: ${data['address']}",
                      style: TextStyle(fontSize: 16.0, color: Colors.black87),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        bool? result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PersonalInfoEditPage(
                              userId: widget.userId,
                              personalInfo: data,
                            ),
                          ),
                        );
                        if (result == true) {
                          setState(() {
                            _dataFuture = _fetchData();
                          });
                        }
                      },
                      child: const Text('개인정보 수정하기'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AcademicInfoFirstPage(userId: widget.userId),
                          ),
                        );
                      },
                      child: const Text('학력 정보 입력하기'),
                    ),
                  ],
                ),
              ),
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
