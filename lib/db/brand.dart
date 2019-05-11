import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class BrandService {
  Firestore _firestore = Firestore.instance;
  String ref = 'brands';
  void createBrand(String name) {
    var id = Uuid();
    String brandId = id.v1();
    _firestore
        .collection(ref)
        .document(brandId)
        .setData({'id': brandId, 'brand': name});
  }

  void updateBrand(String name, docId) {
    _firestore
        .collection(ref)
        .document(docId)
        .updateData({'id': docId, 'brand': name});
  }

  void deleteBrand(docId) {
    Firestore.instance
        .collection(ref)
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }


  Future<List<DocumentSnapshot>> getBrands(){
    return _firestore.collection(ref).getDocuments().then((snaps){
      return snaps.documents;
    });
  }
}
