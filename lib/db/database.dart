import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});
  final CollectionReference userCollection = Firestore.instance.collection("users");

  Future updateUserData(var data_map) async {
    return await userCollection.document(uid).setData(data_map);
  }
}