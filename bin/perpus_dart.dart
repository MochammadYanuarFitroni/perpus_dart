import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:perpus_dart/database/database.dart';
import 'package:perpus_dart/enums/UserRole.dart';
import 'package:perpus_dart/models/Book.dart';
import 'package:perpus_dart/models/Ebook.dart';
import 'package:perpus_dart/models/LibraryItem.dart';
import 'package:perpus_dart/models/User.dart';
import 'package:perpus_dart/services/LibraryController.dart';
import 'package:perpus_dart/services/UserController.dart';

void main() async {
  var conn = await database.connect();
  print("Connected to database!");
  print(conn);

  // '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9'
  // '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9'
  // var konversi = sha256.convert(utf8.encode('admin123')).toString();

  var result =
      await conn.query('SELECT * FROM users WHERE username = ?', ['admin']);

  // final numbers = <int><code>1, 2, 3, 5, 6, 7</ code>;
  // var result = numbers. firstWhere((element) => element < 5); // 1
  // result = numbers. firstWhere((element) => element > 5); // 6
  // result =
  // numbers. firstWhere((element) => element > 10, orElse: () => -1); // -1

  // final role = [
  //   'admin',
  //   'member'
  // ];

  var newRole = UserRole.values.firstWhere((e) => e.name == 'admin');
  print(newRole);

  User user = User(username: "zxc", password: "zxc", role: UserRole.member);
  UserController.addUser(user);
  // User? user =  await UserController.login("admin", "admin5645");
  // if (user != null) {
  //   print("Login berhasil! Selamat datang, ${user.username}");
  // } else {
  //   print(user);
  // }

  // List<LibraryItem> books = await LibraryController.getAllBooks();
  // for(var book in books){
  //   if(book is Ebook){
  //     print("===========================================\n"
  //         "Ebook: \n"
  //         "title: ${book.title}\n"
  //         "author: ${book.author}\n"
  //         "isbn: ${book.isbn}\n"
  //         "status: ${book.status}\n"
  //         "file size: ${book.fileSize} MB\n"
  //         "===========================================\n");
  //   }
  //   else{
  //     print("===========================================\n"
  //         "Book: \n"
  //         "title: ${book.title}\n"
  //         "author: ${book.author}\n"
  //         "isbn: ${book.isbn}\n"
  //         "status: ${book.status}\n"
  //         "===========================================\n");
  //   }
  // }
  // Book book =
  //     Book(title: "haiya programming", author: "yanuar", isbn: "172948");
  // Book book = Book(title: "apalah ini", author: "Gultom", isbn: "12398");
  //
  // print(book);
  Ebook ebook = Ebook(
      title: "Ini Ebook",
      author: "Rifki A.",
      isbn: "88123",
      fileSize: 14);
  //
  // LibraryController.addBook(book);
  LibraryController.addBook(ebook);

  print(result);
  // print(konversi);
  await conn.close();
}
