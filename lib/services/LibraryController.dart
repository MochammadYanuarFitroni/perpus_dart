import 'package:perpus_dart/database/database.dart';
import 'package:perpus_dart/models/Ebook.dart';
import 'package:perpus_dart/models/LibraryItem.dart';

class LibraryController {
  /*List<LibraryItem> items = [];

  void addItem(LibraryItem item){
    items.add(item);
    print('Data Buku ${item.title} berhasil ditambahkan\n');
  }

  void showItems(){
    if(items.isEmpty){
      print('tidak ada buku\n');
    }
    else{
      print('Data buku: ');
      print('==================================================');
      for(var item in items){
        item.displayInfoBook();
        print('');
      }
      print('==================================================');
    }
  }

  void findItem(String title) {
    var foundItems = items.where((item) => item.title.toLowerCase() == title.toLowerCase()).toList();
    if (foundItems.isEmpty) {
      print("Item not found.\n");
    } else {
      print("Item found:");
      for (var item in foundItems) {
        item.displayInfoBook();
      }
    }
  }*/
  static Future<void> addBook(LibraryItem book) async {
    var conn = await database.connect();
    // var params = [
    //   book.title,
    //   book.author,
    //   book.isbn,
    //   book.status.name,
    // ];
    print(book);
    // try {
    //   if (book is Ebook) {
    //     // Jika Ebook, tambahkan file_size
    //     await conn.query(
    //         'INSERT INTO books (title, author, isbn, status, file_size) VALUES (?, ?, ?, ?, ?)',
    //         [book.title, book.author, book.isbn, book.status.name, book.fileSize]
    //     );
    //   } else {
    //     // Jika Book biasa, jangan masukkan file_size
    //     await conn.query(
    //         'INSERT INTO books (title, author, isbn, status) VALUES (?, ?, ?, ?)',
    //         [book.title, book.author, book.isbn, book.status.name]
    //     );
    //   }
    //   print("Buku '${book.title}' berhasil ditambahkan!");
    try {
      if (book is Ebook) {
        // params = [...params, book.fileSize.toString()];
        await conn.query(
            'INSERT INTO books (title, author, isbn, status, file_size) VALUES (?, ?, ?, ?, ?)',
            [book.title, book.author, book.isbn, book.status.name, book.fileSize]
        );
        print("\n");
        print("E-book '${book.title}' berhasil ditambahkan");
        print("\n");
      } else {
        var status = book.status.name;
        await conn.query(
            'INSERT INTO books (title, author, isbn, status) VALUES (?, ?, ?, ?)',
            [book.title, book.author, book.isbn, status]
        );
        // print(book.status);
        // print(book.status.name);
        print("\n");
        print("book '${book.title}' berhasil ditambahkan");
        print("\n");
      }
    }
    catch(e){
      print("error: $e");
    }
    finally {
      await conn.close();
    }
  }
}
