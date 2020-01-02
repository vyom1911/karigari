import 'package:flutter/material.dart';
import 'package:karigari/pages/product_details.dart';
import 'package:karigari/HomePage.dart';
import 'package:karigari/pages/cart.dart';
class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  var product_list = [
    {
      "name": "product 1",
      "picture": "images/products/bg1.jpeg",
      "price": 1000
    },
    {
      "name": "Product 2",
      "picture": "images/products/bg2.jpeg",
      "price": 2000
    },
    {
      "name": "Product 3",
      "picture": "images/products/bg3.jpeg",
      "price": 5000
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          elevation: 0.1,
          backgroundColor: Colors.red,
          title: Center(
            child: InkWell( onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> new HomePage()));},
                child: Text('Karigari')),
          ),
          actions: <Widget>[
            new IconButton(icon: Icon(Icons.search, color:Colors.white), onPressed: (){}),
            new IconButton(icon: Icon(Icons.shopping_cart, color:Colors.white), onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>new Cart()));
            })
          ],
        ),

        body: GridView.builder(
            itemCount: product_list.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return Single_cat(
                product_name: product_list[index]['name'],
                prod_pictures: product_list[index]['picture'],
                prod_price: product_list[index]['price'],
              );
            }
        )
    );
  }
}

class Single_cat extends StatelessWidget {
  final product_name;
  final prod_pictures;
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
              onTap: () => Navigator.of(context).push(
                  new MaterialPageRoute(builder: (context) => new ProductDetails(
                    product_detail_name: product_name,
                      product_detail_price: prod_price,
                      product_detail_picture: prod_pictures,
                  ))),

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