import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:restaurant/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// self made package
import 'package:restaurant/components/horizontal_listview.dart';
import 'package:restaurant/components/products.dart';
import 'package:restaurant/pages/cart.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  HomePage({this.user, this.googleSignIn});
  final FirebaseUser user ;
  final GoogleSignIn googleSignIn ;
@override
_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget imagecarousel = new Container(
      height: 200.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/launch.jpg'),
          AssetImage('images/bakery.jpg'),
          AssetImage('images/coffee.jpg'),
          AssetImage('images/snacks.jpg'),
          AssetImage('images/colds.jpg'),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
        dotBgColor: Colors.transparent,
      ),
    );

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.red,
        title: Text('Chunky '),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.search,color: Colors.white,),
              onPressed: (){}
          ),
          new IconButton(
              icon: Icon(Icons.shopping_basket,color: Colors.white,),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new Cart()));
              }
          ),
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            //        //header
            new UserAccountsDrawerHeader(
              accountName: Text(widget.user.displayName),
              accountEmail: Text(widget.user.email),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(widget.user.photoUrl),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.red
              ),
            ),
            //        //body
            InkWell(
              onTap: (){} ,
              child: ListTile(
                title: Text('HomePage'),
                leading: Icon(
                  Icons.home,color: Colors.red,
                ),
              ),
            ),
            InkWell(
              onTap: (){} ,
              child: ListTile(
                title: Text('My Account'),
                leading: Icon(
                  Icons.person,color: Colors.red,
                ),
              ),
            ),
            InkWell(
              onTap: (){} ,
              child: ListTile(
                title: Text('My Orders'),
                leading: Icon(
                  Icons.restaurant,color: Colors.red,
                ),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new Cart()));
              } ,
              child: ListTile(
                title: Text('Cart'),
                leading: Icon(
                  Icons.shopping_basket,color: Colors.red,
                ),
              ),
            ),
            InkWell(
              onTap: (){} ,
              child: ListTile(
                title: Text('Favourite'),
                leading: Icon(
                  Icons.favorite,color: Colors.red,
                ),
              ),
            ),
            Divider(),
            InkWell(
              onTap: (){} ,
              child: ListTile(
                title: Text('Settings'),
                leading: Icon(
                  Icons.settings,color: Colors.black,
                ),
              ),
            ),
            InkWell(
              onTap: (){
                FirebaseAuth.instance.signOut().then((value){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                  Fluttertoast.showToast(msg: "Logout Successful")
                  ;
                });
              },
              child: ListTile(
                title: Text('Log Out'),
                leading: Icon(
                  Icons.transit_enterexit,color: Colors.blue,
                ),
                
              ),
            ),


          ],
        ),
      ),
      body: new Column(
        children: <Widget>[
          //image carousel
          imagecarousel,

          //padding widget
          new Padding(padding: const EdgeInsets.all(8.0),
            child: new Text('Categories',textAlign: TextAlign.center,),
          ),

          //horizontal list view
          HorizontalList(),

          //Todays Dish
          new Padding(padding: const EdgeInsets.all(20.0),
              child: new Text('Foods',textAlign: TextAlign.center,)
          ),

          //grid view
          Flexible(child: Products(),)

        ],
      ),
    );
  }
}

