import 'package:flutter/material.dart';

class AddEditBookScreen extends StatefulWidget {
  final String? title;
  final String? author;
  final double? rating;
  final bool? isRead;
  final Function(String title, String author, double rating, bool isRead)? onSave;

  AddEditBookScreen({this.title, this.author, this.rating, this.isRead, this.onSave});

  @override
  _AddEditBookScreenState createState() => _AddEditBookScreenState();
}

class _AddEditBookScreenState extends State<AddEditBookScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  double rating = 0.0;
  bool isRead = false;

  @override
  void initState() {
    super.initState();
    if (widget.title != null) {
      titleController.text = widget.title!;
    }
    if (widget.author != null) {
      authorController.text = widget.author!;
    }
    if (widget.rating != null) {
      rating = widget.rating!;
    }
    if (widget.isRead != null) {
      isRead = widget.isRead!;
    }
  }

  void _saveBook() {
    if (titleController.text.isNotEmpty && authorController.text.isNotEmpty) {
      if (widget.onSave != null) {
        widget.onSave!(titleController.text, authorController.text, rating, isRead);
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
            SizedBox(height: 10),
            Text('Rate this book:'),
            Slider(
              value: rating,
              min: 0,
              max: 5,
              divisions: 5,
              label: rating.toString(),
              onChanged: (double value) {
                setState(() {
                  rating = value;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Read:'),
                Checkbox(
                  value: isRead,
                  onChanged: (bool? value) {
                    setState(() {
                      isRead = value!;
                    });
                  },
                ),
              ],
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
