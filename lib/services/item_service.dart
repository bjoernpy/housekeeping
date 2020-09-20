import 'dart:async';

import 'package:housekeeping/models/item.dart';

abstract class ItemServiceAbstact {
  Future<List<Item>> getItems();
  Future<List<Item>> addItem(Item item);
  Future<List<Item>> removeItem(Item item);
  Future<List<Item>> clearItems();
}

class ItemService extends ItemServiceAbstact {
  List<Item> itemList = [new Item.fromName("Test"), new Item.fromName("Test2")];

  @override
  Future<List<Item>> addItem(Item item) async {
    this.itemList.add(item);
    return this.itemList;
  }

  @override
  Future<List<Item>> clearItems() async {
    this.itemList = [];
    return this.itemList;
  }

  @override
  Future<List<Item>> getItems() async {
    return this.itemList;
  }

  @override
  Future<List<Item>> removeItem(Item item) async {
    if (this.itemList.contains(item)) {
      this.itemList.remove(item);
      return this.itemList;
    }
    return this.itemList;
  }
}
