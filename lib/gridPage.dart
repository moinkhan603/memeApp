import 'package:flutter/material.dart';
import 'Random.dart';
import 'Recent.dart';
import 'Trending.dart';
import 'Favourites.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class gridPage extends StatefulWidget {
  @override
  _gridPageState createState() => _gridPageState();
}

class _gridPageState extends State<gridPage> {


  int _currentIndex = 1;
  final List<Widget> _children = [

   Recent(),
    Trending(),
    Random(),
    Favouirites()

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _children[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(

        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // this will be set when a new tab is tapped
        items: [

          BottomNavigationBarItem(
              icon: new FaIcon(FontAwesomeIcons.rocket,color: Colors.black87,),
              activeIcon: FaIcon(FontAwesomeIcons.rocket,color: Colors.black87,) ,
              title: Text('Recent',style: TextStyle(color: Colors.black))
          ),
          BottomNavigationBarItem(
            icon: new FaIcon(FontAwesomeIcons.poll,color: Colors.black87,),
            activeIcon: new FaIcon(FontAwesomeIcons.poll,color: Colors.black87,),
            title: new Text('Trending',style: TextStyle(color: Colors.black)),
          ),
          BottomNavigationBarItem(
            icon: new FaIcon(FontAwesomeIcons.random,color: Colors.black87,),
            activeIcon: new FaIcon(FontAwesomeIcons.random,color: Colors.black87,),
            title: Text('Random',style: TextStyle(color: Colors.black)),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.favorite,color: Colors.black87,),
            activeIcon: new Icon(Icons.favorite,color: Colors.black87,),
            title: Text('Favourites',style: TextStyle(color: Colors.black)),
          ),


        ],
      ),
    );
  }

void onTabTapped(int index) {
  if (index == 5) {
   // SystemNavigator.pop();
    //  _launchSupport();
  }
  else {
    setState(() {
      _currentIndex = index;
    });
  }
}
}