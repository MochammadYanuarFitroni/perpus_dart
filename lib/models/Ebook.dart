import 'package:perpus_dart/enums/BookStatus.dart';
import 'LibraryItem.dart';

class Ebook extends LibraryItem{
  double fileSize;

  Ebook(String title, String author, String isbn, this.fileSize,
      {BookStatus status = BookStatus.tersedia})
      : super(title, author, isbn, status: status);

  @override
  void displayInfoBook() {
    // TODO: implement displayInfoBook
    super.displayInfoBook();
    print('File size: ${fileSize}MB\n');
  }
}