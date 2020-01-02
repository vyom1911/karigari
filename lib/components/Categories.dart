import 'package:flutter/material.dart';
import 'package:karigari/pages/product_details.dart';
import 'package:karigari/pages/Subcategory.dart';
class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  var product_list = [
    {
      "name": "Bangle",
      "picture": "images/products/Bangles.jpeg",
    },
    {
      "name": "Ring",
      "picture": "images/products/Ring.png",
    }
  ];

  @override
  Widget build(BuildContext context) {

    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Padding( padding: const EdgeInsets.all(4.0),
            child: Single_prod(
              product_name: product_list[index]['name'],
              prod_pictures: product_list[index]['picture'],
            ),
          );
        }
    );
  }
}

class Single_prod extends StatelessWidget {
  final product_name;
  final prod_pictures;
  final prod_price;

  Single_prod({
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

              onTap: () => Navigator.of(context).push(
                  new MaterialPageRoute(builder: (context) => new Subcategory()
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
