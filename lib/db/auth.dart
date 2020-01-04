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