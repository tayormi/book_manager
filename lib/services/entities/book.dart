import 'package:book_manager/services/entities/author.dart';
import 'package:book_manager/services/entities/book_category.dart';
import 'package:isar/isar.dart';

part 'book.g.dart';

@Collection()
class Book {
  Id id = Isar.autoIncrement;
  late String title;
  late String isbn;
  late String description;
  final bookCategory = IsarLink<BookCategory>();
  final author = IsarLink<Author>();
}
