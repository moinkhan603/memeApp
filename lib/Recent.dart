
import 'UploadScreen.dart';
import'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:memes_palace/FullScreens.dart';
import 'Crud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_admob/firebase_admob.dart';


class Recent extends StatefulWidget {
  @override
  _RecentState createState() => _RecentState();
}

class _RecentState extends State<Recent> {

  static String testdevice="";
static final MobileAdTargetingInfo targetingInfo=new MobileAdTargetingInfo(


  testDevices: <String>[],
  keywords: <String>['recent','trend','random'],
  birthday: DateTime.now(),
  childDirected: true
);

BannerAd _bannerAd;
InterstitialAd _interstitialAd;




  //for trending

//
//  StreamSubscription<QuerySnapshot>subscriptionT;
//  List<DocumentSnapshot>imagesT;
//  final CollectionReference collectionReferenceT =
//  Firestore.instance.collection("Trending");




BannerAd createBannerAd(){
  return new BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event){
        print("BANNER EVENT:  $event");
    }

  );

}

  InterstitialAd createInterstitialAd(){
    return new InterstitialAd(
        adUnitId: "ca-app-pub-6960977053080857/4552318797",
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event){
          print("Interstitial EVENT:  $event");
        }

    );

  }



  /////
  StreamSubscription<QuerySnapshot>subscription;
  CrudMethods mydata=new CrudMethods();
  List<DocumentSnapshot>images;
  final CollectionReference collectionReference=
      Firestore.instance.collection("Recent");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

FirebaseAdMob.instance.initialize(
    appId:"ca-app-pub-6960977053080857~6214445320"
);

//_bannerAd=createBannerAd() ..load()..show();




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
_bannerAd?.dispose();
_interstitialAd.dispose();
    subscription?.cancel();
    super.dispose();
    //addTrendingData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("RECENT MEMES"),centerTitle: true,
      backgroundColor: Colors.black,
        actions: <Widget>[

          GestureDetector(

              onTap: (){
                
               goto();
              },
              child: Padding(
                padding: const EdgeInsets.only(top:8.0,right: 4),
                child: FaIcon(

                  FontAwesomeIcons.plusCircle,color: Color(0xffF5BD1F),size: 35,),
              )),
        ],
      ),
      
    body: 
    
    images!=null?
        Container(

          color: Colors.black87,
          child: new StaggeredGridView.countBuilder
          
            (

              
              crossAxisCount: 4
              ,padding: const EdgeInsets.all(8.0) ,
            itemCount: images.length,
            itemBuilder: (context,i){
               String imgPath=images[i].data['imgUrl'];
               int likes=images[i].data['likes'];
               String id=  images[i].documentID.toString();

               return new Material(
                color: Colors.grey,
                elevation: 15.0,
                 borderRadius: new BorderRadius.all(new
                 Radius.circular(10)),
                 child: Card(
                   elevation: 12,
                   shape: RoundedRectangleBorder(

                     borderRadius: BorderRadius.all(

                         Radius.circular(0)),

                   ),
                   child: new InkWell(

                     onTap:() {
                       createInterstitialAd()..load()..show();
                       Navigator.push(context, new MaterialPageRoute(
                         builder: (context) =>
                             FullScreen(imgPath, likes, id, "Recent"),
                       ));

                     },


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

            staggeredTileBuilder:(i)=>new StaggeredTile.count(2, i.isEven?2:3) ,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 5.0,
          ),
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
//
//void addTrendingData()
//{
//  bool chk=false;
//  for(int i=0;i<images.length;i++)
//    {
//      if(images[i].data['likes']>100)
//          {
//            Map<String,dynamic> mymap={
//              "imgUrl":images[i].data['imgUrl'],
//              "likes":images[i].data['likes']
//
//            };
//            for(int j=0;j<imagesT.length;j++){
//
//              if(imagesT[j].data['imgUrl']==images[i].data['imgUrl']) {
//
//                chk=true;
//                break;
//              }
//              else
//                {
//                  chk=false;
//                  break;
//
//                }
//            }
//print(chk);
// if(chk==false)
//   {
//     mydata.addToTrending(mymap).then((res) {
//       print("likes data added");
//     });
//   }
//
//
//}
//
//    }
//
//
//}
  void goto() {
createInterstitialAd()..load()..show();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UploadScreen()),
    );
  }
}
