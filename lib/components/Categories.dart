import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:karigari/db/category_list.dart';
import 'package:karigari/pages/Subcategory.dart';
import 'package:provider/provider.dart';

class Category extends StatefulWidget {
  final String userId;
  Category({this.userId});
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  Uint8List imageFile;
  StorageReference pictureReference =  FirebaseStorage.instance.ref().child("categories");

  getImage(image_name) async{
    var url = pictureReference.child(image_name).getDownloadURL();
    print(url.toString());
    return url.toString();
  }

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<List<Category_List>>(context);
    return GridView.builder(
        itemCount: categories.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Padding( padding: const EdgeInsets.all(4.0),
            child: Single_prod(
              product_name: categories[index].name,
              prod_pictures: categories[index].picture,// getImage(categories[index].picture),
              product_id: categories[index].id,
              userId: widget.userId,
            ),
          );
        }
    );
  }
}

class Single_prod extends StatelessWidget {
  final product_name;
  String prod_pictures;
  final product_id;
  final String userId;

  Single_prod({
    this.product_name,
    this.prod_pictures,
    this.product_id,
    this.userId
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(tag: product_name,
          child: Material(
            child: InkWell(
              //On tap opens product description, change later to product sub category

              onTap: () => Navigator.of(context).push(
                  new MaterialPageRoute(builder: (context) => new Subcategory(category: product_name,id:product_id,userId: userId,)
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
                   //"images/products/Bangles.jpeg",
                   fit: BoxFit.contain,
                  )
                ),
              ),
        ),
      )
    );
  }
}
