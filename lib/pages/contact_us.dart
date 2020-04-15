import 'package:flutter/material.dart';

class contact_us extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: Container(
          margin: const EdgeInsets.only(left: 75.0),
          child: InkWell( onTap: (){},
              child: Text('Contact Us')),
        ),
      ),

      body:  Column(children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded( //makes the red row full width
              child: Container(
                color: Colors.redAccent,
                height: 50.0,
                child: Center(
                  child: Text("The App is in Testing Mode", style: TextStyle(fontSize: 20.0, color: Colors.white,),
                  ),),),),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded( //makes the red row full width
              child: Container(
                height: 50.0,
                child: Center(
                  child: Text("", style: TextStyle(fontSize: 20.0,),
                  ),),),),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded( //makes the red row full width
              child: Container(
                height: 50.0,
                child: Center(
                  child: Text( "For Indore, Madhya Pradesh only", style: TextStyle(fontSize: 20.0,),
                  ),),),),
          ],//

        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded( //makes the red row full width
              child: Container(
                height: 50.0,
                child: Center(
                  child: Text("BIS Hallmark Certified Jewellery Only", style: TextStyle(fontSize: 20.0,),
                  ),),),),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded( //makes the red row full width
              child: Container(
                height: 50.0,
                child: Center(
                  child: Text("", style: TextStyle(fontSize: 20.0,),
                  ),),),),
          ],
        ),
        // This expands the row element vertically because it's inside a column
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // This makes the blue container full width.
              Expanded(
                child: Container(
                  color: Colors.blueAccent,
                  height: 50.0,
                  child: Center(
                    child: Text(
                      "For Orders Contact Us At:",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded( //makes the red row full width
              child: Container(
                margin: const EdgeInsets.only(top: 30.0,left: 10.0),
                height: 50.0,
                  child: Text("Karigari Jewels", style: TextStyle(fontSize: 20.0,),
                  ),),),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded( //makes the red row full width
              child: Container(
                margin: const EdgeInsets.only(left: 10.0),
                height: 50.0,
                child: Text("Prachal Neema: +919977006697 \njewelskarigari@gmail.com", style: TextStyle(fontSize: 20.0,),
                ),),),
          ],
        ),
      ]
      )
    );
  }
}
