import 'dart:ffi';
import 'dart:io';

import 'package:perpus_dart/database/database.dart';
import 'package:perpus_dart/enums/BookStatus.dart';
import 'package:perpus_dart/function/function.dart';
import 'package:perpus_dart/models/Book.dart';
import 'package:perpus_dart/models/Ebook.dart';
import 'package:perpus_dart/models/LibraryItem.dart';

class LibraryController {
  /*List<LibraryItem> items = [];

   */

  // tambah buku
  static Future<void> addBook(LibraryItem book) async {
    var conn = await connectionDB();
    try {
      if (book is Ebook) {
        // params = [...params, book.fileSize.toString()];
        await conn.query(
            'INSERT INTO books (title, author, isbn, status, file_size) VALUES (?, ?, ?, ?, ?)',
            [
              book.title,
              book.author,
              book.isbn,
              book.status.name,
              book.fileSize
            ]);

        print("\nE-book '${book.title}' berhasil ditambahkan");
      } else {
        var status = book.status.name;
        await conn.query(
            'INSERT INTO books (title, author, isbn, status) VALUES (?, ?, ?, ?)',
            [book.title, book.author, book.isbn, status]);

        print("\nbook '${book.title}' berhasil ditambahkan");
      }
    } catch (e) {
      print("error: $e");
    } finally {
      await conn.close();
    }
  }

  // lihat semua buku
  static Future<List<LibraryItem>> getAllBooks() async {
    var conn = await connectionDB();
    List<LibraryItem> books = [];
    try {
      var result = await conn.query("SELECT * FROM books");
      // print(result);
      // List<String> test = [];
      for (var row in result) {
        // test.add(row['id'] as String);
        var id = row['id'] as int;
        var title = row['title'] as String;
        var author = row['author'] as String;
        var isbn = row['isbn'] as String;
        var status =
            BookStatus.values.firstWhere((e) => e.name == row['status']);
        var fileSize = row['file_size'] as double?;
        // print(fileSize);

        if (fileSize != null) {
          books.add(Ebook(
              id: id,
              title: title,
              author: author,
              isbn: isbn,
              status: status,
              fileSize: fileSize));
        } else {
          books.add(Book(
              id: id,
              title: title,
              author: author,
              isbn: isbn,
              status: status));
        }
      }
      // print(test);
    } catch (e) {
      print('Error: $e');
    } finally {
      await conn.close();
    }
    return books;
  }

  // update buku
  static Future<void> updateBook(int id, LibraryItem updateBook) async {
    var conn = await connectionDB();
    try {
      if (updateBook is Ebook) {
        await conn.query(
          'UPDATE books SET title = ?, author = ?, isbn = ?, status = ?, file_size = ?, updated_at = NOW() WHERE id = ?',
          [
            updateBook.title,
            updateBook.author,
            updateBook.isbn,
            updateBook.status.name,
            updateBook.fileSize,
            id
          ],
        );
      } else {
        await conn.query(
          "UPDATE books SET title = ?, author = ?, isbn = ?, status = ?, updated_at = NOW() WHERE id = ?",
          [
            updateBook.title,
            updateBook.author,
            updateBook.isbn,
            updateBook.status.name,
            id
          ],
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      await conn.close();
    }
  }

  // cari buku
  static Future<List<LibraryItem>> findBook(String keyword) async {
    var conn = await connectionDB();
    List<LibraryItem> books = [];
    try {
      var result = await conn.query(
        "SELECT * FROM books WHERE title LIKE ? OR author LIKE ? OR isbn LIKE ?",
        ['%$keyword%','%$keyword%','%$keyword%'],
      );
      // print(result);
      // List<String> test = [];
      for (var row in result) {
        // test.add(row['id'] as String);
        var id = row['id'] as int;
        var title = row['title'] as String;
        var author = row['author'] as String;
        var isbn = row['isbn'] as String;
        var status =
            BookStatus.values.firstWhere((e) => e.name == row['status']);
        var fileSize = row['file_size'] as double?;
        // print(fileSize);

        if (fileSize != null) {
          books.add(Ebook(
              id: id,
              title: title,
              author: author,
              isbn: isbn,
              status: status,
              fileSize: fileSize));
        } else {
          books.add(Book(
              id: id,
              title: title,
              author: author,
              isbn: isbn,
              status: status));
        }
      }
      // print(test);
    } catch (e) {
      print('Error: $e');
    } finally {
      await conn.close();
    }
    return books;
  }

  // hapus buku
  static Future<int?> deleteBook(int id) async {
    var conn = await connectionDB();
    int? affectedRows;
    try{
      var result = await conn.query("DELETE FROM books WHERE id = ?", [id]);
      affectedRows = result.affectedRows;
    }
    catch (e){
      print('Error: $e');
    }
    finally{
      await conn.close();
    }
    return affectedRows;
  }
}
