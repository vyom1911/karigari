import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth{
  Future<String> signInWithEmailAndPassword(String email, String Password);
}

class Auth implements BaseAuth{
  Future<String> signInWithEmailAndPassword(String email, String Password) async{
    FirebaseUser user = (await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.trim(),
        password: Password.trim())).user;
    print('Signed in: ${user.uid}');
    return user.uid;
  }
}