import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sorting_provider.dart';
import 'models/book.dart';
import 'add_edit_book_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<Book> books = [];
  List<Book> filteredBooks = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterBooks);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _addBook(String title, String author, double rating, bool isRead) {
    if (title.isNotEmpty && author.isNotEmpty) {
      setState(() {
        books.add(Book(title: title, author: author, rating: rating, isRead: isRead));
        _filterBooks(); // Update filteredBooks when a new book is added
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

  void _editBook(int index, String newTitle, String newAuthor, double newRating, bool newIsRead) {
    if (newTitle.isNotEmpty && newAuthor.isNotEmpty) {
      setState(() {
        books[index] = Book(title: newTitle, author: newAuthor, rating: newRating, isRead: newIsRead);
        _filterBooks(); // Update filteredBooks when a book is edited
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
      _filterBooks(); // Update filteredBooks when a book is deleted
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Book deleted successfully!')),
    );
  }

  void _filterBooks() {
    setState(() {
      filteredBooks = books
          .where((book) =>
      book.title.toLowerCase().contains(searchController.text.toLowerCase()) ||
          book.author.toLowerCase().contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final sortingCriteria = ref.watch(sortingProvider);

    // Ensure filteredBooks is sorted
    filteredBooks.sort((a, b) {
      switch (sortingCriteria) {
        case 'author':
          return a.author.compareTo(b.author);
        case 'rating':
          return b.rating.compareTo(a.rating);
        case 'title':
        default:
          return a.title.compareTo(b.title);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Library Catalog'),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: filteredBooks.isEmpty
                ? Center(child: Text('No books found.'))
                : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Book Title')),
                    DataColumn(label: Text('Author')),
                    DataColumn(label: Text('Rating')),
                    DataColumn(label: Text('Read')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: filteredBooks.asMap().entries.map((entry) {
                    int index = entry.key;
                    Book book = entry.value;
                    return DataRow(cells: [
                      DataCell(Text(book.title)),
                      DataCell(Text(book.author)),
                      DataCell(Text(book.rating.toString())),
                      DataCell(Text(book.isRead ? 'Read' : 'Unread')),
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
                                      rating: book.rating,
                                      isRead: book.isRead,
                                      onSave: (newTitle, newAuthor, newRating, newIsRead) {
                                        _editBook(index, newTitle, newAuthor, newRating, newIsRead);
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditBookScreen(
                onSave: (title, author, rating, isRead) {
                  _addBook(title, author, rating, isRead);
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