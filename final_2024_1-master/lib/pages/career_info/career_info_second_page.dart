import 'package:flutter/material.dart';
import 'career_info_last_page.dart';

class CareerInfoSecondPage extends StatefulWidget {
  final int userId;
  final String place;
  const CareerInfoSecondPage({super.key, required this.userId, required this.place});

  @override
  _CareerInfoSecondPageState createState() => _CareerInfoSecondPageState();
}

class _CareerInfoSecondPageState extends State<CareerInfoSecondPage> {
  final TextEditingController _periodController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("근무 기간 입력"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _periodController,
            decoration: const InputDecoration(
              labelText: '일하신 기간이 어떻게 되나요!',
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
                      CareerInfoLastPage(userId: widget.userId, place: widget.place, period: _periodController.text)));
        },
        tooltip: '다음',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
