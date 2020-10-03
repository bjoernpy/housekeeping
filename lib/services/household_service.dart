import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class HouseholdServiceAbstract {
  Future<void> addToHousehold(String inviteCode);
  Future<void> createHousehold(String name);
  Future<String> createInviteCode();
}

class HouseholdService extends HouseholdServiceAbstract {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference households = FirebaseFirestore.instance.collection("households");
  final CollectionReference users = FirebaseFirestore.instance.collection("users");

  @override
  Future<void> createHousehold(String name) async {
    User user = _auth.currentUser;
    try {
      DocumentReference newHousehold = await households.add({"name": "$name"});
      await households.doc(newHousehold.id).collection("lists").add({"name": "groceryList", "items": []});
      await users.doc(user.uid).update({
        "households": [newHousehold.id]
      });
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> addToHousehold(String inviteCode) {
    // TODO: implement addToHousehold
    throw UnimplementedError();
  }

  @override
  Future<String> createInviteCode() {
    // TODO: implement createInviteCode
    throw UnimplementedError();
  }
}

final HouseholdService householdService = HouseholdService();
