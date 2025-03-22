import 'package:perpus_dart/enums/BookStatus.dart';
import 'LibraryItem.dart';
// import 'package:perpus_dart/interfaces/Borrowable.dart';

class Book extends LibraryItem {
  Book(
      {int? id,
      required String title,
      required String author,
      required String isbn,
      BookStatus status = BookStatus.tersedia
      })
  : super(id: id, title: title, author: author, isbn: isbn, status: status);
}
