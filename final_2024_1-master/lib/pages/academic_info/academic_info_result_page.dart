import 'package:flutter/material.dart';
import 'package:final_2024_1/pages/career_info/career_info_first_page.dart';
import 'package:final_2024_1/pages/academic_info/academic_info_edit_page.dart'; // 추가
import 'dart:convert';
import 'package:http/http.dart' as http;

class AcademicInfoResultPage extends StatefulWidget {
  final int userId;

  const AcademicInfoResultPage({Key? key, required this.userId}) : super(key: key);

  @override
  _AcademicInfoResultPageState createState() => _AcademicInfoResultPageState();
}

class _AcademicInfoResultPageState extends State<AcademicInfoResultPage> {
  late Future<Map<String, dynamic>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = _fetchData();
  }

  Future<Map<String, dynamic>> _fetchData() async {
    var response = await http.get(
      Uri.parse('http://10.0.2.2:50369/academic-info/${widget.userId}'),
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
      appBar: AppBar(title: const Text("학력 정보 결과")),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            var data = snapshot.data!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "최종 학력: ${data['highestEdu']}\n학교 이름: ${data['schoolName']}"
                        "\n전공 계열: ${data['major']}\n세부 전공: ${data['detailedMajor']}",
                    style: TextStyle(fontSize: 16.0, color: Colors.black87),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      bool? result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AcademicInfoEditPage(userId: widget.userId, academicInfo: data)),
                      );
                      if (result == true) {
                        setState(() {
                          _dataFuture = _fetchData();
                        });
                      }
                    },
                    child: const Text('학력 정보 수정하기'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CareerInfoFirstPage(userId: widget.userId)),
                      );
                    },
                    child: const Text('경력 정보 입력하기'),
                  ),
                ],
              ),
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
