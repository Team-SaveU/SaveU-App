import 'package:flutter/material.dart';

import '../models/sub_category.dart';

class SafeInfosPage extends StatefulWidget {
  final SubCategory subCategory;
  const SafeInfosPage({Key? key, required this.subCategory}) : super(key: key);

  @override
  State<SafeInfosPage> createState() => _SafeInfosPageState();
}

class _SafeInfosPageState extends State<SafeInfosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("안전 정보 리스트"),
        centerTitle: true,
      ),
      body: Center(child: Text("빈 페이지 입니다.")),
    );
  }
}
