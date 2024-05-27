import 'package:flutter/material.dart';
import 'package:final_2024_1/pages/license_info/license_info_first_page.dart';
import 'career_info_edit_page.dart';
import 'package:final_2024_1/pages/career_info/career_info_first_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CareerInfoResultPage extends StatefulWidget {
  final int userId;

  const CareerInfoResultPage({Key? key, required this.userId}) : super(key: key);

  @override
  _CareerInfoResultPageState createState() => _CareerInfoResultPageState();
}

class _CareerInfoResultPageState extends State<CareerInfoResultPage> {
  late Future<List<Map<String, dynamic>>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = _fetchData();
  }

  Future<List<Map<String, dynamic>>> _fetchData() async {
    var response = await http.get(
      Uri.parse('http://10.0.2.2:50369/career-info/${widget.userId}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('데이터 페치 실패');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("경력 정보 결과")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
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
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var career = data[index];
                          return Column(
                            children: [
                              Card(
                                child: ListTile(
                                  title: Text("근무처: ${career['place']}"),
                                  subtitle: Text("근무 기간: ${career['period']}\n업무 내용: ${career['task']}"),
                                  trailing: IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () async {
                                      bool? result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CareerInfoEditPage(
                                            userId: widget.userId,
                                            careerInfos: data,
                                            careerIndex: index,
                                          ),
                                        ),
                                      );
                                      if (result == true) {
                                        setState(() {
                                          _dataFuture = _fetchData();
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 10), // 항목 간의 간격 추가
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CareerInfoFirstPage(userId: widget.userId)),
                        );
                      },
                      child: const Text('경력 정보 추가하기'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LicenseInfoFirstPage(userId: widget.userId)),
                        );
                      },
                      child: const Text('자격증/면허 정보 입력하기'),
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