import 'package:perpus_dart/enums/BookStatus.dart';
import 'LibraryItem.dart';

class Ebook extends LibraryItem{
  double fileSize;

  Ebook(
      {int? id,
        required String title,
        required String author,
        required String isbn,
        BookStatus status = BookStatus.tersedia,
        required this.fileSize,})
      : super(id: id, title: title, author: author, isbn: isbn, status: status);

  // Ebook(String title, String author, String isbn, this.fileSize,
  //     {BookStatus status = BookStatus.tersedia})
  //     : super(title, author, isbn, status: status);
  //
  // @override
  // void displayInfoBook() {
  //   // TODO: implement displayInfoBook
  //   super.displayInfoBook();
  //   print('File size: ${fileSize}MB\n');
  // }
}