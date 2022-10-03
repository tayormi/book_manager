import 'package:book_manager/services/entities/book.dart';
import 'package:isar/isar.dart';

part 'author.g.dart';

@Collection()
class Author {
  Id id = Isar.autoIncrement;

  late String firstName;

  late String lastName;

  final books = IsarLinks<Book>();
}
