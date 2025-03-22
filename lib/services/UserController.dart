import 'package:bcrypt/bcrypt.dart';
import 'package:perpus_dart/database/database.dart';
import 'package:perpus_dart/enums/UserRole.dart';
import 'package:perpus_dart/models/User.dart';

class UserController {
  ///add user
  static Future<void> addUser(User user) async {
    var conn = await database.connect();
    try {
      final String hashingPassword = User.hashPassword(user.password);

      await conn.query(
        "INSERT INTO users (username, password, role) VALUES (?, ?, ?)",
        [user.username, hashingPassword, user.role.name],
      );

      print("Berhasil menambahkan akun atau user!!!");
    }
    catch (e) {
      print("error: $e");
    }
    finally {
      await conn.close();
    }
  }

  ///end add user

  ///login
  static Future<User?> login(String username, String password) async {
    var conn = await database.connect();
    try {
      var result = await conn.query(
          'SELECT * FROM users WHERE username = ?', [username]
      );

      if (result.isNotEmpty) {
        var first = result.first;

        if (BCrypt.checkpw(password, first['password'])) {
          // print("login berhasil!!!");
          return User(
              id: first['id'],
              username: first['username'],
              password: first['password'],
              role: UserRole.values.firstWhere((e) => e.name == first['role'])
          );
        }
        else {
          // jika password salah
          print("username atau password anda salah!!!");
        }
      }
      else {
        // jika tidak ada datanya
        print("username atau password anda tidak ditemukan!!!");
      }
      return null;
    }
    finally {
      await conn.close();
    }
  }
  ///end login

  ///show all user
  static Future<List<User>> getAllUser() async {
    var conn = await database.connect();
    List<User> users = [];
    try {
      var result = await conn.query("SELECT id, username, role FROM users");

      for (var row in result) {
        var id = row['id'] as int;
        var username = row['username'] as String;
        var role = UserRole.values.firstWhere((e) => e.name == row['role']);

        users.add(
            User(id: id, username: username, password: "", role: role));
      }
    } catch (e) {
      print("error: $e");
    }
    finally {
      await conn.close();
    }
    return users;
  }
  ///end show all user
}