import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:karigari/db/user.dart';


class Auth{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Create custom user object
  User _userFromFirebaseUser(FirebaseUser user){
    return user !=null ? User(uid: user.uid) :null;
  }

  Stream<User> get user{
    return _firebaseAuth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }


  Future signInWithEmailAndPassword(String email, String Password) async {
    try {
      FirebaseUser user = (await _firebaseAuth
          .signInWithEmailAndPassword(email: email.trim(),
          password: Password.trim())).user;
      print('Signed in: ${user.uid}');
      //return user;
      return _userFromFirebaseUser(user);
    } catch(e){
      print("Error in AuthSignIn: " + e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password,Map data_map) async{
    try{

      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      print("User uid: " + user.uid);

      data_map.putIfAbsent("userId", () => user.uid);
      Firestore.instance.collection("users").add(data_map);

      return _userFromFirebaseUser(user);

    }catch(e){
      print("Sign up Unsuccessful "+e.toString());
      if (e.toString().contains("ERROR_EMAIL_ALREADY_IN_USE")){
        return "ERROR_EMAIL_ALREADY_IN_USE";
      }
      else{
      return null;
      }
    }
  }


  Future currentUser() async{
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future signOut() async {
    try {
      print("SIGNED OUT CALLED");
      return await _firebaseAuth.signOut();
    }catch(e){
        print("Error signing out: "+e.toString());
        return null;
    }
  }
}

/*
FirebaseUser user = await firebaseAuth.currentUser();


      if (user == null) {
        if(married=="Married") {
          firebaseAuth.createUserWithEmailAndPassword(
              email: _emailTextController.text,
              password: _passwordTextController.text)
              .then(
                (user) =>
                Firestore.instance.collection("users").add({
                  "firstName": _firstnameTextController.text,
                  "lastName": _lastnameTextController.text,
                  "email": _emailTextController.text,
                  "userId": user.user.uid,
                  "phone": int.parse(_phoneNumberController.text),
                  "gender": gender,
                  "username": "${_firstnameTextController.text}" + " " +
                      "${_lastnameTextController.text}",
                  "dateOfBirth": DateTime.parse("${_yearOfBirth.text}" + "-" + "${_monthOfBirth.text}" + "-" + "${_dateOfBirth.text}"),
                  "married":married,
                  "anniversary": DateTime.parse("${_yearOfMarriage.text}" + "-" + "${_monthOfMarriage.text}" + "-" + "${_dateOfMarriage.text}")
                }),
          ).catchError((err) => print(err.toString(),),
          );
        }else{
          firebaseAuth.createUserWithEmailAndPassword(
              email: _emailTextController.text,
              password: _passwordTextController.text)
              .then(
                (user) =>
                Firestore.instance.collection("users").add({
                  "firstName": _firstnameTextController.text,
                  "lastName": _lastnameTextController.text,
                  "email": _emailTextController.text,
                  "userId": user.user.uid,
                  "phone": int.parse(_phoneNumberController.text),
                  "gender": gender,
                  "username": "${_firstnameTextController.text}" + " " +
                      "${_lastnameTextController.text}",
                  "dateOfBirth": DateTime.parse("${_yearOfBirth.text}" + "-" + "${_monthOfBirth.text}" + "-" + "${_dateOfBirth.text}"),
                  "married":married,
                }),
          ).catchError((err) {
           print(err.toString());
             _error = err.toString();
          });
        }
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            ModalRoute.withName(HomePage().toString()));

      } else {
        print("already a user");
      }
 */

/*   Future registerWithEmailAndPassword(String email, String password,Map data_map) async{
    try{
      FirebaseUser user = await _firebaseAuth.currentUser();
      print("reached here ");
      print(user);
      print(user.uid);
      data_map.putIfAbsent("userId", () => user.uid);

      if (user == null) {
        await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password).then(
                (user) => Firestore.instance.collection("users").add(data_map)
        ).catchError((err)=>print(err.toString()));

        print("REGISTERED: "+user.uid);
        return _userFromFirebaseUser(user);
      }
      else{
        return user.uid;
      }

    }catch(e){
      print("Sign up Unsuccessful "+e.toString());
      return null;
    }
  }
*/