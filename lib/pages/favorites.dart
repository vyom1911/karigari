import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:karigari/pages/ProductList.dart';
import 'package:karigari/HomePage.dart';
import 'package:karigari/pages/cart.dart';
import 'package:karigari/pages/product_details.dart';


class Favorite extends StatefulWidget {

  final userid;
  Favorite({this.userid});
  @override
  _SubcategoryState createState() => _SubcategoryState();
}

class _SubcategoryState extends State<Favorite> {




  @override
  Widget build(BuildContext context) {
    List<String> prod_test=[];


    return StreamBuilder(
        stream:  Firestore.instance.collection("users").document(widget.userid).collection("favorites").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
                child: Center(
                    child: Text("No Favorites \n listed yet",
                      style: TextStyle(fontSize: 30.0),)
                )
            );
          }
          else {
            return Scaffold(
                appBar: new AppBar(
                  elevation: 0.1,
                  backgroundColor: Colors.red,
                  title: Center(
                    child: InkWell(onTap: () {},
                        child: Text('Favorites')),
                  ),
                  actions: <Widget>[
                    new IconButton(icon: Icon(Icons.search, color: Colors.white),
                        onPressed: () {}),
                    new IconButton(
                        icon: Icon(Icons.shopping_cart, color: Colors.white),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => new Cart(userId: widget.userid,)));
                        })
                  ],
                ),

                body: GridView.builder(
                    itemCount: snapshot.data.documents.length,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                      return Single_cat(
                          product_name: snapshot.data.documents[index]['product_name'],
                          prod_pictures: snapshot.data.documents[index]['product_picture'],
                          prod_price:snapshot.data.documents[index]["product_price"]
                      );
                    }
                )
            );
          }
        }
    );
  }
}

class Single_cat extends StatelessWidget {
  final product_name;
  String prod_pictures;
  final prod_price;

  Single_cat({
    this.product_name,
    this.prod_pictures,
    this.prod_price
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Hero(tag: product_name,
          child: Material(
            child: InkWell(
              //On tap opens product description, change later to product sub category
//              onTap: () => Navigator.of(context).push(
//                  new MaterialPageRoute(builder: (context) => new ProductDetails(
//                    product_detail_name: product_name,
//                      product_detail_price: prod_price,
//                      product_detail_picture: prod_pictures,
//                  ))),
              onTap: () => Navigator.of(context).push(
                  new MaterialPageRoute(builder: (context) => new ProductDetails(
                    product_detail_name: product_name,
                    product_detail_price: prod_price,
                    product_detail_picture: prod_pictures,
                  )
                  )),

              child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                      leading: Text(product_name,style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                    ),
                  ),
                  child: Image.network(
                    prod_pictures,
                    fit: BoxFit.contain,
                  )
              ),
            ),
          ),
        )
    );
  }
}
