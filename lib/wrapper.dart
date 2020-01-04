import 'package:karigari/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:karigari/db/authenticate.dart';
import 'package:karigari/pages/login.dart';
import 'package:provider/provider.dart';
import 'package:karigari/db/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    if(user==null){
      return Authenticate();
    }
    else{
      return HomePage();
    }
  }
}
