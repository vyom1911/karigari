import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//my imports
import 'package:karigari/HomePage.dart';
import 'package:karigari/components/cart_products.dart';
class Cart extends StatefulWidget {
  final String userId;
  Cart({this.userId});
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  var _alertReady=true;
  void _showDialog(String title,String content) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(content,style: TextStyle(fontSize: 20),),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: new Text("Cart"),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.search, color:Colors.white), onPressed: (){}),
        ],
      ),

      body: new Cart_products(userId: widget.userId),

      bottomNavigationBar: StreamBuilder(
        stream: Firestore.instance.collection("users").document(widget.userId).collection("cart").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(child: ListTile(
                    title: new Text("Total:"),
                    subtitle: new Text("₹0"),
                  ),),

                  Expanded(
                      child: new MaterialButton(onPressed: (){
                        _showDialog("Check Out", "Not Items to Checkout!");
                      },
                          child: new Text("Check out",style: TextStyle(color: Colors.white),),
                          color: Colors.red)
                  )
                ],
              ),
            );
          }
          else{
            var Total = 0;
            snapshot.data.documents.forEach((doc)=> Total+=doc["product_price"]);

            return new Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(child: ListTile(
                    title: new Text("Total:"),
                    subtitle: new Text("₹"+Total.toString()),
                  ),),

                  Expanded(
                    child: new MaterialButton(onPressed: (){
                      snapshot.data.documents.forEach((doc) =>
                      Firestore.instance.collection("users").document(widget.userId).collection("Orders")
                          .document(doc["product_name"].toString()).setData({
                        "status":"In_Progress",
                        "product_name": doc["product_name"],
                        "product_picture":doc["product_picture"],
                        "product_price":doc["product_price"],
                      })
                      );
                      _showDialog("Check Out", "Your Order Is Placed!");
                      print("ADDED Cart products to orders");
                      snapshot.data.documents.forEach((doc) =>
                          Firestore.instance.collection("users").document(widget.userId).collection("cart")
                          .document(doc["product_name"]).delete());
                    },
                        child: new Text("Check out",style: TextStyle(color: Colors.white),),
                        color: Colors.red)
                  )
                ],
              ),
            );
          }
        }
      ),
    );
  }
}
