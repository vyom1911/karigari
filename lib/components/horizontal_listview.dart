import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
          image_location: 'images/cats/accessories.png',
          image_caption: 'necklace'
          ),

          Category(
              image_location: 'images/cats/accessories.png',
              image_caption: 'ring'
          ),

          Category(
              image_location: 'images/cats/accessories.png',
              image_caption: 'bracelets'
          ),

          Category(
              image_location: 'images/cats/accessories.png',
              image_caption: 'blah'
          ),

          Category(
              image_location: 'images/cats/accessories.png',
              image_caption: 'blah2'
          ),

          Category(
              image_location: 'images/cats/accessories.png',
              image_caption: 'blah3'
          ),

          Category(
              image_location: 'images/cats/accessories.png',
              image_caption: 'blah4'
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Category({
    this.image_location,
    this.image_caption
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(2.0),
      child: InkWell(onTap: () {},
          child: Container(
            width: 100.0,
            child: ListTile(
              title: Image.asset(image_location, width: 100.0, height: 80.0),
              subtitle: Container( alignment: Alignment.topCenter,
                  child: Text(image_caption)),
            ),
          )
      ),
    );
  }
}
