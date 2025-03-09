import 'package:mysql1/mysql1.dart';

class database {
  // ubah sesuai kebutuhan
  static final ConnectionSettings _connectionSettings = ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'root',  // Ubah jika ada password
    db: 'perpustakaan',
  );

  // Method untuk menghubungkan ke MySQL
  static Future<MySqlConnection> connect() async {
    return await MySqlConnection.connect(_connectionSettings);
  }
}