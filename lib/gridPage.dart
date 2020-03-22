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
      backgroundColor: Colors.black45,
      body: _children[_currentIndex],

      bottomNavigationBar:   BottomNavigationBar(
backgroundColor: Colors.black45,
type: BottomNavigationBarType.fixed,
          onTap: onTabTapped, // new
          currentIndex: _currentIndex, // this will be set when a new tab is tapped
          items: [

            BottomNavigationBarItem(
                icon: new FaIcon(FontAwesomeIcons.rocket,color: Color(0xffF5BD1F),),
                activeIcon: FaIcon(FontAwesomeIcons.rocket,color: Color(0xffF5BD1F),) ,
                title: Text('Recent',style: TextStyle(color: Color(0xffF5BD1F)))
            ),
            BottomNavigationBarItem(
              icon: new FaIcon(FontAwesomeIcons.poll,color: Color(0xffF5BD1F),),
              activeIcon: new FaIcon(FontAwesomeIcons.poll,color: Color(0xffF5BD1F),),
              title: new Text('Trending',style: TextStyle(color: Color(0xffF5BD1F))),
            ),
            BottomNavigationBarItem(
              icon: new FaIcon(FontAwesomeIcons.random,color: Color(0xffF5BD1F),),
              activeIcon: new FaIcon(FontAwesomeIcons.random,color: Color(0xffF5BD1F),),
              title: Text('Random',style: TextStyle(color: Color(0xffF5BD1F))),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.favorite,color: Color(0xffF5BD1F),),
              activeIcon: new Icon(Icons.favorite,color: Color(0xffF5BD1F),),
              title: Text('Favourites',style: TextStyle(color: Color(0xffF5BD1F))),
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