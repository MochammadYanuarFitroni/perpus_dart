// import 'package:perpus_dart/interfaces/Borrowable.dart';
import 'package:perpus_dart/enums/BookStatus.dart';

class LibraryItem {
  String title;
  String author;
  String isbn;
  BookStatus status;

  LibraryItem(this.title, this.author, this.isbn,
      {this.status = BookStatus.tersedia});

  void displayInfoBook() {
    print("Judul: $title");
    print("Penulis: $author");
    print("ISBN: $isbn");
    print(
        "Status: ${status == BookStatus.tersedia ? 'tersedia' : 'sedang dipinjam'}");
  }
}
