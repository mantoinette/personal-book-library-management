
import 'package:flutter/material.dart';

class AddEditBookScreen extends StatefulWidget {
  final String? title;
  final String? author;
  final Function(String title, String author)? onSave;

  AddEditBookScreen({this.title, this.author, this.onSave});

  @override
  _AddEditBookScreenState createState() => _AddEditBookScreenState();
}

class _AddEditBookScreenState extends State<AddEditBookScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.title != null) {
      titleController.text = widget.title!;
    }
    if (widget.author != null) {
      authorController.text = widget.author!;
    }
  }

  void _saveBook() {
    if (titleController.text.isNotEmpty && authorController.text.isNotEmpty) {
      if (widget.onSave != null) {
        widget.onSave!(titleController.text, authorController.text);
        Navigator.pop(context); // Go back after saving
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in both fields.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title != null ? 'Edit Book' : 'Add Book')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Book Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: authorController,
              decoration: InputDecoration(
                labelText: 'Author',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveBook,
              child: Text('Save Book'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
