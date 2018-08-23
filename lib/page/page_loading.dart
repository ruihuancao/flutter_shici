import 'package:flutter/material.dart';


class PageLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: CircularProgressIndicator(),
    );
  }
}


class PageErrorWidget extends StatelessWidget {

  final VoidCallback onReptry;
  final String message;

  PageErrorWidget(this.onReptry, this.message);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Center(
          child: new Text(message)
      ),
      onTap: onReptry,
    );
  }
}