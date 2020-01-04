import 'package:flutter/material.dart';
import 'package:karigari/pages/login.dart';
import 'package:karigari/pages/signup.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggleView(){
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Container(
        child: Login(toggleView: toggleView),
      );
    }else{
      return Container(
          child: SignUp(toggleView: toggleView)
      );
    }
  }
}
