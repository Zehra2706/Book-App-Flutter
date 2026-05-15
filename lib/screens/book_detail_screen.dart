import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/book.dart';
import 'package:flutter_application_1/widgets/book_spec_box.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;
  final VoidCallback onBookAdded;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const BookDetailScreen({
    super.key,
    required this.book,
    required this.onBookAdded,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f5f2),

      appBar: AppBar(
        backgroundColor: const Color(0xfff8f5f2),
        elevation: 0,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),

        actions: [
          IconButton(
            onPressed: onFavoriteToggle,
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.black87,
            ),
          ),

          const SizedBox(width: 8),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ÜST GÖRSEL ALANI
            Container(
              width: double.infinity,
              height: 420,

              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xfff5ede7), Color(0xffefe3dc)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),

              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),

                  child: Hero(
                    tag: book.title,

                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22),

                        child: Image.network(
                          book.imageUrl,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,

                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }

                            return const SizedBox(
                              height: 260,
                              child: Center(child: CircularProgressIndicator()),
                            );
                          },

                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 260,
                              width: 180,
                              color: Colors.grey[200],

                              child: const Icon(
                                Icons.book,
                                size: 120,
                                color: Colors.brown,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // ALT İÇERİK
            Container(
              width: double.infinity,

              decoration: const BoxDecoration(color: Color(0xfff8f5f2)),

              child: Padding(
                padding: const EdgeInsets.all(22),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    // KATEGORİ
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 7,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.brown.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: Text(
                        book.category,
                        style: const TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // BAŞLIK
                    Text(
                      book.title,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // YAZAR
                    Text(
                      book.author,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 22),

                    // FİYAT
                    Row(
                      children: [
                        const Text(
                          'Fiyat',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),

                        const Spacer(),

                        Text(
                          '${book.price.toStringAsFixed(0)} TL',
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // ÖZET BAŞLIK
                    const Text(
                      'Kitap Özeti',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ÖZET
                    Text(
                      book.description,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[800],
                        height: 1.8,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // KÜNYE
                    const Text(
                      'Künye Bilgileri',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        BookSpecBox(title: 'SAYFA', value: book.pageCount),

                        const SizedBox(width: 10),

                        BookSpecBox(title: 'KATEGORİ', value: book.category),

                        const SizedBox(width: 10),

                        const BookSpecBox(title: 'DİL', value: 'Türkçe'),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // BUTON
                    SizedBox(
                      width: double.infinity,
                      height: 58,

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff5d4037),

                          elevation: 5,

                          shadowColor: Colors.brown.withOpacity(0.4),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),

                        onPressed: () {
                          onBookAdded();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,

                              margin: const EdgeInsets.all(16),

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),

                              content: Text('${book.title} sepete eklendi!'),

                              backgroundColor: Colors.brown[800],

                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },

                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Icon(
                              Icons.shopping_bag_outlined,
                              color: Colors.white,
                            ),

                            SizedBox(width: 10),

                            Text(
                              'Sepete Ekle',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
