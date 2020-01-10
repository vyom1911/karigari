import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//my imports
import 'package:karigari/HomePage.dart';
import 'package:karigari/pages/cart.dart';
class MyOrders extends StatefulWidget {
  final String userId;
  MyOrders({this.userId});
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: Center(
          child: InkWell( onTap: (){},
              child: Text('My Orders')),
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.search, color:Colors.white), onPressed: (){}),
          new IconButton(icon: Icon(Icons.shopping_cart, color:Colors.white), onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>new Cart(userId: widget.userId,)));
          })
        ],
      ),

      body: StreamBuilder(
          stream:  Firestore.instance.collection("users").document(widget.userId).collection("Orders").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                  child: Center(
                      child: Text("No Orders available",
                        style: TextStyle(fontSize: 30.0),)
                  )
              );
            }else{
              return new ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context,index){
                    return Single_order(
                      prod_name: snapshot.data.documents[index]["product_name"],
                      prod_price: snapshot.data.documents[index]["product_price"],
                      prod_color: "Golden",
                      prod_picture: snapshot.data.documents[index]["product_picture"],
                      prod_status: snapshot.data.documents[index]["status"],
                      prod_qty: 1,
                    );
                  });
            }
          }
      ),
    );
  }
}

class Single_order extends StatelessWidget {
  final prod_name;
  final prod_price;
  final prod_color;
  final prod_picture;
  final prod_status;
  final prod_qty;

  Single_order({
    this.prod_name,
    this.prod_price,
    this.prod_color,
    this.prod_picture,
    this.prod_status,
    this.prod_qty
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        // ================ Leading Section ================
        leading: new Image.network(prod_picture,width: 80.0,height: 80.0),
        //  ================ Title Section ================
        title: new Text(prod_name),
        // ================ Substitle Sections ================
        subtitle: new Column(
          children: <Widget>[
            // ROW INSIDE COLUMN
            new Row(
              children: <Widget>[
                // ============= THIS SECTION IS FOR SIZE =============
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: new Text("Status:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new Text(prod_status,style: TextStyle(color: Colors.red)
                  ),
                ),

                // ============= THIS SECTION IS FOR Color =============
//                Padding(padding: const EdgeInsets.fromLTRB(10.0, 8.0, 8.0, 8.0),
//                    child: new Text("Color:")),
//                Padding(
//                  padding: const EdgeInsets.all(4.0),
//                  child: new Text(prod_color,style: TextStyle(color: Colors.red),
//                  ),
//                ),
                // ============= THIS SECTION IS FOR Price =============

              ],
            ),
            new Container(
              alignment: Alignment.topLeft,
              child: new Text("₹${prod_price}", style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold,
                  color: Colors.red),),
            )
          ],
        ),
        trailing: FittedBox(
          fit: BoxFit.fill,
          child: new Column(
            children: <Widget>[
              new IconButton(icon: Icon(Icons.arrow_drop_up),iconSize: 100.0,onPressed: (){}),
              new Text("${prod_qty}", style: TextStyle(fontSize: 60),),
              new IconButton(icon: Icon(Icons.arrow_drop_down),iconSize: 100.0, onPressed: (){} )
            ],
          ),
        ),
      ),

    );
  }
}
