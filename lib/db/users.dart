import 'package:firebase_database/firebase_database.dart';
class UserServices{
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String ref = "users";

  createUser(Map value){
    String name = value["username"];
    _database.reference().child(ref).child(name).set(
      value
    ).catchError((e) => { print(e.toString())});
  }
}