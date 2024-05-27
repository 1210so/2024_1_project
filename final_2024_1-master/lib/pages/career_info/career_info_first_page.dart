import 'package:flutter/material.dart';
import 'career_info_second_page.dart';

class CareerInfoFirstPage extends StatefulWidget {
  final int userId;
  const CareerInfoFirstPage({super.key, required this.userId});

  @override
  _CareerInfoFirstPageState createState() => _CareerInfoFirstPageState();
}

class _CareerInfoFirstPageState extends State<CareerInfoFirstPage> {
  final TextEditingController _placeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("근무처 입력"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _placeController,
            decoration: const InputDecoration(
              labelText: '어디서 일하셨나요?',
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton (
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CareerInfoSecondPage(userId: widget.userId, place: _placeController.text)));
        },
        tooltip: '다음',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
