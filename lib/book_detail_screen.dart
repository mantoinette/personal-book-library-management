
import 'package:flutter/material.dart';

class BookDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book Details')),
      body: Center(child: Text('Details of the Book')),
    );
  }
}