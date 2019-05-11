import 'package:flutter/material.dart';

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  var Products_on_cart = [
    {
      "name":"French Fry",
      "picture":"images/snacks.jpg",
      "price":"10",
      "size":"M",
      "color":"Red",
      "quantity":1
    },
    {
      "name":"Chicken",
      "picture":"images/launch.jpg",
      "price":"15",
      "size":"M",
      "color":"White",
      "quantity":1
    },
    {
      "name":"Colds",
      "picture":"images/colds.jpg",
      "price":"10",
      "size":"M",
      "color":"white",
      "quantity":1
    },
  ];
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: Products_on_cart.length,
      itemBuilder: (context,index){
        return Single_cart_product(
          cart_prod_name: Products_on_cart[index]["name"],
          cart_prod_picture: Products_on_cart[index]["picture"],
          cart_prod_price: Products_on_cart[index]["price"],
          cart_prod_size: Products_on_cart[index]["size"],
          cart_prod_color: Products_on_cart[index]["color"],
          cart_prod_quantity: Products_on_cart[index]["quantity"],
        );
      }
    );
  }
}

class Single_cart_product extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_price;
  final cart_prod_size;
  final cart_prod_color;
  final cart_prod_quantity;
  Single_cart_product({
    this.cart_prod_name,
    this.cart_prod_picture,
    this.cart_prod_price,
    this.cart_prod_size,
    this.cart_prod_color,
    this.cart_prod_quantity
});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(

        //Leading section of image//
        leading: new Image.asset(cart_prod_picture,width:80.0,height: 80.0,),
        //title of producat//
        title: new Text(cart_prod_name),
        //colums for this
        subtitle: new Column(
          children: <Widget>[
           new Row(
             children: <Widget>[
               // size in row
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: new Text("Size :"),
               ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: new Text(cart_prod_size),
               ),

               //color in row
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: new Text("Color :"),
               ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: new Text(cart_prod_color),
               ),
             ],
           ),
            
            //this section is for product price
            new Container(
              alignment: Alignment.topLeft,
              child: new Text("\$$cart_prod_price",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold ),),
            )
          ],
        ),
//        trailing: new Column(
//          children: <Widget>[
//            new IconButton(icon: Icon(Icons.arrow_drop_up), onPressed: (){}),
//            new Text("\ $cart_prod_quantity"),
//            new IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: (){})
//          ],
//        ),
      ),
    );

  }

}

