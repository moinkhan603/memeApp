import 'UploadScreen.dart';
import'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'fullScreen.dart';
class Recent extends StatefulWidget {
  @override
  _RecentState createState() => _RecentState();
}

class _RecentState extends State<Recent> {
  StreamSubscription<QuerySnapshot>subscription;
  List<DocumentSnapshot>images;
  final CollectionReference collectionReference=
      Firestore.instance.collection("Recent");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    subscription=collectionReference.snapshots()
    .listen((datasnapshot){


      setState(() {
        images=datasnapshot.documents;
      });


    });
  }

@override
  void dispose() {
    // TODO: implement dispose
  
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("RECENT MEMES"),centerTitle: true,
      backgroundColor: Colors.black87,
        actions: <Widget>[
          GestureDetector(
              onTap: (){
                
               goto();
              },
              child: Icon(Icons.add,size: 35,)),
        ],
      ),
      
    body: images!=null?
        new StaggeredGridView.countBuilder
          (crossAxisCount: 4
            ,padding: const EdgeInsets.all(8.0) ,
          itemCount: images.length,
          itemBuilder: (context,i){
             String imgPath=images[i].data['imgUrl'];

             return new Material(
               elevation: 15.0,
               borderRadius: new BorderRadius.all(new 
               Radius.circular(15)),
               child: new InkWell(
                 onTap:()=> Navigator.push(context,new  MaterialPageRoute(
             builder: (context)=>FullScreenImagePage(imgPath),
                 )),
                 child: new Hero(tag: imgPath, child: new
                 FadeInImage(placeholder:
          new AssetImage('assets/images/logo.png')
                   , image: new
                 NetworkImage(imgPath),
                   fit: BoxFit.cover,
                 )
                 ),
               ),

             );

          },

          staggeredTileBuilder:(i)=>new StaggeredTile.count(2, i.isEven?2:3) ,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 3.0,
        ):new Center(
      child: new CircularProgressIndicator(),

    )
//      
//      
//      FloatingActionButton
//
//            (
//
//            backgroundColor: Colors.red,
//            elevation: 10,
//            onPressed: goto,
//            tooltip: 'UPLOAD',
//            child: Icon(Icons.add),
//
//          ),
//      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//

        




    );
  }

  void goto() {

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UploadScreen()),
    );
  }
}
