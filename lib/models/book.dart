class Book {
  final String title;
  final String author;
  final String description;
  final double price;
  final String pageCount;
  final String category;
  final String imageUrl;

  // YENİ ALANLAR
  final double rating;
  final String publisher;
  final String language;
  final int publishYear;

  Book({
    required this.title,
    required this.author,
    required this.description,
    required this.price,
    required this.pageCount,
    required this.category,
    required this.imageUrl,

    // YENİLER
    required this.rating,
    required this.publisher,
    required this.language,
    required this.publishYear,
  });
}
