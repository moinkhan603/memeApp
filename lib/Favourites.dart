import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'fullScreen.dart';
class Favouirites extends StatefulWidget {

  @override
  _FavouiritesState createState() => _FavouiritesState();




}

class _FavouiritesState extends State<Favouirites> {

  List<String>list=new List<String>();
  String path="https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQr2C629rLqPngBTwK1lr2B6WhkJoxpn441enLkkSobXaQb-fuz";
  @override
  void initState() {
    // TODO: implement initState
    _read();
    super.initState();




  }



  @override
  Widget build(BuildContext context) {
    // list[index]!=null:
      return
        Scaffold(

          body: SafeArea(
            child: Container(
              alignment: Alignment.center,
            height: 350,
      child:

      GestureDetector(
            onTap: (){
              Navigator.push(context, new MaterialPageRoute(
                builder: (context) => FullScreenImagePage(path),
              ));

            },

            child: Image(image: new NetworkImage(path))),








    ),
          ),
        );
  }


  _read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_list';
    // var lst=new List();
    setState(() {
      path= prefs.getString(key);
    });

    print(prefs.getString(key));
  //list= prefs.getStringList(key);
    // c=prefs.getStringList(key).toString();
    //widget.list.add(prefs.getStringList(key).toString());
//print(list);
  }

}