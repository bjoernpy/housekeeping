import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:housekeeping/models/item.dart';

abstract class ItemServiceAbstract {
  Future<List<Item>> addItem(Item item);
  Future<List<Item>> clearItems();
  Future<List<Item>> getItems();
  Future<List<Item>> removeItem(Item item);
}

class ItemService extends ItemServiceAbstract {
  static DocumentReference groceryList;
  static CollectionReference households = FirebaseFirestore.instance.collection("households");

// This methods inits the service
  static Future<void> initList() async {
    User user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot userData = await FirebaseFirestore.instance.collection("users").doc(user.uid).get();
    String householdId = userData.data()["households"][0];

    String listId;
    QuerySnapshot lists = await households.doc(householdId).collection("lists").get();
    lists.docs.forEach((doc) {
      if (doc.data()["name"] == "groceryList") listId = doc.id;
    });
    groceryList = households.doc(householdId).collection("lists").doc(listId);
  }

  @override
  Future<List<Item>> addItem(Item item) async {
    try {
      if (groceryList == null) {
        await initList();
      }
      await groceryList.update({
        "items": FieldValue.arrayUnion([item.name])
      });
      return await getItems();
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<List<Item>> clearItems() async {
    try {
      if (groceryList == null) {
        await initList();
      }
      await groceryList.set({"items": []});
      return await getItems();
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<List<Item>> getItems() async {
    try {
      if (groceryList == null) {
        await initList();
      }
      DocumentSnapshot listData = await groceryList.get();
      List list = listData.data()["items"];
      return list.map((e) => Item.fromName(e)).toList();
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<List<Item>> removeItem(Item item) async {
    try {
      if (groceryList == null) {
        await initList();
      }
      await groceryList.update({
        "items": FieldValue.arrayRemove([item.name])
      });
      return await getItems();
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
