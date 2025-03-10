import 'package:perpus_dart/enums/BookStatus.dart';
import 'LibraryItem.dart';
// import 'package:perpus_dart/interfaces/Borrowable.dart';

class Book extends LibraryItem {
  Book(
      {int? id,
      required String title,
      required String author,
      required String isbn,
      BookStatus status = BookStatus.tersedia})
  : super(id: id, title: title, author: author, isbn: isbn, status: status);

// Book(String title, String author, String isbn,
//     {BookStatus status = BookStatus.tersedia})
//     : super(title, author, isbn, status: status);

// @override
// void borrowItem() {
//   // TODO: implement borrowItem
//   if(status == BookStatus.tersedia){
//     status = BookStatus.dipinjam;
//     print('Buku $title telah dipinjam');
//   }
//   else{
//     print('Buku $title tidak tesedia/lagi dipinjam');
//   }
// }
//
// @override
// void returnItem() {
//   // TODO: implement returnItem
//   status = BookStatus.tersedia;
//   print('Buku $title telah dikembalikan');
// }
}
