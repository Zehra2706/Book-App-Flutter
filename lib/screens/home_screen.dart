import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/book.dart';
import 'package:flutter_application_1/screens/book_detail_screen.dart';
import 'package:flutter_application_1/screens/cart_screen.dart';

final List<Book> sampleBooks = [
  Book(
    title: 'Nutuk',
    author: 'Mustafa Kemal Atatürk',
    description: 'Cumhuriyetin kuruluş sürecini anlatan tarihi eser.',
    price: 180,
    pageCount: '600',
    category: 'Tarih',
    imageUrl:
        'https://i.dr.com.tr/cache/600x600-0/originals/0000000500410-1.jpg',
    rating: 4.9,
    publisher: 'Türk Tarih Kurumu',
    language: 'Türkçe',
    publishYear: 1927,
  ),
  Book(
    title: 'Kürk Mantolu Madonna',
    author: 'Sabahattin Ali',
    description: 'Raif Efendi ve Maria Puder’in hikayesi.',
    price: 95,
    pageCount: '160',
    category: 'Roman',
    imageUrl:
        'https://covers.openlibrary.org/b/title/Kürk%20Mantolu%20Madonna-L.jpg',
    rating: 4.7,
    publisher: 'Yapı Kredi Yayınları',
    language: 'Türkçe',
    publishYear: 1943,
  ),
  Book(
    title: 'Simyacı',
    author: 'Paulo Coelho',
    description: 'Kendi kaderini arayan Santiago’nun yolculuğu.',
    price: 120,
    pageCount: '184',
    category: 'Felsefe',
    imageUrl: 'https://covers.openlibrary.org/b/title/Simyacı-L.jpg',
    rating: 4.6,
    publisher: 'Can Yayınları',
    language: 'Türkçe',
    publishYear: 1988,
  ),
  Book(
    title: '1984',
    author: 'George Orwell',
    description: 'Totaliter rejim altında özgürlük mücadelesi.',
    price: 110,
    pageCount: '352',
    category: 'Distopya',
    imageUrl: 'https://covers.openlibrary.org/b/title/1984-L.jpg',
    rating: 4.8,
    publisher: 'Can Yayınları',
    language: 'Türkçe',
    publishYear: 1949,
  ),
  Book(
    title: 'Suç ve Ceza',
    author: 'Fyodor Dostoyevski',
    description: 'Psikolojik derinliği olan klasik eser.',
    price: 145,
    pageCount: '687',
    category: 'Klasik',
    imageUrl:
        'https://covers.openlibrary.org/b/title/Crime%20and%20Punishment-L.jpg',
    rating: 4.9,
    publisher: 'İş Bankası Kültür Yayınları',
    language: 'Türkçe',
    publishYear: 1866,
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Book> sepetimdekiKitaplar = [];
  final TextEditingController searchController = TextEditingController();

  List<Book> filteredBooks = sampleBooks;

  Widget categoryChip(String text) {
    return GestureDetector(
      onTap: () => filterByCategory(text),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    filteredBooks = sampleBooks;
  }

  void searchBooks(String query) {
    final results = sampleBooks.where((book) {
      final titleLower = book.title.toLowerCase();
      final authorLower = book.author.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();

    setState(() {
      filteredBooks = results;
    });
  }

  void filterByCategory(String category) {
    setState(() {
      if (category == "Tümü") {
        filteredBooks = sampleBooks;
      } else {
        filteredBooks = sampleBooks
            .where((b) => b.category == category)
            .toList();
      }
    });
  }

  Widget buildBookGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredBooks.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.60,
        crossAxisSpacing: 16,
        mainAxisSpacing: 18,
      ),
      itemBuilder: (context, index) {
        final book = filteredBooks[index];

        return InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailScreen(
                  book: book,
                  onBookAdded: () {
                    setState(() {
                      sepetimdekiKitaplar.add(book);
                    });
                  },
                  isFavorite: false,
                  onFavoriteToggle: () {},
                ),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.network(
                      book.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.book, color: Colors.brown);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                book.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                book.author,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
              Text(
                '${book.price.toStringAsFixed(0)} TL',
                style: const TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f5f2),

      appBar: AppBar(
        backgroundColor: const Color(0xfff8f5f2),
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Okur Kitabevi',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Yeni dünyalar keşfet',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),

        // ✅ SEPET İKONU GERİ EKLENDİ
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.local_mall_outlined,
                  color: Colors.black,
                ),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CartScreen(cartItems: sepetimdekiKitaplar),
                    ),
                  );
                  setState(() {});
                },
              ),
              if (sepetimdekiKitaplar.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.brown,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${sepetimdekiKitaplar.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 10),

              TextField(
                controller: searchController,
                onChanged: searchBooks,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Kitap ara...",
                ),
              ),

              const SizedBox(height: 18),

              SizedBox(
                height: 38,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    categoryChip("Tümü"),
                    categoryChip("Roman"),
                    categoryChip("Distopya"),
                    categoryChip("Tarih"),
                    categoryChip("Felsefe"),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                'Öne Çıkan Kitaplar',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 18),

              buildBookGrid(),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favoriler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
