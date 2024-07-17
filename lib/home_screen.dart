import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_edit_book_screen.dart';
import 'models/book.dart';
import 'Sorting_provider.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Book> books = [];

  void _addBook(String title, String author) {
    if (title.isNotEmpty && author.isNotEmpty) {
      setState(() {
        books.add(Book(title: title, author: author));
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Book added successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both title and author.')),
      );
    }
  }

  void _editBook(int index, String newTitle, String newAuthor) {
    if (newTitle.isNotEmpty && newAuthor.isNotEmpty) {
      setState(() {
        books[index] = Book(title: newTitle, author: newAuthor);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Book updated successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both title and author.')),
      );
    }
  }

  void _deleteBook(int index) {
    setState(() {
      books.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Book deleted successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sortingProvider = Provider.of<SortingProvider>(context);

    List<Book> sortedBooks = List.from(books);
    sortedBooks.sort((a, b) {
      switch (sortingProvider.sortingCriteria) {
        case 'author':
          return a.author.compareTo(b.author);
        case 'rating':
        // Implement sorting by rating if you have a rating property
          return 0; // Placeholder
        case 'title':
        default:
          return a.title.compareTo(b.title);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('My Book Library'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: sortedBooks.isEmpty
          ? Center(child: Text('No books added yet.'))
          : SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text('Book Title')),
              DataColumn(label: Text('Author')),
              DataColumn(label: Text('Actions')),
            ],
            rows: sortedBooks.asMap().entries.map((entry) {
              int index = entry.key;
              Book book = entry.value;
              return DataRow(cells: [
                DataCell(Text(book.title)),
                DataCell(Text(book.author)),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEditBookScreen(
                                title: book.title,
                                author: book.author,
                                onSave: (newTitle, newAuthor) {
                                  _editBook(index, newTitle, newAuthor);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _deleteBook(index);
                        },
                      ),
                    ],
                  ),
                ),
              ]);
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditBookScreen(
                onSave: (title, author) {
                  _addBook(title, author);
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
