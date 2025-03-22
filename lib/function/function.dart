import 'package:mysql1/src/single_connection.dart';
import 'package:perpus_dart/database/database.dart';
import 'package:perpus_dart/enums/BookStatus.dart';
import 'package:perpus_dart/models/Book.dart';
import 'package:perpus_dart/models/Ebook.dart';
import 'package:perpus_dart/models/LibraryItem.dart';
import 'package:perpus_dart/models/User.dart';
import 'package:perpus_dart/services/LibraryController.dart';
import 'package:perpus_dart/services/UserController.dart';
import 'dart:io';

Future<MySqlConnection> connectionDB() async {
  var conn = await database.connect();
  return conn;
}

// Future<List<LibraryItem>> listAllBook() async {
//   List<LibraryItem> books = await LibraryController.getAllBooks();
//   print("List semua buku yang ada\n");
//   int i = 1;
//   for (var book in books) {
//     print("===========================================\n"
//         "${i}\n"
//         "${book is Ebook ? "Ebook" : "Book"}\n"
//         "title: ${book.title}\n"
//         "author: ${book.author}\n"
//         "isbn: ${book.isbn}\n"
//         "status: ${book.status.name}\n"
//         "${book is Ebook ? "file size: ${book.fileSize} MB\n" : ""}"
//         "===========================================\n");
//     i++;
//   }
//   return books;
// }

Future<List<LibraryItem>> listAllBook() async {
  List<LibraryItem> books = await LibraryController.getAllBooks();
  print("List semua buku yang ada\n");

  int i = 1;
  Map<int, int> bookIndexMap = {}; // Menyimpan mapping index -> book.id

  for (var book in books) {
    bookIndexMap[i] = book.id!; // Simpan ID buku dalam map

    print("===========================================\n"
        "${i}\n" // Menampilkan indeks bukan ID dari database
        "${book is Ebook ? "Ebook" : "Book"}\n"
        "Title: ${book.title}\n"
        "Author: ${book.author}\n"
        "ISBN: ${book.isbn}\n"
        "Status: ${book.status.name}\n"
        "${book is Ebook ? "File Size: ${book.fileSize} MB\n" : ""}"
        "===========================================\n");
    i++;
  }

  return books;
}

Future<void> updateBookFromList() async {
  List<LibraryItem> books = await listAllBook();

  if (books.isEmpty) {
    print("Tidak ada buku yang tersedia.\n");
    return;
  }

  // Mapping index ke ID database
  Map<int, int> bookIndexMap = {};
  for (int i = 0; i < books.length; i++) {
    bookIndexMap[i + 1] = books[i].id!;
  }

  stdout.write("Masukkan nomor buku yang ingin diperbarui: ");
  int? inputIndex = int.tryParse(stdin.readLineSync() ?? "");

  if (inputIndex == null || !bookIndexMap.containsKey(inputIndex)) {
    print("Nomor tidak valid atau tidak ditemukan.\n");
    return;
  }

  int selectedBookId = bookIndexMap[inputIndex]!; // Ambil ID dari database
  var selectedBook = books.firstWhere((book) => book.id == selectedBookId);

  // Tampilkan informasi jenis buku
  String bookType = selectedBook is Ebook ? "Ebook" : "Book";
  print("\nAnda akan memperbarui ${bookType} dengan detail:");
  print("Title : ${selectedBook.title}");
  print("Author: ${selectedBook.author}");
  print("ISBN  : ${selectedBook.isbn}");
  print("Status: ${selectedBook.status.name}");
  if (selectedBook is Ebook) {
    print("File Size: ${selectedBook.fileSize} MB");
  }
  print("===========================================\n");

  stdout.write("Masukkan judul baru (kosongkan untuk tetap sama): ");
  String? newTitle = stdin.readLineSync();
  stdout.write("Masukkan penulis baru (kosongkan untuk tetap sama): ");
  String? newAuthor = stdin.readLineSync();
  stdout.write("Masukkan ISBN baru (kosongkan untuk tetap sama): ");
  String? newIsbn = stdin.readLineSync();
  stdout.write("Masukkan status baru (tersedia/dipinjam): ");
  String? newStatus = stdin.readLineSync();

  // Konversi status menjadi enum
  BookStatus? status = newStatus != null && newStatus.isNotEmpty
      ? BookStatus.values.firstWhere(
          (e) => e.name.toLowerCase() == newStatus.toLowerCase(),
          orElse: () => selectedBook.status,
        )
      : selectedBook.status;

  // Jika buku adalah Ebook, tanyakan file size
  if (selectedBook is Ebook) {
    stdout.write("Masukkan ukuran file baru (kosongkan untuk tetap sama): ");
    String? newFileSize = stdin.readLineSync();
    double? fileSize = newFileSize != null && newFileSize.isNotEmpty
        ? double.tryParse(newFileSize)
        : (selectedBook as Ebook).fileSize;

    var updatedBook = Ebook(
      id: selectedBook.id,
      title: newTitle?.isNotEmpty == true ? newTitle! : selectedBook.title,
      author: newAuthor?.isNotEmpty == true ? newAuthor! : selectedBook.author,
      isbn: newIsbn?.isNotEmpty == true ? newIsbn! : selectedBook.isbn,
      status: status,
      fileSize: fileSize!,
    );

    await LibraryController.updateBook(selectedBookId, updatedBook);
  } else {
    var updatedBook = Book(
      id: selectedBook.id,
      title: newTitle?.isNotEmpty == true ? newTitle! : selectedBook.title,
      author: newAuthor?.isNotEmpty == true ? newAuthor! : selectedBook.author,
      isbn: newIsbn?.isNotEmpty == true ? newIsbn! : selectedBook.isbn,
      status: status,
    );

    await LibraryController.updateBook(selectedBookId, updatedBook);
  }

  print("\n${bookType} dengan nomor urut $inputIndex berhasil diperbarui.");
}

