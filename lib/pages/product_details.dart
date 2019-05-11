import 'package:flutter/material.dart';
import 'package:restaurant/pages/home.dart';
class ProductDetails extends StatefulWidget {
  final product_detail_name;
  final product_detail_new_price;
  final product_detail_old_price;
  final product_detail_picture;

  ProductDetails({
    this.product_detail_name,
    this.product_detail_new_price,
    this.product_detail_old_price,
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
        elevation: 0.0,
        backgroundColor: Colors.red,
        title: InkWell(
          onTap: (){Navigator.push(context,MaterialPageRoute(
              builder: (context)=>new HomePage()));},
          child: Text('Restaurant'),
        ),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.search,color: Colors.white,),
              onPressed: (){}
          ),
          new IconButton(
              icon: Icon(Icons.restaurant,color: Colors.white,),
              onPressed: (){}
          ),
        ],
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            height: 300.0,
            child: GridTile(
              child:Container(
                color: Colors.white,

                child: Image.asset(widget.product_detail_picture),


              ),
              footer: new Container(
              color: Colors.amber,
                child: ListTile(
                  leading: new Text(widget.product_detail_name,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),),
                  title: new Row(
                    children: <Widget>[
                      Expanded(
                      child:new Text("\$${widget.product_detail_old_price}",
                      style: TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough),),

                ),
                      Expanded(
                      child:new Text("\$${widget.product_detail_new_price}",
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),)
                      ),
                        ],
                  ),
                ),
            ),
          ),
          ),

          //----first button-----
          Row(
            children: <Widget>[
              //size button
              Expanded(
                child: MaterialButton(onPressed: (){
                  showDialog(context: context,
                  builder: (context){
                    return new AlertDialog(
                      title: new Text("Size"),
                      content: new Text("Choose the size"),
                      actions: <Widget>[
                        new MaterialButton(onPressed: (){
                          Navigator.of(context).pop(context);
                        },
                        child: new Text("Close"),)
                      ],
                    );
                  }
                  );
                },
                color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text("Size"),
                      ),
                      Expanded(
                        child: new Icon(Icons.arrow_drop_down),
                      ),

                    ],
                  ),
              ),
              ),
              Expanded(
                child: MaterialButton(onPressed: (){
                  showDialog(context: context,
                      builder: (context){
                        return new AlertDialog(
                          title: new Text("Color"),
                          content: new Text("Choose the color"),
                          actions: <Widget>[
                            new MaterialButton(onPressed: (){
                              Navigator.of(context).pop(context);
                            },
                              child: new Text("Close"),)
                          ],
                        );
                      }
                  );
                },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text("Color"),
                      ),
                      Expanded(
                        child: new Icon(Icons.arrow_drop_down),
                      ),

                    ],
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(onPressed: (){
                  showDialog(context: context,
                      builder: (context){
                        return new AlertDialog(
                          title: new Text("Quantity"),
                          content: new Text("Choose the quantity"),
                          actions: <Widget>[
                            new MaterialButton(onPressed: (){
                              Navigator.of(context).pop(context);
                            },
                              child: new Text("Close"),)
                          ],
                        );
                      }
                  );
                },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text("Quantity",style: TextStyle(fontSize: 13),),
                      ),
                      Expanded(
                        child: new Icon(Icons.arrow_drop_down),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
      Row(
        children: <Widget>[
          //size button
          Expanded(
            child: MaterialButton(onPressed: (){},
              color: Colors.red,
              textColor: Colors.grey,
              elevation: 0.2,
              child: new Text("Buy now",style: TextStyle(color: Colors.white),)
            ),
          ),
          new IconButton(icon: Icon(Icons.add_shopping_cart,color: Colors.red,), onPressed: (){}),
          new IconButton(icon: Icon(Icons.favorite_border,color: Colors.red,), onPressed: (){})
        ],
      ),
          Divider(),
          new ListTile(
            title: new Text("Product details"),
            subtitle: new Text("lorem ipsomlorem ipsomlorem ipsomlorem ipsomlorem ipsomlorem ipsomlorem ipsomlorem ipsomlorem ipsomlorem ipsomlorem ipsom"),
          ),
          Divider(),
          new Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
              child: new Text("Product Name",style: TextStyle(color: Colors.grey),),
              ),
              Padding(padding: EdgeInsets.all(5.0),
              child: new Text(widget.product_detail_name),)
            ],
          ),
          new Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text("Product Brand",style: TextStyle(color: Colors.grey),),
              ),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text(widget.product_detail_name),)
            ],
          ),
          new Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text("Product Condition",style: TextStyle(color: Colors.grey),),)
            ],
          ),
          //similar product
          Divider(),
        Padding(
          padding: EdgeInsets.all(8.0),
          child:new Text("Similar Product"),
        ),
        //similar product part
        Container(
          height: 340.0,
          child: Similar_Products(),
        )

      ],
      ),
    );
  }
}

class Similar_Products extends StatefulWidget {
  @override
  Similar_ProductsState createState() => Similar_ProductsState();
}

class Similar_ProductsState extends State<Similar_Products> {
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
    }

  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (BuildContext context,int index){
          return Similar_Single_product(
            prod_name: product_list[index]['name'],
            prod_picture: product_list[index]['picture'],
            prod_old_price: product_list[index]['old_price'],
            prod_price: product_list[index]['price'],
          );
        });
  }
}


class Similar_Single_product extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_old_price;
  final prod_price;

  Similar_Single_product({
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
              onTap: () =>
                  Navigator.of(context).push(
                      new MaterialPageRoute(
                          builder: (context) =>
                          new ProductDetails(
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
                    title: Text("\$$prod_price", style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w800),
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