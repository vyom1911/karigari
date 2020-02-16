import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:karigari/components/loading.dart';
import 'package:karigari/components/loading_in_app.dart';
import 'package:karigari/pages/ProductList.dart';
import 'package:karigari/HomePage.dart';
import 'package:karigari/pages/cart.dart';


class Subcategory extends StatefulWidget {
  final String category ;
  final String id;
  final String userId;

  Subcategory({this.category,this.id,this.userId});
  @override
  _SubcategoryState createState() => _SubcategoryState();
}

class _SubcategoryState extends State<Subcategory> {

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


    return StreamBuilder(
      stream: Firestore.instance.collection("categories").document(widget.id).collection("subcategories").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {

          return LoadingInApp();
        }
        else {
          return Scaffold(
              appBar: new AppBar(
                elevation: 0.1,
                backgroundColor: Colors.red,
                title: Center(
                  child: InkWell(onTap: () {},
                      child: Text('Subcategories')),
                ),
                actions: <Widget>[
                  new IconButton(icon: Icon(Icons.search, color: Colors.white),
                      onPressed: () {}),
                  new IconButton(
                      icon: Icon(Icons.shopping_cart, color: Colors.white),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => new Cart(userId: widget.userId)));
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
                      cat_id: widget.id,
                      userId: widget.userId,
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
  final subcat_id;
  final cat_id;
  final String userId;

  Single_cat({
    this.product_name,
    this.prod_pictures,
    this.subcat_id,
    this.cat_id,
    this.userId
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
                  new MaterialPageRoute(builder: (context) => new ProductList(subcat_id: subcat_id,cat_id:cat_id,userId:userId )
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
