import 'package:flutter/material.dart';

class ApplicationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("지원 페이지"),
      ),
      body: Center(
        child: Text("여기는 일 지원 페이지입니다."),
      ),
    );
  }
}
