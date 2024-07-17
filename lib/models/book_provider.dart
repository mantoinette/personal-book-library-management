

import 'package:flutter/material.dart';
import '../models/book.dart';

class BookProvider with ChangeNotifier {
  List<Book> _books = [];

  List<Book> get books => _books;

  void addBook(Book book) {
    _books.add(book);
    notifyListeners();
  }

  void updateBook(int index, Book book) {
    _books[index] = book;
    notifyListeners();
  }
}
