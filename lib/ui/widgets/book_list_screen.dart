import 'package:book_manager/services/entities/book.dart';
import 'package:book_manager/services/isar_service.dart';
import 'package:flutter/material.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({
    Key? key,
    required this.isarService,
  }) : super(key: key);

  final IsarService isarService;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (value) {
                  // Debounce
                  isarService.getAllBooks(search: value);
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Expanded(
          child: StreamBuilder<List<Book>>(
              stream: isarService.getAllBooks(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final books = snapshot.data;
                  if (books!.isEmpty) {
                    return const Center(child: Text('No books found'));
                  }
                  return ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(books[index].title),
                          subtitle: Text(
                              '${books[index].author.value!.firstName} ${books[index].author.value!.lastName}'),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ]),
    );
  }
}
