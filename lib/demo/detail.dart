import 'package:flutter/material.dart';

class DetailWidget extends StatelessWidget {
  static final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final double _appBarHeight = 256.0;

    return new Scaffold(
      key: _scaffoldKey,
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            expandedHeight: _appBarHeight,
            pinned: true,
            floating: false,
            snap: false,
            leading: new IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Back',
              onPressed: () {
                _scaffoldKey.currentState.showSnackBar(const SnackBar(
                    content: const Text("Editing isn't supported in this screen.")
                ));
              },
            ),
            flexibleSpace: new FlexibleSpaceBar(
              title: const Text('Ali Connors'),
              background: new Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  new Image.asset(
                    'images/ali_connors.jpg',
                    fit: BoxFit.cover,
                    height: _appBarHeight,
                  ),
                  // This gradient ensures that the toolbar icons are distinct
                  // against the background image.
                  const DecoratedBox(
                    decoration: const BoxDecoration(
                      gradient: const LinearGradient(
                        begin: const Alignment(0.0, -1.0),
                        end: const Alignment(0.0, -0.4),
                        colors: const <Color>[
                          const Color(0x60000000),
                          const Color(0x00000000)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          new SliverList(
            delegate: new SliverChildListDelegate(<Widget>[
              new Container(
                height: 100.0,
                child: new Text("testMessage"),
              ),
              new Container(
                height: 100.0,
                child: new Text("testMessage"),
              ),
              new Container(
                height: 100.0,
                child: new Text("testMessage"),
              ),
              new Container(
                height: 100.0,
                child: new Text("testMessage"),
              ),
              new Container(
                height: 100.0,
                child: new Text("testMessage"),
              ),
              new Container(
                height: 100.0,
                child: new Text("testMessage"),
              ),
              new Container(
                height: 100.0,
                child: new Text("testMessage"),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
