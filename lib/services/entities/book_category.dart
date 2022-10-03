import 'package:book_manager/services/entities/book.dart';
import 'package:isar/isar.dart';

part 'book_category.g.dart';

@Collection()
class BookCategory {
  Id id = Isar.autoIncrement;
  late String title;
  final books = IsarLinks<Book>();
}
