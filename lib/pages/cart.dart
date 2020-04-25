import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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



//  gmail(String user,String body){
//    var options = new GmailSmtpOptions()
//      ..username = 'xyz@gmail.com'
//      ..password = 'adgzf'; // Note: if you have Google's "app specific passwords" enabled,
//    // you need to use one of those here.
//
//    // How you use and store passwords is up to you. Beware of storing passwords in plain.
//
//    // Create our email transport.
//    var emailTransport = new SmtpTransport(options);
//
//    // Create our mail/envelope.
//    var envelope = new Envelope()
//      ..from = 'karigariapp@gmail.com'
//      ..recipients.add('prachalneema123@gmail.com')
//      ..ccRecipients.add('karigariapp@gmail.com')
//      ..bccRecipients.add('vyomshrivastava2@gmail.com')
//      ..subject = 'New order from $user'
//      ..text = body
//      ..html = '<h1>Test</h1><p>Hey!</p>';
//
//    // Email it.
//    emailTransport.send(envelope)
//        .then((envelope) => print('Email sent!'))
//        .catchError((e) => print('Error occurred: $e'));
//  }


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
            double Total = 0.0;
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
//                      var items='';

//                      snapshot.data.documents.forEach((doc) =>
//                      items+="\n" + doc["product_name"]
//                      );
//                      Firestore.instance.collection("users").document(widget.userId).get().then((doc) =>
//                          gmail(doc.data["username"],
//                            'Hello Prachal, \n User '+ doc.data["username"] + 'has ordered the following items: $items',
//                          )
//                      );

//                      gmail("TEST",
//                        'Hello Prachal, \n User has ordered the following items: $items',
//                      );

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
