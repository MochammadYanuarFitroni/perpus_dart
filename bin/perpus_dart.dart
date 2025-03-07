import 'dart:io';

void main(List<String> arguments) {
  stdout.write('Username: ');
  String username = stdin.readLineSync()!;
  stdout.write('Password: ');
  String password = stdin.readLineSync()!;
}
