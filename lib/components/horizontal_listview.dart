import 'package:flutter/material.dart';


class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
        Category(
          image_location: 'images/cats/launch.jpg',
          image_caption: 'Launch',
        ),
        Category(
          image_location: 'images/cats/snacks.jpg',
          image_caption: 'Snacks',
        ),
        Category(
          image_location: 'images/cats/bakery.jpg',
          image_caption: 'Bakery',
        ),
        Category(
          image_location: 'images/cats/coffee.jpg',
          image_caption: 'Coffee',
        ),
        Category(
          image_location: 'images/cats/colds.jpg',
          image_caption: 'Colds',
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
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: (){},
        child: Container(
          width: 100.0,
          child: ListTile(
            title: Image.asset(image_location,
              width: 40.0,
              height: 40.0),
            subtitle: Text(image_caption,textAlign: TextAlign.center,),
          ),
        ),
      ),
    );
  }
}
