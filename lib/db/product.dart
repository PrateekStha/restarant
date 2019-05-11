import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ProductService {
  Firestore _firestore = Firestore.instance;
  String ref = 'products';
  //create category
  //String productName, String brand, String category,int quantity,int price, List Sizes,String image
  void uploadProduct(String imageUrl, String productName, String category,
      String brand, int quantity, int price, List Sizes) {
    var id = Uuid();
    String productId = id.v1();
    _firestore.collection(ref).document(productId).setData({
      imageUrl: 'imageUrl',
      'id': productId,
      'image': imageUrl,
      'name': productName,
      'category': category,
      'brand': brand,
      'price': price,
      'quantity': quantity,
      'sizes': Sizes,
    });
  }

  void updateProduct(docId, String imageUrl, String productName,String category, String brand, int quantity, int price, List Sizes) {
    _firestore.collection(ref).document(docId).updateData({
      'id': docId,
      'image': imageUrl,
      'name': productName,
      'category': category,
      'brand': brand,
      'price': price,
      'quantity': quantity,
      'sizes': Sizes,
    });
  }

  void deleteProduct(docId) {
    Firestore.instance.collection(ref).document(docId).delete().catchError((e) {
      print(e);
    });
  }

  Future<List<DocumentSnapshot>> getProducts() {
    return _firestore.collection(ref).getDocuments().then((snaps) {
      return snaps.documents;
    });
  }

  Future<List<DocumentSnapshot>> getSuggestions(String suggestion) => _firestore
          .collection(ref)
          .where('product', isEqualTo: suggestion)
          .getDocuments()
          .then((snap) {
        return snap.documents;
      });
}
