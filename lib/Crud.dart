import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods {

  Future<void> addData(imgData) async {
    Firestore.instance.collection("Recent")
        .add(imgData).catchError((e) {
      print(e);
    });

  }

//  Future<void> addToTrending(imgData) async {
//    Firestore.instance.collection("Trending")
//        .add(imgData).catchError((e) {
//      print(e);
//    });
//  }



  Future<void> updateData(id, data,collectionName) async {
    Firestore.instance.collection(collectionName)
        .document(id).updateData(data).catchError((e) {});
  }

}