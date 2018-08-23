import 'package:flutter/material.dart';
import 'package:flutter_shici/res/string.dart';
import 'package:flutter_shici/page/person.dart';
import 'package:flutter_shici/page/home.dart';
import 'package:flutter_shici/page/collection.dart';
import 'package:flutter_shici/page/tools.dart';
import 'package:flutter_shici/page/video.dart';
/// 主页面
class FastHome extends StatefulWidget {

  const FastHome({
    Key key,
    this.optionsPage,
  }) : super(key: key);

  final Widget optionsPage;

  @override
  _FastHomeState createState() => new _FastHomeState();
}


class _FastHomeState extends State<FastHome>{
  static final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    /// 底部导航Item
    List<BottomNavigationBarItem> navigationViews = <BottomNavigationBarItem>[
      new BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        title: new Text(Strings.menu_home),
      ),
      new BottomNavigationBarItem(
        icon: const Icon(Icons.collections),
        title: new Text(Strings.menu_collection),
      ),
      new BottomNavigationBarItem(
        icon: const Icon(Icons.ondemand_video),
        title: new Text(Strings.menu_tool),
      ),
      new BottomNavigationBarItem(
        icon: const Icon(Icons.person),
        title: new Text(Strings.menu_person),
      ),
    ];

    /// 底部导航Widget
    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      items: navigationViews,
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );

    /// Page页面
    IndexedStack indexedStack = new IndexedStack(
      index: _currentIndex,
      children: <Widget>[
        new HomePage(),
        new CollectionPage(),
        new VideoPage(),
        new PersonPage()
      ],
    );

    return new Scaffold(
      key: _scaffoldKey,
      body: indexedStack,
      bottomNavigationBar: botNavBar
    );
  }
}