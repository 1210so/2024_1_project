import 'package:flutter/material.dart';
import 'package:final_2024_1/pages/training_info/training_info_first_page.dart';
import 'package:final_2024_1/pages/resume/resume_result_page.dart';
import 'package:final_2024_1/pages/training_info/training_info_edit_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TrainingInfoResultPage extends StatefulWidget {
  final int userId;

  const TrainingInfoResultPage({Key? key, required this.userId}) : super(key: key);

  @override
  _TrainingInfoResultPageState createState() => _TrainingInfoResultPageState();
}

class _TrainingInfoResultPageState extends State<TrainingInfoResultPage> {
  late Future<List<Map<String, dynamic>>> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = _fetchData();
  }

  Future<List<Map<String, dynamic>>> _fetchData() async {
    var response = await http.get(
      Uri.parse('http://10.0.2.2:50369/training-info/${widget.userId}'),
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
      appBar: AppBar(title: const Text("훈련/교육 정보 결과")),
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
                          var training = data[index];
                          return Column(
                            children: [
                              Card(
                                child: ListTile(
                                  title: Text("훈련/교육명: ${training['trainingName']}"),
                                  subtitle: Text("훈련/교육 일자: ${training['date']}\n훈련/교육 기관: ${training['agency']}"),
                                  trailing: IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () async {
                                      bool? result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TrainingInfoEditPage(
                                            userId: widget.userId,
                                            trainingInfos: data,
                                            trainingIndex: index,
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
                          MaterialPageRoute(builder: (context) => TrainingInfoFirstPage(userId: widget.userId)),
                        );
                      },
                      child: const Text('훈련/교육 정보 추가하기'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ResumeResultPage(userId: widget.userId)),
                        );
                      },
                      child: const Text('최종 이력서 정보 확인하기'),
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

