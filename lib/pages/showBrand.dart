import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant/db/brand.dart';
class showBrand extends StatefulWidget {
  @override
  _showBrandState createState() => _showBrandState();
}

class _showBrandState extends State<showBrand> {
    TextEditingController brandController = TextEditingController();
  GlobalKey<FormState> _brandFormKey = GlobalKey();
  BrandService _brandService = BrandService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List Of brands '),
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: new StreamBuilder(
            stream: Firestore.instance.collection('brands').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return new Text('Loading...');
              return new ListView(
                children: snapshot.data.documents.map<Widget>((document) {
                  return new ListTile(
                    title: new Text(document['brand']),
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
                                        _brandService.deleteBrand(document['id']);
                                        Navigator.pop(context);
                                      },
                                      )
                                  ]
                                  )
                              );
                          });
                        },
                        onTap: (){
                          _updatebrandAlert(document['id'],document['brand']);
                        },


                  );
                }).toList(),
              );
            },
          ),
        ));
  }

  //bandAlert

    void _updatebrandAlert(docId,String docBrand){
    var alert = new AlertDialog(
      content: Form(
        key:  _brandFormKey,
        child: TextFormField(
          controller: brandController,
          validator: (value){
            if(value.isEmpty){
              return 'brand cannot be empty';
            }
          },
          decoration: InputDecoration(
            hintText: docBrand
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: (){
             if(brandController.text != null){
              _brandService.updateBrand(brandController.text,docId);
            }
            Fluttertoast.showToast(msg: 'Brand Updated');
            Navigator.pop(context);
          },
          child: Text('Edit'),
        ),
        FlatButton(
          onPressed: (){
            Navigator.pop(context);
          },
         child : Text('Cancel'),
        )
      ],
    );
    showDialog(context: context, builder: (_)=> alert);
  }


}
