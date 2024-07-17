class Book {
  final String title;
  final String author;
  double rating; // New property for rating
  bool isRead;   // New property for read/unread status

  Book({
    required this.title,
    required this.author,
    this.rating = 0.0, // Default rating
    this.isRead = false, // Default status
  });
}
