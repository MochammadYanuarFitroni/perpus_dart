import 'package:perpus_dart/models/LibraryItem.dart';

class Library {
  List<LibraryItem> items = [];

  void addItem(LibraryItem item){
    items.add(item);
    print('Data Buku ${item.title} berhasil ditambahkan\n');
  }

  void showItems(){
    if(items.isEmpty){
      print('tidak ada buku\n');
    }
    else{
      print('Data buku: ');
      print('==================================================');
      for(var item in items){
        item.displayInfoBook();
        print('');
      }
      print('==================================================');
    }
  }

  void findItem(String title) {
    var foundItems = items.where((item) => item.title.toLowerCase() == title.toLowerCase()).toList();
    if (foundItems.isEmpty) {
      print("Item not found.\n");
    } else {
      print("Item found:");
      for (var item in foundItems) {
        item.displayInfoBook();
      }
    }
  }
}