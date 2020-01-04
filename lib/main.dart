import 'package:flutter/material.dart';
import 'package:karigari/HomePage.dart';
import 'package:karigari/db/auth.dart';
import 'package:karigari/db/user.dart';
import 'package:karigari/pages/login.dart';
import 'package:karigari/wrapper.dart';
import 'package:provider/provider.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    StreamProvider<User>.value(
      value: Auth().user,

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.red.shade900
        ),
        home: new Wrapper(),
        //home: new HomePage(),
      ),
    )
  );
}


