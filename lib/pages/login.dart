import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant/pages/home.dart';
import 'package:restaurant/pages/signup.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:restaurant/pages/admin.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
//creating object
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  SharedPreferences preferences;
  bool loading = false;
  bool isLogedin = false;
  bool hidePass = true;
  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    setState(() {
      loading = true;
    });
    await firebaseAuth.currentUser().then((user){
        if(user!= null){
          setState(() {
           isLogedin = true; 
          });
        }
    });

    preferences = await SharedPreferences.getInstance();
    isLogedin = await googleSignIn.isSignedIn();

    if (isLogedin) {
     //   Navigator.pushReplacement(
      //       context, MaterialPageRoute(builder: (context) => HomePage()));
    }

    setState(() {
      loading = false;
    });
  }

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();

    setState(() {
      loading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final FirebaseUser firebaseUser =
        await firebaseAuth.signInWithCredential(credential);

    if (firebaseUser != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection("users")
          .where("id", isEqualTo: firebaseUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;

      if (documents.length == 0) {
//          insert the user to our collection
        Firestore.instance
            .collection("users")
            .document(firebaseUser.uid)
            .setData({
          "id": firebaseUser.uid,
          "username": firebaseUser.displayName,
          "profilePicture": firebaseUser.photoUrl
        });

        await preferences.setString("id", firebaseUser.uid);
        await preferences.setString("username", firebaseUser.displayName);
        await preferences.setString("photoUrl", firebaseUser.displayName);
      } else {
        await preferences.setString("id", documents[0]['id']);
        await preferences.setString("username", documents[0]['username']);
        await preferences.setString("photoUrl", documents[0]['photoUrl']);
      }

      Fluttertoast.showToast(msg: "Login was successful");
      
      setState(() {
        loading = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage(user: firebaseUser,googleSignIn:googleSignIn)));
    } else {
      Fluttertoast.showToast(msg: "Login failed :(");
    }
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height / 3;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'images/launch.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
//TODO:: make the logo show

          Container(
            color: Colors.black.withOpacity(0.8),
            width: double.infinity,
            height: double.infinity,
          ),

          Container(
              height: 300,
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'images/m2.jpg',
                height: 150,
              )),

          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 300.0),
              child: Center(
                child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white.withOpacity(0.4),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: TextFormField(
                                controller: _emailTextController,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  icon: Icon(Icons.alternate_email),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    Pattern pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regex = new RegExp(pattern);
                                    if (!regex.hasMatch(value))
                                      return 'Please make sure your email address is valid';
                                    else
                                      return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white.withOpacity(0.4),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: ListTile(
                                title: TextFormField(
                                  controller: _passwordTextController,
                                  obscureText: hidePass,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    icon: Icon(Icons.vpn_key),
                                    
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "The password field cannot be empty";
                                    } else if (value.length < 6) {
                                      return "the password has to be at least 6 characters long";
                                    }
                                    return null;
                                  },
                                ),
                                
                                trailing: IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  onPressed: () {
                                    setState(() {
                                      hidePass = false;
                                    });
                                  }),
                              ),
                              
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.red.shade700,
                              elevation: 0.0,
                              child: MaterialButton(
                                onPressed: () {
                                   FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text)
                        .then((FirebaseUser user) {
                          Fluttertoast.showToast(msg: "Loign Successful");
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                    }).catchError((e) {
                      print(e.message);
                      Fluttertoast.showToast(msg: "Username and password mismatch");
                    });
                                },
                                minWidth: MediaQuery.of(context).size.width,
                                child: Text(
                                  "Login",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              )),
                        ),
                        RaisedButton(
                            padding:
                                const EdgeInsets.only(left: 50.0, right: 50.0),
                            color: Colors.transparent,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.0,
                                        decoration: TextDecoration.underline),
                                    children: [
                                  TextSpan(text: "Register your Account"),
                                ]))),
                        Divider(
                          color: Colors.white,
                        ),
                        GoogleSignInButton(
                          onPressed: () {
                            handleSignIn();
                          },
                        ),
                       FacebookSignInButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Admin()));
                          }
                        ),
                      ],
                    )),
              ),
            ),
          ),

          Visibility(
            visible: loading ?? true,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.9),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
