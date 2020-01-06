import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:karigari/components/Categories.dart';
import 'package:karigari/db/auth.dart';
import 'package:karigari/db/category_list.dart';
import 'package:karigari/db/database.dart';
import 'package:karigari/pages/cart.dart';
import 'package:karigari/db/user.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Auth _auth =Auth();
  User current_user;
  Map user_details;
  UserData userData;



  @override
  Widget build(BuildContext context) {
    //get current user and data first

    current_user = Provider.of<User>(context);
    userData = Provider.of<UserData>(context);


    //Build the page
    Widget image_carousel = new Container(
      height: 400.0,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/c1.jpeg'),
          AssetImage('images/m1.jpeg'),
          AssetImage('images/w3.jpeg'),
          AssetImage('images/w4.jpeg'),
          AssetImage('images/m3.jpeg'),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 6.0,
        indicatorBgPadding: 6.0,
      ),
    );

    return Scaffold(
        appBar: new AppBar(
          elevation: 0.1,
          backgroundColor: Colors.red,
          title: Center(child: Text('Karigari')),
          actions: <Widget>[
            new IconButton(icon: Icon(Icons.search, color:Colors.white), onPressed: (){}),
            new IconButton(icon: Icon(Icons.shopping_cart, color:Colors.white), onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>new Cart()));
            })
          ],
        ),
        //Drawer begins here
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              //header
              new UserAccountsDrawerHeader(
                accountName: Text(userData.username),
                accountEmail: Text(userData.email),
                currentAccountPicture: GestureDetector(
                    child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person,color: Colors.white,)
                    )
                ),
                decoration: BoxDecoration(
                    color: Colors.red
                ),
              ),
              // body

              InkWell(
                onTap:(){},
                child: ListTile(
                  title: Text('Home Page'),
                  leading: Icon(Icons.home),
                ),
              ),

              InkWell(
                onTap:(){},
                child: ListTile(
                  title: Text('My Account'),
                  leading: Icon(Icons.home),
                ),
              ),

              InkWell(
                onTap:(){},
                child: ListTile(
                  title: Text('My Orders'),
                  leading: Icon(Icons.shopping_basket),
                ),
              ),


              InkWell(
                onTap:(){},
                child: ListTile(
                  title: Text('Favorites'),
                  leading: Icon(Icons.favorite),
                ),
              ),

              Divider(),

              InkWell(
                onTap:(){},
                child: ListTile(
                  title: Text('Settings'),
                  leading: Icon(Icons.settings),
                ),
              ),

              InkWell(
                onTap:(){},
                child: ListTile(
                  title: Text('About'),
                  leading: Icon(Icons.help),
                ),
              ),
              Divider(),

              InkWell(
                onTap: () async {
                  print("Signout");

                 await _auth.signOut();
                //widget._signOut();
                },
                child: ListTile(
                  title: Text('Log out'),
                  leading: Icon(Icons.transit_enterexit, color: Colors.grey,),
                ),
              ),
            ],
          ),
        ),

        body:
        new Column(
          children: <Widget>[
            //image carousel begins here
            image_carousel,

            //Padding_widget
            new Padding(padding: const EdgeInsets.all(20.0),
              child: Center(
                  child: Text('Categories',
                      style: TextStyle(fontWeight: FontWeight.w800,fontSize: 20)
                  )
              )
            ),

            //Horizontal list view begins here
           // HorizontalList()

            //Grid View
            Flexible(
              //height: 320.0,
              child: StreamProvider<List<Category_List>>.value(
                  value:DatabaseService().categories,
                  child: Category()
              )
              ,
            )
          ],
        ),
      );

  }

}