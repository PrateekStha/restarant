import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import '../db/brand.dart';
import '../db/category.dart';
import '../db/product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:restaurant/pages/admin.dart';
class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  //services for database
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  ProductService _productService = ProductService();

  //color assigning to variable
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  //form
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController ProductNameController = TextEditingController();
  TextEditingController QuantityController = TextEditingController();
  TextEditingController PriceController = TextEditingController();

  //Assigning other variable
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];
  String _currentCategory;
  String _currentBrand;
  List<String> selectedSizes = <String>[];
  List<String> choose = <String>['S', 'L', 'XL'];
  File _image;

  @override
  void initState() {
    _getCategories();
    _getBrands();
  }

  List<DropdownMenuItem<String>> getCategoriesDropDown() {
    List<DropdownMenuItem<String>> items = new List();
    for (DocumentSnapshot category in categories) {
      items.add(new DropdownMenuItem(
        child: Text(category['category']),
        value: category['category'],
      ));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getBrandsDropDown() {
    List<DropdownMenuItem<String>> items = new List();
    for (DocumentSnapshot brand in brands) {
      items.add(new DropdownMenuItem(
        child: Text(brand['brand']),
        value: brand['brand'],
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.close,color:Colors.red),
        ),
        title: Text(
          "Add Product",
          style: TextStyle(color: Colors.green,),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlineButton(
                    borderSide:
                        BorderSide(color: grey.withOpacity(0.8), width: 1.0),
                    onPressed: () {
                      _selectImage(
                          ImagePicker.pickImage(source: ImageSource.gallery));
                    },
                    child: _displayImage(),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Upload Product Image',
                style: TextStyle(color: black),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: ProductNameController,
                decoration: InputDecoration(
                  hintText: 'Product name',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'You must Enter the Product name';
                  } else if (value.length > 10) {
                    return 'no value more than 10 can enter';
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButton(
                  items: getCategoriesDropDown(),
                  value: _currentCategory,
                  hint: Text('Select Category'),
                  onChanged: (value) {
                    setState(() {
                      _currentCategory = value;
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                ),
                DropdownButton(
                  items: getBrandsDropDown(),
                  value: _currentBrand,
                  hint: Text('Select Brand'),
                  onChanged: (value) {
                    setState(() {
                      _currentBrand = value;
                    });
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: QuantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Quantity',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'You must Enter the Quantity';
                  } else if (value.length > 10) {
                    return 'no value more than 10 can enter';
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: PriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Price',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'You must Enter the Price';
                  } else if (value.length > 10) {
                    return 'no value more than 10 can enter';
                  }
                },
              ),
            ),
            Row(
              children: <Widget>[
                Checkbox(
                    value: selectedSizes.contains('S'),
                    onChanged: (value) => changeSelectedSize('S')),
                Text('S'),
                Checkbox(
                    value: selectedSizes.contains('L'),
                    onChanged: (value) => changeSelectedSize('L')),
                Text('L'),
                Checkbox(
                    value: selectedSizes.contains('XL'),
                    onChanged: (value) => changeSelectedSize('XL')),
                Text('XL'),
              ],
            ),
            RaisedButton(
              child: Text('Add Product',style: TextStyle(color: Colors.white),),
              color: Colors.green,
              onPressed: () {
                validateAndUpload();
              },
            )
          ],
        ),
      ),
    );
  }

  _getCategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    setState(() {
      categories = data;
    });
  }

  _getBrands() async {
    List<DocumentSnapshot> data = await _brandService.getBrands();
    setState(() {
      brands = data;
    });
  }

  void changeSelectedSize(String size) {
    if (selectedSizes.contains(size)) {
      setState(() {
        selectedSizes.remove(size);
      });
    } else {
      setState(() {
        selectedSizes.add(size);
      });
    }
  }

  void _selectImage(Future<File> pickImage) async {
    File tempImg = await pickImage;
    _image = tempImg;
  }

  Widget _displayImage() {
    if (_image == null) {
      return Padding(
        padding: const EdgeInsets.all(40.0),
        child: Icon(Icons.add, color: grey),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(40.0),
        child: Image.file(_image),
      );
    }
  }
  void validateAndUpload()async{
    if(_formKey.currentState.validate()){
      if(_image != null){
          if(selectedSizes.isNotEmpty){
            String imageUrl;
            
            final FirebaseStorage storage = FirebaseStorage.instance;
            final String picture = "${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
            StorageUploadTask task = storage.ref().child(picture).putFile(_image);
            Fluttertoast.showToast(msg: 'Product check');
            StorageTaskSnapshot snapshot1 = await task.onComplete.then((snapshot)=>snapshot);
            task.onComplete.then((snapshot1) async{
                imageUrl = await snapshot1.ref.getDownloadURL();
                _productService.uploadProduct(imageUrl,ProductNameController.text,_currentCategory,_currentBrand,int.parse(QuantityController.text),int.parse(PriceController.text),selectedSizes);
                _formKey.currentState.reset();
                Navigator.pop(context);
                Fluttertoast.showToast(msg: 'Product Added');
            });
          }else{
            Fluttertoast.showToast(msg: 'select any one sizes');
          }
      }else{
        Fluttertoast.showToast(msg: 'Please Select the image');
      }
    }
  }
}
