import 'package:flutter/material.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';

class HtmlTextWidget extends StatelessWidget {

  HtmlTextWidget(this.html);
  final String html;

  @override
  Widget build(BuildContext context) {
    String markdown = html2md.convert(html);
    return new Markdown(
      data: markdown,
    );
  }
}