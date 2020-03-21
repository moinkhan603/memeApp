import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods{

Future<void>addData(imgData)async{


  Firestore.instance.collection("Recent")
      .add(imgData).catchError((e){
        print(e);
  });
}




}