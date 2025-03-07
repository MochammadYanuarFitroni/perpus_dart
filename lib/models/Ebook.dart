import 'package:perpus_dart/enums/BookStatus.dart';
import 'LibraryItem.dart';
import 'package:perpus_dart/interfaces/Borrowable.dart';

class Book extends LibraryItem implements Borrowable{
  Book(String title, String author, String isbn,
      {BookStatus status = BookStatus.tersedia})
      : super(title, author, isbn, status: status);

  @override
  void borrowItem() {
    // TODO: implement borrowItem
    if(status == BookStatus.tersedia){
      status = BookStatus.dipinjam;
      print('Buku $title telah dipinjam');
    }
    else{
      print('Buku $title tidak tesedia/lagi dipinjam');
    }
  }

  @override
  void returnItem() {
    // TODO: implement returnItem
    status = BookStatus.tersedia;
    print('Buku $title telah dikembalikan');
  }
}