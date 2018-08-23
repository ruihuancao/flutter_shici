import 'package:flutter/material.dart';
import 'package:flutter_shici/setting/options.dart';
import 'package:flutter_shici/setting/scales.dart';
import 'package:flutter_shici/setting/theme.dart';

class OptionsSwitchItem extends StatelessWidget {

  const OptionsSwitchItem(this.title, this.value, this.onChanged);

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return new _OptionsItem(
      child: new Row(
        children: <Widget>[
          new Expanded(child: new Text(title)),
          new Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _TextScaleFactorItem extends StatelessWidget {
  const _TextScaleFactorItem(this.options, this.onOptionsChanged);

  final Options options;
  final ValueChanged<Options> onOptionsChanged;

  @override
  Widget build(BuildContext context) {
    return new _OptionsItem(
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Text size'),
                new Text(
                  '${options.textScaleFactor.label}',
                  style: const TextStyle(fontSize: 12.0),
                ),
              ],
            ),
          ),
          new PopupMenuButton<AppTextScaleValue>(
            padding: const EdgeInsetsDirectional.only(end: 16.0),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
            itemBuilder: (BuildContext context) {
              return kAllAppTextScaleValues.map((AppTextScaleValue scaleValue) {
                return new PopupMenuItem<AppTextScaleValue>(
                  value: scaleValue,
                  child: new Text(scaleValue.label),
                );
              }).toList();
            },
            onSelected: (AppTextScaleValue scaleValue) {
              onOptionsChanged(
                options.copyWith(textScaleFactor: scaleValue),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _OptionsItem extends StatelessWidget {
  const _OptionsItem({ Key key, this.child }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double textScaleFactor = MediaQuery.textScaleFactorOf(context);
    double _kItemHeight = 48.0;
    EdgeInsetsDirectional _kItemPadding = const EdgeInsetsDirectional.only(start: 16.0, end: 16.0);

    return new MergeSemantics(
      child: new Container(
        constraints: new BoxConstraints(minHeight: _kItemHeight * textScaleFactor),
        padding: _kItemPadding,
        alignment: AlignmentDirectional.centerStart,
        child: new DefaultTextStyle(
          style: DefaultTextStyle.of(context).style,
          maxLines: 2,
          overflow: TextOverflow.fade,
          child: new IconTheme(
            data: Theme.of(context).primaryIconTheme,
            child: child,
          ),
        ),
      ),
    );
  }
}

class OptionsPage extends StatelessWidget {

  const OptionsPage({
    Key key,
    this.options,
    this.onOptionsChanged,
  }) : super(key: key);


  final Options options;
  final ValueChanged<Options> onOptionsChanged;

  void switch_theme_change(bool){
    onOptionsChanged(options.copyWith(
        theme: bool ? kDarkTheme : kLightTheme
    ));
  }

  void switch_rtl_change(bool){
    onOptionsChanged(options.copyWith(
        textDirection: bool ? TextDirection.rtl : TextDirection.ltr
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new OptionsSwitchItem("夜间模式", options.theme == kDarkTheme, switch_theme_change),
          new OptionsSwitchItem("RTL", options.textDirection == TextDirection.rtl, switch_rtl_change),
          new _TextScaleFactorItem(options, onOptionsChanged)
        ],
      ),
    );
  }
}