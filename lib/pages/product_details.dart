import 'package:flutter/material.dart';
import 'package:karigari/HomePage.dart';
import 'package:karigari/pages/cart.dart';

class ProductDetails extends StatefulWidget {
  final product_detail_name;
  final product_detail_price;
  final product_detail_picture;

  ProductDetails({
    this.product_detail_name,
    this.product_detail_price,
    this.product_detail_picture
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
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

      body: new ListView(
        children: <Widget>[
          new Container(
            height: 300.0,
            child:  GridTile(
              child: Container(
                color: Colors.white,
                child: Image.asset(widget.product_detail_picture),
              ),
              footer: new Container(
                color: Colors.white,
                child: ListTile(
                  leading: new Text(widget.product_detail_name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                  title: new Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text("₹${widget.product_detail_price}",
                        style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

//           ================= The First Button =================
          Row(
            children: <Widget>[
//           ================= The Shape Button =================
              Expanded(
                child: MaterialButton(onPressed: (){},
                    color:Colors.white,
                    textColor: Colors.black,
                  child: Row(
                  children: <Widget>[
                    Expanded(
                      child: new Text("Shape",style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      child: new Icon(Icons.arrow_drop_down),
                    )
                  ],
                ),),
              ),

//           ================= The Size Button =================
              Expanded(
                child: MaterialButton(onPressed: (){},
                  color:Colors.white,
                  textColor: Colors.black,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text("Measure",style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        child: new Icon(Icons.arrow_drop_down),
                      )
                    ],
                  ),),
              ),

//           ================= The Weight Button =================
              Expanded(
                child: MaterialButton(onPressed: (){},
                  color:Colors.white,
                  textColor: Colors.black,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text("Weigh",style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        child: new Icon(Icons.arrow_drop_down),
                      )
                    ],
                  ),),
              ),

//           ================= The Qty Button =================
              Expanded(
                child: MaterialButton(onPressed: (){},
                  color:Colors.white,
                  textColor: Colors.black,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text("Qty",style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        child: new Icon(Icons.arrow_drop_down),
                      )
                    ],
                  ),),
              ),
            ],
          ),


//           ================= The First Button =================
          Row(
            children: <Widget>[
//           ================= The Size Button =================
              Expanded(
                child: MaterialButton(onPressed: (){},
                  color:Colors.red,
                  textColor: Colors.white,
                  child: new Text("Buy Now")
                ),
              ),

              new IconButton(icon:Icon(Icons.add_shopping_cart),color:Colors.red,onPressed: (){}),
              new IconButton(icon:Icon(Icons.favorite_border),color: Colors.red,onPressed: (){})
            ],
          ),
        Divider(),

          new ListTile(
            title: new Text("Product Details"),
              subtitle: new Text("Gold Bangles"),
          ),
          Divider(),
          new Row(children: <Widget>[
            Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
            child:  new Text("Product Name: ",style: TextStyle(color: Colors.grey),),),
            Padding(padding: EdgeInsets.all(5.0),
              child: new Text(widget.product_detail_name),)
          ],),

          new Row(children: <Widget>[
            Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
              child:  new Text("Product Brand: ",style: TextStyle(color: Colors.grey),),),
            Padding(padding: EdgeInsets.all(5.0),
              child: new Text("Brand X"),)
          ],),

          new Row(children: <Widget>[
            Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
              child:  new Text("Product Condition: ",style: TextStyle(color: Colors.grey),),),
            Padding(padding: EdgeInsets.all(5.0),
              child: new Text("Brand New"),)
          ],),

          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text("Similar Products"),
          ),
          // SIMILAR PRODUCTS SECTION
          Container(
            height: 360.0,
              child: Similar_products(),
          )
        ],
      ),
    );
  }
}

class Similar_products extends StatefulWidget {
  @override
  _Similar_productsState createState() => _Similar_productsState();
}

class _Similar_productsState extends State<Similar_products> {
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


        body: GridView.builder(
            itemCount: product_list.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return Similar_Single_cat(
                product_name: product_list[index]['name'],
                prod_pictures: product_list[index]['picture'],
                prod_price: product_list[index]['price'],
              );
            }
        )
    );
  }
}

class Similar_Single_cat extends StatelessWidget {
  final product_name;
  final prod_pictures;
  final prod_price;

  Similar_Single_cat({
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