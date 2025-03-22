import 'dart:ffi';
import 'dart:io';
import 'package:perpus_dart/enums/UserRole.dart';
import 'package:perpus_dart/function/function.dart';
import 'package:perpus_dart/models/Book.dart';
import 'package:perpus_dart/models/Ebook.dart';
import 'package:perpus_dart/models/LibraryItem.dart';
import 'package:perpus_dart/models/User.dart';
import 'package:perpus_dart/services/LibraryController.dart';
import 'package:perpus_dart/services/UserController.dart';

void main() async {
  User? currentUser;
  bool login = false;
  while (currentUser == null) {
    print("\nSelamat Datang!!");
    print("1. Login");
    print("0. Exit");
    stdout.write("Pilih Menu: ");
    String? choice1 = stdin.readLineSync();

    switch (choice1) {
      case '1':
        print("\nLibrary Login");
        stdout.write("username: ");
        String username = stdin.readLineSync()!;
        stdout.write("password: ");
        String password = stdin.readLineSync()!;

        currentUser = await UserController.login(username, password);

        if (currentUser != null) {
          login = true;
          print("Login Berhasil!!, Selamat datang ${currentUser.username}");
        } else {
          currentUser = null;
          login = false;
        }
      case '0':
        print("Exiting program...\n");
        exit(0);
    }
  }

  while (login == true) {
    print("\nSelamat datang di sistem perpustakaan ini!!\n");
    print("Silahkan pilih menu dibawah ini: \n");
    print("1. Semua buku");
    print("2. Cari buku");
    if (currentUser.role == UserRole.admin) {
      print("3. Tambah buku (book)");
      print("4. Tambah buku (e-book)");
      print("5. Edit buku");
      print("6. Hapus buku");
      print("7. List user");
      print("8. Tambah user");
    }
    print("9. Logut");
    print("0. Exit");
    stdout.write("Pilih Menu: ");
    String? choice2 = stdin.readLineSync();

    switch (choice2) {
      case '1':
        await listAllBook();
        break;
      case '2':
        await searchBook();
        break;
      case '3':
        if (currentUser.role == UserRole.admin) {
          print("Tambah Data Buku!!!\n");
          stdout.write("Masukkan Judul Buku: ");
          String title = stdin.readLineSync()!;
          stdout.write("Masukkan Nama Author: ");
          String author = stdin.readLineSync()!;
          stdout.write("Masukkan ISBN: ");
          String isbn = stdin.readLineSync()!;
          await LibraryController.addBook(
              Book(title: title, author: author, isbn: isbn));
        } else {
          print("Akses ditolak!!!");
        }
        break;
      case '4':
        if (currentUser.role == UserRole.admin) {
          print("Tambah Data Buku Elektronik!!!\n");
          stdout.write("Masukkan Judul Buku: ");
          String title = stdin.readLineSync()!;
          stdout.write("Masukkan Nama Author: ");
          String author = stdin.readLineSync()!;
          stdout.write("Masukkan ISBN: ");
          String isbn = stdin.readLineSync()!;
          stdout.write("Masukkan Ukuran file: ");
          double fileSize = double.parse(stdin.readLineSync()!);
          await LibraryController.addBook(Ebook(
              title: title, author: author, isbn: isbn, fileSize: fileSize));
        } else {
          print("Akses ditolak!!!");
        }
        break;
      case '5':
        await updateBookFromList();
        break;
      case '6':
        await deleteBookFromList();
        break;
      case '7':
        await listUser();
        break;
      case '8':
        if (currentUser.role == UserRole.admin) {
          print("tambah data user!!!\n");
          stdout.write("Masukkan Username: ");
          String username = stdin.readLineSync()!;
          stdout.write("Masukkan Password: ");
          String password = stdin.readLineSync()!;
          print("Role: \n");
          print('1. Admin\n');
          print('2. Member\n');
          stdout.write("Pilih Role: ");
          int choiceRole = int.parse(stdin.readLineSync()!);
          dynamic role;
          if (choiceRole == 1) {
            role = UserRole.admin;
          } else {
            role = UserRole.member;
          }
          User user = User(username: username, password: password, role: role);
          print("object");
          await UserController.addUser(user);
          // print("Menu ini masih dalam pengembangan");
        } else {
          print("Akses ditolak!!!");
        }
        break;
      case '9':
        print("Logging out...\n");
        // currentUser = null;
        login = false;
        return main();
      case '0':
        print("Exiting program...\n");
        exit(0);
      default:
        print("Invalid option. Please try again.\n");
    }
  }
}
