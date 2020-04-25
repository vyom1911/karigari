import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Cart_products extends StatefulWidget {
  final String userId;
  Cart_products({this.userId});
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:  Firestore.instance.collection("users").document(widget.userId).collection("cart").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
              child: Center(
                  child: Text("No Items in Cart yet",
                    style: TextStyle(fontSize: 30.0),)
              )
          );
        }else{
          return new ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context,index){
            return Single_cart_product(
                cart_prod_name: snapshot.data.documents[index]["product_name"],
                cart_prod_price: snapshot.data.documents[index]["product_price"],
                cart_prod_color: "Golden",
                cart_prod_picture: snapshot.data.documents[index]["product_picture"],
                cart_prod_size: "M",
                cart_prod_qty: 1,
            );
          });
        }
      }
    );
  }
}

class Single_cart_product extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_price;
  final cart_prod_picture;
  final cart_prod_size;
  final cart_prod_color;
  final cart_prod_qty;

  Single_cart_product({
    this.cart_prod_name,
    this.cart_prod_picture,
    this.cart_prod_price,
    this.cart_prod_size,
    this.cart_prod_color,
    this.cart_prod_qty
});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        // ================ Leading Section ================
        leading: new Image.network(cart_prod_picture,width: 80.0,height: 80.0),
        //  ================ Title Section ================
      title: new Text(cart_prod_name),
        // ================ Substitle Sections ================
        subtitle: new Column(
          children: <Widget>[
            // ROW INSIDE COLUMN
            new Row(
              children: <Widget>[
                // ============= THIS SECTION IS FOR SIZE =============
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: new Text("Size:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new Text(cart_prod_size,style: TextStyle(color: Colors.red)
                  ),
                ),

                // ============= THIS SECTION IS FOR Color =============
                Padding(padding: const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                child: new Text("Color:")),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new Text(cart_prod_color,style: TextStyle(color: Colors.red),
                  ),
                ),
                // ============= THIS SECTION IS FOR Price =============

              ],
            ),
            new Container(
              alignment: Alignment.topLeft,
              child: new Text("₹${cart_prod_price}", style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold,
                  color: Colors.red),),
            )
          ],
        ),
        trailing: FittedBox(
          fit: BoxFit.fill,
          child: new Column(
            children: <Widget>[
              new IconButton(icon: Icon(Icons.arrow_drop_up),iconSize: 100.0,onPressed: (){}),
              new Text("${cart_prod_qty}", style: TextStyle(fontSize: 60),),
              new IconButton(icon: Icon(Icons.arrow_drop_down),iconSize: 100.0, onPressed: (){} )
            ],
          ),
        ),
      ),

    );
  }
}

