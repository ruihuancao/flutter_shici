import 'package:flutter/material.dart';
import 'package:flutter_shici/res/string.dart';


class ToolsPage extends StatefulWidget {

  final Widget optionsPage;

  ToolsPage(this.optionsPage);

  @override
  _ToolsPageState createState() => new _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(Strings.menu_tool),
      ),
      body: widget.optionsPage,
    );
  }
}
