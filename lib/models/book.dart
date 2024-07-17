class Book {
  final String title;
  final String author;
  double rating; // Property for rating
  bool isRead;   // Property for read/unread status

  Book({
    required this.title,
    required this.author,
    this.rating = 0.0, // Default rating
    this.isRead = false, // Default status
  });
}
