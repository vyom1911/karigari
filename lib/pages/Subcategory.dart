import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:karigari/pages/ProductList.dart';
import 'package:karigari/HomePage.dart';
import 'package:karigari/pages/cart.dart';
import 'package:provider/provider.dart';
import 'package:karigari/db/category_list.dart';

class Subcategory extends StatefulWidget {
  final String category ;
  final String id;

  Subcategory({this.category,this.id});
  @override
  _SubcategoryState createState() => _SubcategoryState();
}

class _SubcategoryState extends State<Subcategory> {

//  getSubcategoryList() async{
//    QuerySnapshot querySnapshot = await Firestore.instance.collection("categories").document(widget.id).collection("subcategories").getDocuments();
//    var list = querySnapshot.documents.map(f);
//    return list.;
//  }

  var product_list = [
    {
      "name": "Type 1",
      "picture": "images/subcategory/type1.jpeg",
    },
    {
      "name": "Type2",
      "picture": "images/subcategory/type2.jpeg",
    },
    {
    "name": "Type3",
    "picture": "images/subcategory/type3.jpeg",
    },
    {
    "name": "Type4",
    "picture": "images/subcategory/type4.jpeg",
    }
  ];


  @override
  Widget build(BuildContext context) {
    List<String> prod_test=[];
/*
    Firestore.instance.collection("categories").document(widget.id).collection("subcategories").getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) =>
          print((f.data.toString()))
      );
    });
*/



    return StreamBuilder(
      stream: Firestore.instance.collection("categories").document(widget.id).collection("subcategories").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
              child: Center(
                  child: Text("No Subcategories \n listed yet",
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
                      child: Text('Karigari')),
                ),
                actions: <Widget>[
                  new IconButton(icon: Icon(Icons.search, color: Colors.white),
                      onPressed: () {}),
                  new IconButton(
                      icon: Icon(Icons.shopping_cart, color: Colors.white),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => new Cart()));
                      })
                ],
              ),

              body: GridView.builder(
                  itemCount: snapshot.data.documents.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return Single_cat(
                      product_name: snapshot.data.documents[index]['subcat_name'],
                      prod_pictures: snapshot.data.documents[index]['subcat_picture'],
                      subcat_id:snapshot.data.documents[index].documentID,
                      cat_id: widget.id
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
  final prod_pictures;
  final subcat_id;
  final cat_id;

  Single_cat({
    this.product_name,
    this.prod_pictures,
    this.subcat_id,
    this.cat_id
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
                  new MaterialPageRoute(builder: (context) => new ProductList(subcat_id: subcat_id,cat_id:cat_id )
                  )),
              
              child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                      leading: Text(product_name,style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                    ),
                  ),
                  child: Image.asset(
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