Future<void> searchBook() async {
  stdout.write("Masukkan judul, penulis, atau ISBN buku yang dicari: ");
  String keyword = stdin.readLineSync() ?? "";

  if (keyword.isEmpty) {
    print("Kata kunci tidak boleh kosong!\n");
    return;
  }

  List<LibraryItem> books = await LibraryController.findBook(keyword);
  int i = 1;

  if (books.isEmpty) {
    print("\nTidak ada buku yang ditemukan untuk kata kunci '$keyword'.\n");
  } else {
    print("\nHasil pencarian untuk '$keyword':\n");
    for (var book in books) {
      print("===========================================\n"
          "${book is Ebook ? "Ebook" : "Book"}\n"
          // "ID: ${book.id}\n"
          "${i}\n"
          "Title: ${book.title}\n"
          "Author: ${book.author}\n"
          "ISBN: ${book.isbn}\n"
          "Status: ${book.status.name}\n"
          "${book is Ebook ? "File Size: ${book.fileSize} MB\n" : ""}"
          "===========================================\n");
      i++;
    }
  }
}

Future<void> deleteBookFromList() async {
  List<LibraryItem> books = await listAllBook();

  if (books.isEmpty) {
    print("Tidak ada buku yang tersedia.\n");
    return;
  }

  // Mapping index ke ID database
  Map<int, int> bookIndexMap = {};
  for (int i = 0; i < books.length; i++) {
    bookIndexMap[i + 1] = books[i].id!;
  }

  stdout.write("Masukkan nomor buku yang ingin dihapus: ");
  int? inputIndex = int.tryParse(stdin.readLineSync() ?? "");

  if (inputIndex == null || !bookIndexMap.containsKey(inputIndex)) {
    print("Nomor tidak valid atau tidak ditemukan.\n");
    return;
  }

  int selectedBookId = bookIndexMap[inputIndex]!;

  stdout.write("Apakah Anda yakin ingin menghapus buku dengan nomor urut $inputIndex? (y/n): ");
  String? confirm = stdin.readLineSync()?.toLowerCase();

  if (confirm != "y") {
    print("Penghapusan dibatalkan.");
    return;
  }

  int result = await LibraryController.deleteBook(selectedBookId) ?? 0;

  if(result > 0){
    print("Buku berhasil dihapus!!!");
  }
  else{
    print("Buku gagal dihapus!!!");
  }
}

Future<void> listUser() async {
  List<User> users = await UserController.getAllUser();
  print("Semua user: \n");
  int i = 1;
  for (var row in users) {
    print("===========================================\n"
        "${i}\n"
        "title: ${row.username}\n"
        "role: ${row.role.name}\n"
        "===========================================\n");
    i++;
  }
}
