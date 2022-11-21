import 'package:flutter/material.dart';
import 'sub_categories_page.dart';
import 'mainPage.dart';

class CategoryPage extends StatelessWidget {
  // const CategoryPage({required this.userEmail, super.key});
  // final String userEmail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
