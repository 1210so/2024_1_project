import 'package:flutter/material.dart';
import 'package:final_2024_1/pages/license_info/license_info_first_page.dart';
import 'license_info_edit_page.dart';
import 'package:final_2024_1/pages/training_info/training_info_first_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LicenseInfoResultPage extends StatefulWidget {
  final int userId;

  const LicenseInfoResultPage({Key? key, required this.userId}) : super(key: key);

  @override
  _LicenseInfoResultPageState createState() => _LicenseInfoResultPageState();
}

class _LicenseInfoResultPageState extends State<LicenseInfoResultPage> {
  late Future<List<Map<String, dynamic>>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = _fetchData();
  }

  Future<List<Map<String, dynamic>>> _fetchData() async {
    var response = await http.get(
      Uri.parse('http://10.0.2.2:50369/license-info/${widget.userId}'),
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
      appBar: AppBar(title: const Text("자격증/면허 정보 결과")),
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
                          var license = data[index];
                          return Column(
                            children: [
                              Card(
                                child: ListTile(
                                  title: Text("자격증/면허: ${license['licenseName']}"),
                                  subtitle: Text("취득일: ${license['date']}\n시행 기관: ${license['agency']}"),
                                  trailing: IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () async {
                                      bool? result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LicenseInfoEditPage(
                                            userId: widget.userId,
                                            licenseInfos: data,
                                            licenseIndex: index,
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
                          MaterialPageRoute(builder: (context) => LicenseInfoFirstPage(userId: widget.userId)),
                        );
                      },
                      child: const Text('자격증/면허 정보 추가하기'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TrainingInfoFirstPage(userId: widget.userId)),
                        );
                      },
                      child: const Text('훈련/교육 정보 입력하기'),
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