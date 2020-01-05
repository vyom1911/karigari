import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karigari/db/category_list.dart';
import 'package:karigari/db/user.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});
  final CollectionReference userCollection = Firestore.instance.collection("users");
  final CollectionReference categoryCollection = Firestore.instance.collection("categories");

  //Add user data to firestore database
  Future updateUserData(var data_map) async {
    return await userCollection.document(uid).setData(data_map);
  }

  //Userdata from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      username: snapshot.data["username"],
      email: snapshot.data["email"],
      firstName: snapshot.data["firstName"]
    );
  }

  //Get specific user doc
  Stream<UserData> get userData{
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  //Get Category Stream
  Stream<List<Category_List>> get categories{
    return categoryCollection.snapshots().map(_categoryListFromSnapshot);
  }
  // Category List from Snapshot
  List<Category_List> _categoryListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Category_List(
        name: doc.data["cat_name"] ?? 'CATEGORY_NAME_NOT_FOUND',
        picture: doc.data["cat_picture"] ?? 'images/cats/accessories.png'
      );
    }).toList();
  }

}