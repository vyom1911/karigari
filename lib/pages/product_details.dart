import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:karigari/HomePage.dart';
import 'package:karigari/db/user.dart';
import 'package:karigari/pages/cart.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {

  final product_detail_name;
  String product_detail_picture;
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


  ProductDetails({
    this.product_detail_name,
    this.product_detail_picture,
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
    this.discount
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  User current_user;

  bool _notFavorite = false;
  bool _inCart = false;

  double gold_rate = 4100;
  double silver_rate = 48.5;
  double platinum_rate = 12400;
  double metal_rate =0;
  double gst =3.0;


  void _handleFavoriteChange(bool newValue) {
    setState(() {
      _notFavorite = newValue;
    });
  }

  void _handleCartChange(bool newValue) {
    setState(() {
      _inCart = newValue;
    });
  }



  @override
  Widget build(BuildContext context) {

    Firestore.instance.collection("rates").document("gold")
        .get().then((doc) {
      if(doc.exists){
        if(this.mounted) {
          setState(() {
            gold_rate = doc.data["rate"].toDouble();
          });
        }
      }
    });

    Firestore.instance.collection("rates").document("silver")
        .get().then((doc) {
      if(doc.exists){
        if(this.mounted) {
          setState(() {
            silver_rate = doc.data["rate"].toDouble();
          });
        }
      }
    });

    Firestore.instance.collection("rates").document("platinum")
        .get().then((doc) {
      if(doc.exists){
        if(this.mounted) {
          setState(() {
            platinum_rate = doc.data["rate"].toDouble();
          });
        }
      }
    });

    Firestore.instance.collection("rates").document("gst")
        .get().then((doc) {
      if(doc.exists){
        if(this.mounted) {
          setState(() {
            gst = doc.data["rate"].toDouble();
          });
        }
      }
    });

    if (widget.metal_type.toLowerCase() == "silver"){
      metal_rate=gold_rate;
    }
    else if (widget.metal_type.toLowerCase() == "platinum"){
      metal_rate=gold_rate;
    }
    else{
      metal_rate=gold_rate;
    }
    double gross_price  = metal_rate*widget.gross_weight + widget.stone_cost + widget.diamond_cost + widget.other_charges ;
    double net_price =  gross_price*(gst/100) + gross_price - gross_price*(widget.discount/100);

    current_user = Provider.of<User>(context);
    //checking if collection favorites exists
    Firestore.instance.collection("users").document(current_user.uid).collection("favorites").getDocuments().
    then((sub) => {
      if (sub.documents.length > 0) {
        //checking if the product is in favorites or not
            Firestore.instance.collection("users").document(current_user.uid).collection("favorites")
        .document(widget.product_detail_name.toString())
        .get().then((doc) {
          if(doc.exists){
            // if product not in favorite then set _notFavorite to false else true
            if(doc.data['favorite'] == null){
              if(this.mounted) {
                setState(() {
                  _notFavorite = false;
                });
              }
          }
            else{
              if(this.mounted){
              setState(() {
                _notFavorite=true;
              });
                }
              }
          }
          else{
            print("ITEM NOT IN FAVORITES");
          }
        }
        )
      }
    });

    Firestore.instance.collection("users").document(current_user.uid).collection("cart").getDocuments().
    then((sub) => {
      if (sub.documents.length > 0) {
        //checking if the product is in favorites or not
        Firestore.instance.collection("users").document(current_user.uid).collection("cart")
            .document(widget.product_detail_name.toString())
            .get().then((doc) {
          if(doc.exists) {
            // if product in cart then set _inCart to false else true
            if (this.mounted) {
              setState(() {
                _inCart = true;
              });
            }
          }
            else{
              if(this.mounted){
                setState(() {
                  _inCart=false;
                });
              }
            }
         })
      }
    });


    return WillPopScope(
      onWillPop: () async =>false,
      child: Scaffold(
        appBar: new AppBar(
          elevation: 0.1,
          backgroundColor: Colors.red,
          title: Center(
            child: InkWell( onTap: (){},
                child: Text('Product Details')),
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

        body: new ListView(
          children: <Widget>[
            new Container(
              height: 300.0,
              child:  GridTile(
                child: Container(
                  color: Colors.white,
                  child: Image.network(widget.product_detail_picture),
                ),
                footer: new Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: new Text(widget.product_detail_name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                    title: new Row(
                      children: <Widget>[
                        Expanded(
                          child: new Text("₹${net_price}",
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
//           ================= The Size Button =================
                Expanded(
                  flex:3,
                  child: MaterialButton(onPressed: (){
                    Firestore.instance.collection("users").document(current_user.uid).collection("cart")
                        .document(widget.product_detail_name.toString()).setData({
                      "product_name":widget.product_detail_name,
                      "product_picture":widget.product_detail_picture,
                      "net_price":net_price,
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>new Cart(userId: current_user.uid)));},
                    color:Colors.red,
                    textColor: Colors.white,
                    child: new Text("Buy Now")
                  ),
                ),
//           ================= The Qty Button =================
                Expanded(
                  flex:1,
                  child: MaterialButton(onPressed: (){},
                  color:Colors.white,
                  textColor: Colors.black,
                    child: Row(
                  children: <Widget>[
                      Expanded(
                        child: new Text("Qty",style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),),
                        ),
                      Expanded(
                        child: new Icon(Icons.arrow_drop_down),
                      )
                    ],
                  ),),
                  ),
//            ================= The Cart Button =================
                CartIcon(inCart: _inCart,onChangedCart: _handleCartChange
                    ,uid: current_user.uid,product_detail_name: widget.product_detail_name,
                    product_detail_picture: widget.product_detail_picture ,
                    product_detail_price: net_price),

//            ================= The Favorite Button =================
                FavoriteIcon(notFavorite: _notFavorite,onChanged: _handleFavoriteChange
                ,uid: current_user.uid,product_detail_name: widget.product_detail_name,
                  product_detail_picture: widget.product_detail_picture ,
                  product_code: widget.product_code,
                  description: widget.description,
                  metal_type: widget.metal_type,
                  metal_color: widget.metal_color,
                  gender: widget.gender,
                  brand: widget.brand,
                  gold_purity: widget.gold_purity,
                  silver_purity: widget.silver_purity,
                  platinum_purity: widget.platinum_purity,
                  size: widget.size,
                  stone_presence: widget.stone_presence,
                  stone_weight: widget.stone_weight,
                  diamond_weight: widget.diamond_weight,
                  gross_weight: widget.gross_weight,
                  net_weight: widget.net_weight,
                  stone_cost: widget.stone_cost,
                  diamond_presence: widget.diamond_presence,
                  diamond_carat: widget.diamond_carat,
                  diamond_clarity: widget.diamond_clarity,
                  diamond_color: widget.diamond_color,
                  diamond_cost: widget.diamond_cost,
                  wastage_percent: widget.wastage_percent,
                  other_charges: widget.other_charges,
                  discount: widget.discount,)

              ],
            ),
          Divider(),

            new ListTile(
              title: new Text("Product Details"),
                subtitle: new Text(widget.description),
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
                child: new Text(widget.brand),)
            ],),

            new Row(children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child:  new Text("Metal Type: ",style: TextStyle(color: Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text(widget.metal_type),)
            ],),

            new Row(children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child:  new Text("Metal Color: ",style: TextStyle(color: Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text(widget.metal_color),)
            ],),

            widget.gold_purity!=0 ? new Row(children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child:  new Text("Gold Purity: ",style: TextStyle(color: Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text("${widget.gold_purity}"),)
            ],) : new Container(),

            widget.silver_purity!=0 ? new Row(children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child:  new Text("Silver Purity: ",style: TextStyle(color: Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text("${widget.silver_purity}"),)
            ],) : new Container(),

            widget.platinum_purity!=0 ? new Row(children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child:  new Text("Platinum Purity: ",style: TextStyle(color: Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text("${widget.platinum_purity}"),)
            ],) : new Container(),

            new Row(children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child:  new Text("Size: ",style: TextStyle(color: Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text(widget.size.toString()),)
            ],),

            new Row(children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child:  new Text("Gross Weight: ",style: TextStyle(color: Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text("${widget.gross_weight} grams"))
            ],),

            new Row(children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child:  new Text("Stone Presence: ",style: TextStyle(color: Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
                
                child: widget.stone_presence==1 ?new Text("Yes") : new  Text("No"),)
            ],),

            widget.stone_weight!=0 ? new Row(children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child:  new Text("Stone Weight: ",style: TextStyle(color: Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text("${widget.stone_weight} grams"),)
            ],) : new Container(),

            widget.stone_cost!=0 ? new Row(children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child:  new Text("Stone Weight: ",style: TextStyle(color: Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text("${widget.stone_cost} grams"),)
            ],) : new Container(),

            new Row(children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child:  new Text("Diamond Presence: ",style: TextStyle(color: Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),

                child: widget.diamond_presence==1 ?new Text("Yes") : new  Text("No"),)
            ],),

            widget.diamond_carat!=0 ? new Row(children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child:  new Text("Diamond Carat: ",style: TextStyle(color: Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text("${widget.diamond_carat}"),)
            ],) : new Container(),

            widget.diamond_clarity!=0 ? new Row(children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child:  new Text("Diamond Carat: ",style: TextStyle(color: Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text("${widget.diamond_clarity}"),)
            ],) : new Container(),

            widget.diamond_color!=0 ? new Row(children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child:  new Text("Diamond Carat: ",style: TextStyle(color: Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text("${widget.diamond_color}"),)
            ],) : new Container(),

            widget.diamond_weight!=0 ? new Row(children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child:  new Text("Diamond Carat: ",style: TextStyle(color: Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text("${widget.diamond_weight}"),)
            ],) : new Container(),

            widget.diamond_cost!=0 ? new Row(children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child:  new Text("Diamond Carat: ",style: TextStyle(color: Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text("${widget.diamond_cost}"),)
            ],) : new Container(),

            new Row(children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child:  new Text("Wastage Percent: ",style: TextStyle(color: Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
                  child: new Text("${widget.wastage_percent}%"))
            ],),

            new Row(children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child:  new Text("Other Charges: ",style: TextStyle(color: Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
                  child: new Text("₹${widget.other_charges}"))
            ],),

            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text("Price Description"),
            ),

            widget.discount!=0 ? new Row(children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child:  new Text("Diamond Carat: ",style: TextStyle(color: Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text("${widget.discount}"),)
            ],) : new Container(),

            new Row(children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child:  new Text("Gross Price: ",style: TextStyle(color: Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
                  child: new Text("₹${gross_price}"))
            ],),

            new Row(children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child:  new Text("Net Price: ",style: TextStyle(color: Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
                  child: new Text("₹${net_price}"))
            ],),

            Divider(),
// ===== COMMENTED OUT SIMILAR PRODUCT WIDGET, TO BE ADDED LATER =====
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: new Text("Similar Products"),
//            ),
//            // SIMILAR PRODUCTS SECTION
//            Container(
//              height: 360.0,
//                child: Similar_products(),
//            )
          ],
        ),
      ),
    );
  }

}

//class Similar_products extends StatefulWidget {
//  @override
//  _Similar_productsState createState() => _Similar_productsState();
//}
//
//class _Similar_productsState extends State<Similar_products> {
//  var product_list = [
//    {
//      "name": "product 1",
//      "picture": "images/products/bg1.jpeg",
//      "price": 1000
//    },
//    {
//      "name": "Product 2",
//      "picture": "images/products/bg2.jpeg",
//      "price": 2000
//    },
//    {
//      "name": "Product 3",
//      "picture": "images/products/bg3.jpeg",
//      "price": 5000
//    }
//  ];
//  @override
//  Widget build(BuildContext context) {
//
//    return Scaffold(
//
//
//        body: GridView.builder(
//            itemCount: product_list.length,
//            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//                crossAxisCount: 2),
//            itemBuilder: (BuildContext context, int index) {
//              return Similar_Single_cat(
//                product_name: product_list[index]['name'],
//                prod_pictures: product_list[index]['picture'],
//                net_price: product_list[index]['price'],
//              );
//            }
//        )
//    );
//  }
//}
//
//class Similar_Single_cat extends StatelessWidget {
//  final product_name;
//  final prod_pictures;
//  final net_price;
//
//  Similar_Single_cat({
//    this.product_name,
//    this.prod_pictures,
//    this.net_price
//  });
//
//  @override
//  Widget build(BuildContext context) {
//    return Card(
//        child: Hero(tag: product_name,
//          child: Material(
//            child: InkWell(
//              //On tap opens product description, change later to product sub category
//              onTap: () => Navigator.of(context).push(
//                  new MaterialPageRoute(builder: (context) => new ProductDetails(
//                    product_detail_name: product_name,
//                    net_price:  net_price,
//                    product_detail_picture: prod_pictures,
//                  ))),
//
//              child: GridTile(
//                  footer: Container(
//                    color: Colors.white70,
//                    child: ListTile(
//                      leading: Text(product_name,style: TextStyle(fontWeight: FontWeight.bold),
//                      ),
//
//                    ),
//                  ),
//                  child: Image.asset(
//                    prod_pictures,
//                    fit: BoxFit.contain,
//                  )
//              ),
//            ),
//          ),
//        )
//    );
//  }
//}

class FavoriteIcon extends StatelessWidget {
  FavoriteIcon({Key key, this.notFavorite: false,this.uid,this.product_detail_name,
    this.product_detail_picture,this.product_code,
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
  this.discount, @required this.onChanged})
      : super(key: key);

  final product_detail_name;
  String product_detail_picture;
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
  final String uid;
  final bool notFavorite;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!notFavorite);
  }

  Widget build(BuildContext context) {

    return IconButton(
        icon:notFavorite ? Icon(Icons.favorite,color: Colors.red) : Icon(Icons.favorite_border,color: Colors.red),
        onPressed: (){ _handleTap();
        if(!notFavorite){
          Firestore.instance.collection("users").document(uid).collection("favorites")
              .document(product_detail_name.toString()).setData({
            "product_name":product_detail_name,
            "product_picture":product_detail_picture,
            "product_code": product_code,
            "description": description,
            "metal_type": metal_type,
            "metal_color": metal_color,
            "gender": gender,
            "brand": brand,
            "gold_purity": gold_purity,
            "silver_purity": silver_purity,
            "platinum_purity": platinum_purity,
            "size": size,
            "stone_presence": stone_presence,
            "stone_weight": stone_weight,
            "diamond_weight": diamond_weight,
            "gross_weight": gross_weight,
            "net_weight": net_weight,
            "stone_cost": stone_cost,
            "diamond_presence": diamond_presence,
            "diamond_carat": diamond_carat,
            "diamond_clarity": diamond_clarity,
            "diamond_color": diamond_color,
            "diamond_cost": diamond_cost,
            "wastage_percent": wastage_percent,
            "other_charges": other_charges,
            "discount": discount,
            "favorite":true
          });
          print("Fav added");

        }else{
          try{
            Firestore.instance.collection("users").document(uid).collection("favorites")
                .document(product_detail_name.toString()).delete();
            print("Fav deleted");
          }
          catch(e) {
            print(e.toString());
          }
        }
        });
  }
}

class CartIcon extends StatelessWidget {
  CartIcon({Key key, this.inCart: false,this.uid,this.product_detail_name,
    this.product_detail_picture,this.product_detail_price, @required this.onChangedCart})
      : super(key: key);

  final  product_detail_name;
  final  product_detail_picture;
  final  product_detail_price;
  final String uid;
  final bool inCart;
  final ValueChanged<bool> onChangedCart;

  void _handleCartTap() {
    onChangedCart(!inCart);
  }

  Widget build(BuildContext context) {

    return IconButton(
        icon:inCart ? Icon(Icons.remove_shopping_cart,color: Colors.red) : Icon(Icons.add_shopping_cart,color: Colors.red),
        onPressed: (){ _handleCartTap();
        if(!inCart){
          Firestore.instance.collection("users").document(uid).collection("cart")
              .document(product_detail_name.toString()).setData({
            "product_name":product_detail_name,
            "product_picture":product_detail_picture,
            "product_price":product_detail_price,
          });
          print("Added To Cart!");

        }else{
          try{
            Firestore.instance.collection("users").document(uid).collection("cart")
                .document(product_detail_name.toString()).delete();
            print("Deleted From Cart");
          }
          catch(e) {
            print(e.toString());
          }
        }
        });
  }
}