import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;

import 'package:flutter_shici/setting/options.dart';
import 'package:flutter_shici/setting/theme.dart';
import 'package:flutter_shici/setting/scales.dart';
import 'package:flutter_shici/page/options.dart';
import 'home.dart';

/// App
class FastApp extends StatefulWidget {
  @override
  _FastAppState createState() => new _FastAppState();
}

class _FastAppState extends State<FastApp> {

  /// 系统设置
  Options _options;

  @override
  void initState(){
    super.initState();
    /// 初始化设置
    _options = new Options(
      theme: kLightTheme,
      platform: defaultTargetPlatform,
      textScaleFactor: kAllAppTextScaleValues[0],
      textDirection: TextDirection.ltr,
    );
    /// 从pref文件配置更新设置
    Options.init().then((Options options){
      setState(() {
        _options = options;
      });
    });
  }

  /// 设置配置变更
  void _handleOptionsChanged(Options newOptions) {
    Options.update(newOptions);
    setState(() {
      _options = newOptions;
    });
  }

  /// 修改字体大小
  Widget _applyTextScaleFactor(Widget child) {
    return new Builder(
      builder: (BuildContext context) {
        return new MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: _options.textScaleFactor.scale,
          ),
          child: child,
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    Widget home = new FastHome(
      optionsPage: new OptionsPage(options: _options, onOptionsChanged: _handleOptionsChanged),
    );
    return new MaterialApp(
        theme: _options.theme.data.copyWith(platform: _options.platform),
        debugShowCheckedModeBanner: false,
        showPerformanceOverlay: false,
        builder: (BuildContext context, Widget child) {
          return new Directionality(
            // ltr lrt 支持
            textDirection: _options.textDirection,
            child: _applyTextScaleFactor(child),
          );
        },
        home: new Scaffold(
          body: home
        )
    );
  }
}
