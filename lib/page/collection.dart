import 'package:flutter/material.dart';
import 'package:flutter_shici/data/unsplash_api.dart';
import 'package:flutter_shici/page/login.dart';
import 'package:flutter_shici/page/video.dart';
class CollectionPage extends StatefulWidget {
  @override
  _CollectionPageState createState() => new _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  String image;

  @override
  void initState() {
    super.initState();
    initPage();
  }

  initPage() async {
    String url = await fetchRandomImage(1080, 1920);
    setState(() {
      image = url;
    });
  }

  Widget test(Color color) {
    return new Container(
      width: 100.0,
      height: 100.0,
      color: color,
      padding: const EdgeInsets.all(16.0),
      child: new Center(
        child: new Text(
          "test",
          style: new TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget buildContent() {
    if (image == null) {
      return new Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                test(Colors.blue),
                test(Colors.red),
                test(Colors.green),
                new Expanded(child: test(Colors.teal))
              ],
            ),
            new Image.asset(
              'images/ali_connors.jpg',
              fit: BoxFit.fitWidth,
              colorBlendMode: BlendMode.srcOver,
              color: new Color.fromARGB(120, 20, 10, 40),
            ),
          ],
        ),
        color: Colors.black,
      );
    }
  }

  ///
  ///

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Collection"),
      ),
      body: new Container(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          children: <Widget>[
            new RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[new Text("Login")],
              ),
            ),

            new RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoPage(),
                  ),
                );
              },
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[new Text("Video")],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
