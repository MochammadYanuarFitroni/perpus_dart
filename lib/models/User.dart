import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:perpus_dart/database/database.dart';
import 'package:perpus_dart/enums/UserRole.dart';

class User {
  int? id;
  String username;
  String password;
  UserRole role;

  User(
      {this.id,
      required this.username,
      required this.password,
      required this.role});

/*final String username;
  final String password;
  final UserRole role;

  User(this.username, this.password, this.role);

  // Function Expression (Arrow Function)
  /// hashing password
  static String hashPassword(String password) =>
      sha256.convert(utf8.encode(password)).toString();

  /// function add user
  static Future<void> addUser(
      String username, String password, UserRole role) async {
    var conn = await database.connect(); //ambil koneksi

    // tambah userbaru ke database
    try {
      String hashedPassword = hashPassword(password);
      await conn.query(
        'INSERT INTO users (username, password, role) VALUES (?, ?, ?)',
        [username, hashedPassword, role.name],
      );
      print('user berhasil ditambahkan!!');
    }

    // handle error
    catch (e) {
      print("Error: $e");
    }

    // tutup koneksi
    finally {
      await conn.close();
    }
  }

  /// function login
  static Future<User?> login(String username, String password) async {
    var conn = await database.connect();

    try {
      var result = await conn
          .query('SELECT * FROM users WHERE username = ?', [username]);

      if (result.isNotEmpty) {
        var row = result.first;
        String storePassword = row['password'];
        if (storePassword == hashPassword(password)) {
          print('Berhasil Login!!');
          return User(username, storePassword,
              UserRole.values.firstWhere((e) => e.name == row['role']));
          //output dari UserRole = UserRole.admin atau UserRole.member
        }
        else {
          print('Password salah!!!');
        }
      }
      else {
        print('User tidak ditemukan!!!');
      }
    } catch (e) {
      print("error: $e");
    } finally {
      await conn.close();
    }
    return null;
  }*/
}
