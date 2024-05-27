import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// 자격증 목록 드롭다운 선택
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('자격증 목록'),
        ),
        body: Center(
          child: DropdownMenu(),
        ),
      ),
    );
  }
}

class DropdownMenu extends StatefulWidget {
  @override
  _DropdownMenuState createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  List<String> _items = [];
  String? _selectedItem;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('https://api.odcloud.kr/api/15082998/v1/uddi:950a6280-b56a-417e-b97c-de941adbfc9f?page=1&perPage=600&serviceKey=w%2BpW2nlhBLeFBdWYtKoiZ8sA2lNwr3LBToOZWQsIE7ota7%2BXIGvs52ovvgSdhgIoMysR%2FwwR9hSxEexkAX6fQA%3D%3D'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        final List<dynamic> dataList = jsonData['data'];
        setState(() {
          _items = dataList.map((item) => item['종목명'].toString()).toList();
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedItem,
      items: _items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedItem = newValue;
        });
      },
    );
  }
}
