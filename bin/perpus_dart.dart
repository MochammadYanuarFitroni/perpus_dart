import 'dart:io';

import 'package:perpus_dart/database/database.dart';

void main() async{
  var conn = await database.connect();
  print("Connected to database!");
  print(conn);

  await conn.close();
}
