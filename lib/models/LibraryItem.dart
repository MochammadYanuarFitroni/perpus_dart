// import 'package:perpus_dart/interfaces/Borrowable.dart';
import 'package:perpus_dart/enums/BookStatus.dart';

abstract class LibraryItem {
  int? id;
  String title;
  String author;
  String isbn;
  BookStatus status;

  LibraryItem(
      {this.id,
      required this.title,
      required this.author,
      required this.isbn,
      this.status = BookStatus.tersedia});
}
