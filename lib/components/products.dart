import 'package:flutter/material.dart';

import 'package:restaurant/pages/product_details.dart';
class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var product_list = [
    {
      "name":"French Fry",
      "picture":"images/snacks.jpg",
      "old_price":"15",
      "price":"10",
    },
    {
    "name":"Colds",
    "picture":"images/colds.jpg",
    "old_price":"8",
    "price":"6",
    },
    {
      "name":"Cake",
      "picture":"images/bakery.jpg",
      "old_price":"40",
      "price":"30",
    },
    {
      "name":"Coffee",
      "picture":"images/coffee.jpg",
      "old_price":"18",
      "price":"10",
    },{
      "name":"Chicken",
      "picture":"images/launch.jpg",
      "old_price":"8",
      "price":"6",
    }
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (BuildContext context,int index){
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Single_product(
          prod_name: product_list[index]['name'],
          prod_picture: product_list[index]['picture'],
          prod_old_price: product_list[index]['old_price'],
          prod_price: product_list[index]['price'],
        ),
      );
    });
  }
}

class Single_product extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_old_price;
  final prod_price;

  Single_product({
   this.prod_name,
    this.prod_picture,
    this.prod_old_price,
    this.prod_price,
});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: prod_name,
          child: Material(
            child: InkWell(
              onTap: ()=>Navigator.of(context).push(
                    new MaterialPageRoute(
                        builder: (context)=>new ProductDetails(
                          product_detail_name: prod_name,
                          product_detail_old_price: prod_price,
                          product_detail_new_price: prod_old_price,
                          product_detail_picture: prod_picture
                        ))),

              child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                      leading: Text(
                        prod_name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      title: Text("\$$prod_price",style: TextStyle(
                          color: Colors.red,fontWeight: FontWeight.w800),
                      ),
                      subtitle: Text(
                        "$prod_old_price",
                        style: TextStyle(
                          color: Colors.black54,
                          decoration: TextDecoration.lineThrough
                        ),
                      ),
                    ),
                  ),
                child: Image.asset(
                  prod_picture,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )),
    );
  }
}
