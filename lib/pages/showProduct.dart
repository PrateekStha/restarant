import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant/db/product.dart';
import 'package:restaurant/padmin/update_product.dart';

class showProduct extends StatefulWidget {
  @override
  _showProductState createState() => _showProductState();
}

class _showProductState extends State<showProduct> {
  ProductService _productService  = ProductService();
  TextEditingController productController = TextEditingController();
  GlobalKey<FormState> _productFormKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('List Of Products '),
       ),
       body:Container(
            padding: const EdgeInsets.all(10.0),
            child: new StreamBuilder(
      stream: Firestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return new ListView  (
          children: snapshot.data.documents.map<Widget>((document) {
            return new ListTile(
              leading: new Image.network(document['image'],width:80.0,height: 50.0,fit: BoxFit.cover,),
              
              title: new Text("Name : "+document['name']),
              subtitle: new Text("Category : "+ document['category']+"  "+" Brand : "+document['brand']),
              
              onLongPress: () {
        showModalBottomSheet<void>(context: context,
            builder: (BuildContext context) {
                return Container(
                    child: new Wrap(
                    children: <Widget>[
                        new ListTile(
                        leading: new Icon(Icons.delete),
                        title: new Text('Delete'),
                        onTap: (){
                          print('deleted');
                          _productService.deleteProduct(document['id']);
                          Navigator.pop(context);
                        },
                        )
                    ]
                    )
                );
            });
              },
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>UpdateProduct(updateId:document['id'])));
                          //_updatebrandAlert(document['id'],document['brand']);
                       
                        },

              
            );
          }).toList(),
          
        );
        
      },
    ),
     )
     );
  }



}