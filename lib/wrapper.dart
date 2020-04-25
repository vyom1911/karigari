import 'package:flutter/material.dart';
import 'package:karigari/HomePage.dart';
import 'package:karigari/db/authenticate.dart';
import 'package:karigari/db/database.dart';
import 'package:karigari/db/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    if(user==null){
      return Authenticate();
    }
    else{
      return StreamProvider<UserData>.value(
          value: DatabaseService(uid: user.uid).userData,
          child: HomePage()
      );
    }
  }
}
