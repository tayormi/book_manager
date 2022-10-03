import 'package:book_manager/services/entities/author.dart';
import 'package:book_manager/services/entities/book.dart';
import 'package:book_manager/services/entities/book_category.dart';
import 'package:book_manager/services/isar_service.dart';
import 'package:book_manager/ui/widgets/add_author_modal.dart';
import 'package:book_manager/ui/widgets/add_category_modal.dart';
import 'package:flutter/material.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({
    Key? key,
    required this.isarService,
  }) : super(key: key);

  final IsarService isarService;

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bookTitleCtrl = TextEditingController();
  final _isbnCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();
  BookCategory? selectedBookCategory;
  Author? selectedAuthor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Book',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _bookTitleCtrl,
              decoration: const InputDecoration(
                labelText: 'Book Title',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Book title is not allowed to be empty";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: StreamBuilder<List<BookCategory>>(
                    stream: widget.isarService.getAllBookCategories(),
                    builder:
                        (context, AsyncSnapshot<List<BookCategory>> snapshot) {
                      if (snapshot.hasData) {
                        List<BookCategory> data = snapshot.data ?? [];
                        final categories = data.map((category) {
                          return DropdownMenuItem<BookCategory>(
                              key: UniqueKey(),
                              value: category,
                              child: Text(category.title));
                        }).toList();

                        return DropdownButtonFormField<BookCategory>(
                            decoration: const InputDecoration(
                              labelText: 'Category',
                              border: OutlineInputBorder(),
                            ),
                            items: categories,
                            value: selectedBookCategory,
                            onChanged: (category) =>
                                selectedBookCategory = category);
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return AddCategoryModal(
                            isarService: widget.isarService,
                          );
                        });
                  },
                  child: const Text('Add Category'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: StreamBuilder<List<Author>>(
                    stream: widget.isarService.getAllAuthors(),
                    builder: (context, AsyncSnapshot<List<Author>> snapshot) {
                      if (snapshot.hasData) {
                        final List<Author> data = snapshot.data ?? [];
                        final authors = data.map((author) {
                          return DropdownMenuItem<Author>(
                              key: UniqueKey(),
                              value: author,
                              child: Text(
                                  '${author.firstName} ${author.lastName}'));
                        }).toList();

                        return DropdownButtonFormField<Author>(
                            key: (selectedAuthor != null)
                                ? Key('${selectedAuthor?.id}')
                                : UniqueKey(),
                            decoration: const InputDecoration(
                              labelText: 'Author',
                              border: OutlineInputBorder(),
                            ),
                            items: authors,
                            value: selectedAuthor,
                            onChanged: (author) => selectedAuthor = author);
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return AddAuthorModal(
                            isarService: widget.isarService,
                          );
                        });
                  },
                  child: const Text('Add Author'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _isbnCtrl,
              decoration: const InputDecoration(
                labelText: 'ISBN',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "ISBN is not allowed to be empty";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _descriptionCtrl,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Description is not allowed to be empty";
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final book = Book()
                      ..title = _bookTitleCtrl.text
                      ..isbn = _isbnCtrl.text
                      ..description = _descriptionCtrl.text
                      ..bookCategory.value = selectedBookCategory
                      ..author.value = selectedAuthor;
                    widget.isarService.createBook(book);
                    _bookTitleCtrl.clear();
                    _isbnCtrl.clear();
                    _descriptionCtrl.clear();
                  }
                },
                child: const Text('Add Book'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
