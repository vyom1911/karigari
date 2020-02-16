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
                          product_code: snapshot.data.documents[index]['product_code'],
                          description: snapshot.data.documents[index]['description'],
                          metal_type: snapshot.data.documents[index]['metal_type'],
                          metal_color: snapshot.data.documents[index]['metal_color'],
                          gender: snapshot.data.documents[index]['gender'],
                          brand: snapshot.data.documents[index]['brand'],
                          gold_purity: snapshot.data.documents[index]['gold_purity'],
                          silver_purity: snapshot.data.documents[index]['silver_purity'],
                          platinum_purity: snapshot.data.documents[index]['platinum_purity'],
                          size: snapshot.data.documents[index]['size'],
                          stone_presence: snapshot.data.documents[index]['stone_presence'],
                          stone_weight: snapshot.data.documents[index]['stone_weight'],
                          diamond_weight: snapshot.data.documents[index]['diamond_weight'],
                          gross_weight: snapshot.data.documents[index]['gross_weight'],
                          net_weight: snapshot.data.documents[index]['net_weight'],
                          stone_cost: snapshot.data.documents[index]['stone_cost'],
                          diamond_presence: snapshot.data.documents[index]['diamond_presence'],
                          diamond_carat: snapshot.data.documents[index]['diamond_carat'],
                          diamond_clarity: snapshot.data.documents[index]['diamond_clarity'],
                          diamond_color: snapshot.data.documents[index]['diamond_color'],
                          diamond_cost: snapshot.data.documents[index]['diamond_cost'],
                          wastage_percent: snapshot.data.documents[index]['wastage_percent'],
                          other_charges: snapshot.data.documents[index]['other_charges'],
                          discount: snapshot.data.documents[index]['discount'],
                          userId: widget.userid
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
  final String userId;
  final product_code;
  final description;
  final metal_type;
  final metal_color;
  final gender;
  final brand;
  final gold_purity;
  final silver_purity;
  final platinum_purity;
  final size;
  final stone_presence;
  final stone_weight;
  final diamond_weight;
  final gross_weight;
  final net_weight;
  final stone_cost;
  final diamond_presence;
  final diamond_carat;
  final diamond_clarity;
  final diamond_color;
  final diamond_cost;
  final wastage_percent;
  final other_charges;
  final discount;

  Single_cat({
    this.product_name,
    this.prod_pictures,
    this.userId,
    this.product_code,
    this.description,
    this.metal_type,
    this.metal_color,
    this.gender,
    this.brand,
    this.gold_purity,
    this.silver_purity,
    this.platinum_purity,
    this.size,
    this.stone_presence,
    this.stone_weight,
    this.diamond_weight,
    this.gross_weight,
    this.net_weight,
    this.stone_cost,
    this.diamond_presence,
    this.diamond_carat,
    this.diamond_clarity,
    this.diamond_color,
    this.diamond_cost,
    this.wastage_percent,
    this.other_charges,
    this.discount,
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
                      product_detail_picture: prod_pictures,
                      userId:userId,
                      product_code: product_code,
                      description: description,
                      metal_type: metal_type,
                      metal_color: metal_color,
                      gender: gender,
                      brand: brand,
                      gold_purity: gold_purity,
                      silver_purity: silver_purity,
                      platinum_purity: platinum_purity,
                      size: size,
                      stone_presence: stone_presence,
                      stone_weight: stone_weight,
                      diamond_weight: diamond_weight,
                      gross_weight: gross_weight,
                      net_weight: net_weight,
                      stone_cost: stone_cost,
                      diamond_presence: diamond_presence,
                      diamond_carat: diamond_carat,
                      diamond_clarity: diamond_clarity,
                      diamond_color: diamond_color,
                      diamond_cost: diamond_cost,
                      wastage_percent: wastage_percent,
                      other_charges: other_charges,
                      discount: discount
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
