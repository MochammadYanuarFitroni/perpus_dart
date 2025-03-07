import 'package:perpus_dart/enums/UserRole.dart';

class User {
  String username;
  String password;
  UserRole role;

  User(this.username, this.password, this.role);
}