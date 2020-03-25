import 'package:flutter/material.dart';
import 'UploadScreen.dart';
import'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:async';
import 'package:memes_palace/FullScreens.dart';
import 'package:firebase_admob/firebase_admob.dart';

class Trending extends StatefulWidget {
  @override
  _TrendingState createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {


  static final MobileAdTargetingInfo targetingInfo = new MobileAdTargetingInfo(


      testDevices: <String>[],
      keywords: <String>['recent', 'trend', 'random'],
      birthday: DateTime.now(),
      childDirected: true
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  BannerAd createBannerAd() {
    return new BannerAd(
        adUnitId: BannerAd.testAdUnitId,
        size: AdSize.banner,

        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BANNER EVENT:  $event");
        }

    );
  }

  InterstitialAd createInterstitialAd() {
    return new InterstitialAd(
        adUnitId: "ca-app-pub-6960977053080857/4552318797",
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("Interstitial EVENT:  $event");
        }

    );
  }








  StreamSubscription<QuerySnapshot>subscription;
List<DocumentSnapshot>images;
final CollectionReference collectionReference =
Firestore.instance.collection("Trending");

@override
void initState() {
  // TODO: implement initState
  super.initState();
  FirebaseAdMob.instance.initialize(
      appId: "ca-app-pub-6960977053080857~6214445320"
  );
  subscription = collectionReference.snapshots()
      .listen((datasnapshot) {
    setState(() {
      images = datasnapshot.documents;
    });
  });
}

@override
void dispose() {
  // TODO: implement dispose
  _interstitialAd?.dispose();
  subscription?.cancel();
  super.dispose();
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Trending MEMES"), centerTitle: true,
        backgroundColor: Colors.black87,
//          actions: <Widget>[
//            GestureDetector(
//                onTap: () {
//                  goto();
//                },
//                child: Icon(Icons.add, size: 35,)),
//          ],
      ),

      body: images != null ?
      new StaggeredGridView.countBuilder
        (crossAxisCount: 4
        ,
        padding: const EdgeInsets.all(8.0),
        itemCount: images.length,
        itemBuilder: (context, i) {
          String imgPath = images[i].data['imgUrl'];
          int likes=images[i].data['likes'];
          String id=  images[i].documentID.toString();
          return new Material(
            elevation: 15.0,
            borderRadius: new BorderRadius.all(new
            Radius.circular(15)),
            child: Card(
              elevation: 12,
              shape: RoundedRectangleBorder(

                borderRadius: BorderRadius.all(

                    Radius.circular(0)),

              ),


              child: new InkWell(
                onTap: (){
                  createInterstitialAd()..load()..show();
                    Navigator.push(context, new MaterialPageRoute(
                      builder: (context) => FullScreen(imgPath,likes,id,"Trending"),
                    ));},

                child: new Hero(tag: imgPath, child: new
                FadeInImage(placeholder:
                new AssetImage('assets/images/logo.png')
                  , image: new
                  NetworkImage(imgPath),
                  fit: BoxFit.cover,
                )
                ),
              ),
            ),

          );
        },

        staggeredTileBuilder: (i) =>
        new StaggeredTile.count(2, i.isEven ? 2 : 3),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 5.0,
      ) : new Center(
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

