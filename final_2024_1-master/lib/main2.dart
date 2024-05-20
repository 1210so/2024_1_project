import 'package:final_2024_1/ApplicationPage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '사용자 정보 수집 앱',
      theme: ThemeData(
        primarySwatch: Colors.indigo, // 앱 전반에 사용될 기본 색상을 변경합니다.
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo, secondary: Colors.amber), // 보조 색상 추가
        useMaterial3: true, // Material Design 3 사용
        inputDecorationTheme: InputDecorationTheme(
          // TextField 디자인을 위한 테마
          border: OutlineInputBorder(
            // 테두리 스타일
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true, // 배경색 사용
          fillColor: Colors.indigo.shade50, // 배경색 지정
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          // FAB 디자인
          backgroundColor: Colors.indigo, // FAB 배경색
          foregroundColor: Colors.white, // FAB 아이콘 및 텍스트 색상
        ),
      ),
      home: const FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("이름 입력"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: '성함을 입력해주세요!',
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SecondPage(name: _nameController.text)));
        },
        tooltip: '다음',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  final String name;
  const SecondPage({super.key, required this.name});

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final TextEditingController _birthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("나이 입력"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _birthController,
            decoration: const InputDecoration(
              labelText: '생년월일을 입력해주세요!(ex> 19600501)',
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
                  builder: (context) =>
                      ThirdPage(name: widget.name, birth: _birthController.text)));
        },
        tooltip: '다음',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}

class ThirdPage extends StatefulWidget {
  final String name;
  final String birth;
  const ThirdPage({super.key, required this.name, required this.birth});

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  final TextEditingController _ssnController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("주민등록번호 입력"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _ssnController,
            decoration: const InputDecoration(
              labelText: '주민등록번호를 입력해주세요!(ex> 6810201234567)',
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
                  builder: (context) =>
                      FourthPage(name: widget.name, birth: widget.birth, ssn: _ssnController.text, )));
        },
        tooltip: '다음',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}

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
                  builder: (context) =>
                      FifthPage(name: widget.name, birth: widget.birth, ssn: widget.ssn, contact: _contactController.text, )));
        },
        tooltip: '다음',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}

class FifthPage extends StatefulWidget {
  final String name;
  final String birth;
  final String ssn;
  final String contact;
  const FifthPage({super.key, required this.name, required this.birth, required this.ssn, required this.contact});

  @override
  _FifthPageState createState() => _FifthPageState();
}

class _FifthPageState extends State<FifthPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("이메일 주소 입력"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: '이메일 주소를 입력해주세요!(ex> test@naver.com)',
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
                  builder: (context) =>
                      LastPage(name: widget.name, birth: widget.birth, ssn: widget.ssn, contact: widget.contact, email: _emailController.text)));
        },
        tooltip: '다음',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}

class LastPage extends StatefulWidget {
  final String name;
  final String birth;
  final String ssn;
  final String contact;
  final String email;

  const LastPage(
      {Key? key, required this.name, required this.birth, required this.ssn, required this.contact, required this.email}) : super(key: key);

  @override
  _LastPageState createState() => _LastPageState();
}

class _LastPageState extends State<LastPage> {
  final TextEditingController _addressController = TextEditingController();

  Future<void> _sendData() async {
    try {
      var response = await http.post(
        Uri.parse('http://10.0.2.2:50369/personal-info/save'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': widget.name,
          'birth': widget.birth,
          'ssn': widget.ssn,
          'contact': widget.contact,
          'email': widget.email,
          'address': _addressController.text,
        }),
      );

      if (response.statusCode == 201) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResultPage(userId: data['userId'])),
        );
      } else {
        print('데이터 저장 실패');
      }
    } catch (e) {
      print('데이터 전송 실패 : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("주소 입력"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _addressController,
            decoration: const InputDecoration(
              labelText: '주소를 입력해주세요!',
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendData,
        tooltip: '완료',
        child: const Icon(Icons.done),
      ),
    );
  }
}


class ResultPage extends StatelessWidget {
  final int userId;

  const ResultPage({Key? key, required this.userId}) : super(key: key);

  Future<Map<String, dynamic>> _fetchData() async {
    var response = await http.get(
      Uri.parse('http://10.0.2.2:50369/personal-info/$userId'),
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
        future: _fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            var data = snapshot.data!;
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "이름: ${data['name']}\n생년월일: ${data['birth']}\n주민등록번호: ${data['ssn']}\n"
                      "전화번호: ${data['contact']}\n이메일주소: ${data['email']}\n주소: ${data['address']}",
                  style: TextStyle(fontSize: 16.0, color: Colors.black87),
                ),
              )
            );
          }
          return const CircularProgressIndicator();
        },
      )
    );
  }
}
