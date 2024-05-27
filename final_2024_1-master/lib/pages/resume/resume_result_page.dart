import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ResumeResultPage extends StatelessWidget {
  final int userId;

  const ResumeResultPage({Key? key, required this.userId}) : super(key: key);

  Future<Map<String, dynamic>> _fetchResumeData() async {
    var response = await http.get(
      Uri.parse('http://10.0.2.2:50369/resume/$userId'),
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
      appBar: AppBar(title: const Text("이력서 결과")),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchResumeData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            var data = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("개인 정보"),
                  _buildBox(_buildPersonalInfo(data['PersonalInfo'])),
                  SizedBox(height: 20),
                  _buildSectionTitle("학력 정보"),
                  _buildBox(_buildAcademicInfo(data['AcademicInfo'])),
                  SizedBox(height: 20),
                  _buildSectionTitle("경력 정보"),
                  ..._buildCareerInfos(data['CareerInfos']),
                  SizedBox(height: 20),
                  _buildSectionTitle("자격/면허 정보"),
                  ..._buildLicenseInfos(data['LicenseInfos']),
                  SizedBox(height: 20),
                  _buildSectionTitle("훈련 정보"),
                  ..._buildTrainingInfos(data['TrainingInfos']),
                ],
              ),
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildBox(Widget child) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }

  Widget _buildPersonalInfo(Map<String, dynamic>? personalInfo) {
    if (personalInfo == null) return Text("개인 정보 없음");
    return ListTile(
      title: Text("개인 정보"),
      subtitle: Text(
        "이름: ${personalInfo['name']}\n"
            "생년월일: ${personalInfo['birth']}\n"
            "주민등록번호: ${personalInfo['ssn']}\n"
            "전화번호: ${personalInfo['contact']}\n"
            "이메일주소: ${personalInfo['email']}\n"
            "주소: ${personalInfo['address']}",
        style: TextStyle(fontSize: 16.0, color: Colors.black87),
      ),
    );
  }

  Widget _buildAcademicInfo(Map<String, dynamic>? academicInfo) {
    if (academicInfo == null) return Text("학력 정보 없음");
    return ListTile(
      title: Text("학력 정보"),
      subtitle: Text(
        "최종 학력: ${academicInfo['highestEdu']}\n"
            "학교 이름: ${academicInfo['schoolName']}\n"
            "전공 계열: ${academicInfo['major']}\n"
            "세부 전공: ${academicInfo['detailedMajor']}",
        style: TextStyle(fontSize: 16.0, color: Colors.black87),
      ),
    );
  }

  List<Widget> _buildCareerInfos(List<dynamic>? careerInfos) {
    if (careerInfos == null || careerInfos.isEmpty) return [Text("경력 정보 없음")];
    return careerInfos.map((career) {
      return Card(
        child: ListTile(
          title: Text("근무처: ${career['place']}"),
          subtitle: Text("근무 기간: ${career['period']}\n업무 내용: ${career['task']}"),
        ),
      );
    }).toList();
  }

  List<Widget> _buildLicenseInfos(List<dynamic>? licenseInfos) {
    if (licenseInfos == null || licenseInfos.isEmpty) return [Text("자격/면허 정보 없음")];
    return licenseInfos.map((license) {
      return Card(
        child: ListTile(
          title: Text("자격증/면허: ${license['licenseName']}"),
          subtitle: Text("취득일: ${license['date']}\n시행 기관: ${license['agency']}"),
        ),
      );
    }).toList();
  }

  List<Widget> _buildTrainingInfos(List<dynamic>? trainingInfos) {
    if (trainingInfos == null || trainingInfos.isEmpty) return [Text("훈련/교육 정보 없음")];
    return trainingInfos.map((training) {
      return Card(
        child: ListTile(
          title: Text("훈련/교육명: ${training['trainingName']}"),
          subtitle: Text("훈련/교육 기간: ${training['date']}\n훈련/교육 기관: ${training['agency']}"),
        ),
      );
    }).toList();
  }
}
