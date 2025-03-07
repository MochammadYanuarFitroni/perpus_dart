import 'dart:io';
import 'package:perpus_dart/enums/UserRole.dart';
import 'package:perpus_dart/models/Book.dart';
import 'package:perpus_dart/models/Ebook.dart';
import 'package:perpus_dart/models/User.dart';
import 'package:perpus_dart/services/Library.dart';

void main() {
  // print("hello world");
  Library library = Library();
  List<User> users = [
    User('admin', 'admin123', UserRole.admin),
    User('member', 'member', UserRole.member)
  ];

  User? currentUser;

  while (currentUser == null) {
    print('\nLibrary Login');
    stdout.write('Username: ');
    String username = stdin.readLineSync()!;
    stdout.write('Password: ');
    String password = stdin.readLineSync()!;

    currentUser = users.firstWhere(
        (user) => user.username == username && user.password == password,
        orElse: () => User("", "", UserRole.member)
    );

    if(currentUser.username.isEmpty) {
      print('Coba lagi!!');
      currentUser = null;
    }
    else{
      print('login berhasil as ${currentUser.role.name}!!');
    }
  }

  while(true){
    print('\nLibrary Management System');
    print('1. Show Items');
    print('2. Find Items');
    if (currentUser.role == UserRole.admin) {
      print("3. Add Book");
      print("4. Add E-Book");
      print("5. Add User");
    }
    print("6. Logout");
    print("0. Exit");
    stdout.write("Choose an option: ");
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        library.showItems();
        break;
      case '2':
        stdout.write("Enter item title to search: ");
        String title = stdin.readLineSync()!;
        library.findItem(title);
        break;
      case '3':
        if (currentUser.role == UserRole.admin) {
          stdout.write("Enter book title: ");
          String title = stdin.readLineSync()!;
          stdout.write("Enter author: ");
          String author = stdin.readLineSync()!;
          stdout.write("Enter ISBN: ");
          String isbn = stdin.readLineSync()!;
          library.addItem(Book(title, author, isbn));
        } else {
          print("Access denied.\n");
        }
        break;
      case '4':
        if (currentUser.role == UserRole.admin) {
          stdout.write("Enter e-book title: ");
          String title = stdin.readLineSync()!;
          stdout.write("Enter author: ");
          String author = stdin.readLineSync()!;
          stdout.write("Enter ISBN: ");
          String isbn = stdin.readLineSync()!;
          stdout.write("Enter file size (MB): ");
          double fileSize = double.parse(stdin.readLineSync()!);
          library.addItem(Ebook(title, author, isbn, fileSize));
        } else {
          print("Access denied.\n");
        }
        break;
      case '5':
        if (currentUser.role == UserRole.admin) {
          stdout.write("Enter new username: ");
          String newUsername = stdin.readLineSync()!;
          stdout.write("Enter password: ");
          String newPassword = stdin.readLineSync()!;
          stdout.write("Enter role (admin/member): ");
          String newRoleStr = stdin.readLineSync()!;
          UserRole newRole = newRoleStr == "admin" ? UserRole.admin : UserRole.member;
          users.add(User(newUsername, newPassword, newRole));
          print("User added successfully.\n");
        } else {
          print("Access denied.\n");
        }
        break;
      case '6':
        print("Logging out...\n");
        return main();
      case '0': // Menangani opsi exit
        print("Exiting program...\n");
        exit(0);
      default:
        print("Invalid option. Please try again.\n");
    }
  }
}
