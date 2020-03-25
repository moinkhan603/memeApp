import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:memes_palace/Crud.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_admob/firebase_admob.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {



  static final MobileAdTargetingInfo targetingInfo=new MobileAdTargetingInfo(


      testDevices: <String>[],
      keywords: <String>['recent','trend','random'],
      birthday: DateTime.now(),
      childDirected: true
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseAdMob.instance.initialize(
        appId:"ca-app-pub-6960977053080857~6214445320"
    );
//    createBannerAd()
//      ..load()
//      ..show();
  }

  @override
  void dispose() {
    // TODO: implement dispose
   // _bannerAd?.dispose();
    _interstitialAd?.dispose();
  //  _bannerAd = null;
    super.dispose();
    //addTrendingData();
  }





  bool showSpinner=false;
  File _image;
  String _uploadedFileURL;

  CrudMethods crudMethods=new CrudMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
        appBar: AppBar(title: Text("UPLOAD MEMES"),centerTitle: true,
          backgroundColor: Colors.black,
        ),
      body: ModalProgressHUD(
        color: Colors.white,
        inAsyncCall: showSpinner,
        child: Center(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('after selection press upload',style: TextStyle(color: Colors.white),),
              _image != null

                  ? Image.file(

                _image,
                height: 250,
              )
                  : Container(height: 250),
              _image == null
                  ? RaisedButton(
                child: Text('Choose File',style: TextStyle(color: Colors.white),),
                onPressed: chooseFile2,
                color: Colors.green,
              )
                  : Container(),
              _image != null
                  ? RaisedButton(
                child: Text('Upload File'),
                onPressed: uploadFile,
                color: Color(0xffF5BD1F),
              )
                  : Container(),
              _image != null
                  ? RaisedButton(
                child: Text('Clear Selection'),
                onPressed: clearSelection,
              )
                  : Container(),
              Text('Uploaded Image'),
              _uploadedFileURL != null
                  ? Image.network(
                _uploadedFileURL,
                height: 250,

              )
                  : Container(),
            ],
          ),
        ),
      ),
     );
  }



  void chooseFile2()async {
    File selected=await ImagePicker.pickImage(source: ImageSource.gallery);

      this.setState(() {
        _image = selected;
        print(_image);
      });


  }





  Future uploadFile() async {
createInterstitialAd()..load()..show();
    setState(() {
      showSpinner=true;
    });


    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('Recent/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
        print(fileURL);
        cloudStore();
        showSpinner=false;

      });
    });


  }


  void cloudStore()
  {
    Map<String,dynamic> mymap={
      "imgUrl": _uploadedFileURL,
      "likes":1

    };

    crudMethods.addData(mymap).then((results){

      print("vvvv");

    });
    Navigator.pop(context);
  }


  void clearSelection() {
    setState(() {
      _image = null;
      _uploadedFileURL = null;
    });
  }


}
