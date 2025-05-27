import 'package:flutter/material.dart';

class CategoryDetailsPage extends StatelessWidget {
  final String category;

  const CategoryDetailsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: Center(
        child: Text(
          'Details for $category',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
