import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';

// 자격증 목록 검색 자동완성 기능 - 선택 값 저장은 아직 NOT 구현
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dropdown Menu with Search'),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          TypeAheadFormField<String>(
            textFieldConfiguration: TextFieldConfiguration(
              decoration: InputDecoration(
                labelText: 'Search for item',
                border: OutlineInputBorder(),
              ),
            ),
            suggestionsCallback: (String pattern) {
              return _items.where((item) => item.toLowerCase().contains(pattern.toLowerCase()));
            },
            itemBuilder: (BuildContext context, String suggestion) {
              return ListTile(
                title: Text(suggestion),
              );
            },
            onSuggestionSelected: (String suggestion) {
              setState(() {
                _selectedItem = suggestion;
              });
            },
          ),
          if (_selectedItem != null)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text('Selected Item: $_selectedItem'),
            ),
        ],
      ),
    );
  }
}
