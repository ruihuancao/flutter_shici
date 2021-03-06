import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'theme.dart';
import 'scales.dart';


const String pref_key_theme = "pref_key_theme";
const String pref_key_text_scales = "pref_key_text_scales";
const String pref_key_text_direction = "pref_key_text_direction";

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class Options{

  Options({this.textDirection, this.theme, this.platform, this.textScaleFactor});

  final TextDirection textDirection;

  final AppTextScaleValue textScaleFactor;

  final AppTheme theme;

  final TargetPlatform platform;

  Options copyWith({
    AppTheme theme,
    AppTextScaleValue textScaleFactor,
    TextDirection textDirection,
    TargetPlatform platform,
  }) {
    Options options =  new Options(
      theme: theme ?? this.theme,
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      textDirection: textDirection ?? this.textDirection,
      platform: platform ?? this.platform,
    );
    return options;
  }

  static Future<Options> init() async{
    AppTheme appTheme = await getCurrentTheme();
    AppTextScaleValue appTextScaleValue = await getCurrentAppTextScaleValue();
    TextDirection textDirection = await getCurrentTTextDirection();
    Options options =  new Options(
      theme: appTheme,
      textScaleFactor: appTextScaleValue,
      textDirection: textDirection,
      platform: defaultTargetPlatform,
    );
    return options;
  }

  static Future<Null> update(Options options) async{
    SharedPreferences prefs = await _prefs;
    prefs.setString(pref_key_theme, options.theme.name);
    prefs.setString(pref_key_text_scales, options.textScaleFactor.label);
    prefs.setString(pref_key_text_direction, TextDirection.ltr == options.textDirection ? "ltr" : "rtl");
  }

  static Future<AppTheme> getCurrentTheme() async{
    SharedPreferences prefs = await _prefs;
    String name = prefs.getString(pref_key_theme);
    if(name == kDarkTheme.name){
      return kDarkTheme;
    }else{
      return kLightTheme;
    }
  }

  static Future<TextDirection> getCurrentTTextDirection() async{
    SharedPreferences prefs = await _prefs;
    String name = prefs.getString(pref_key_text_direction);
    if(name == "rtl"){
      return TextDirection.rtl;
    }else{
      return TextDirection.ltr;
    }
  }

  static Future<AppTextScaleValue> getCurrentAppTextScaleValue() async{
    SharedPreferences prefs = await _prefs;
    String name = prefs.getString(pref_key_text_scales);
    AppTextScaleValue appTextScaleValue;

    if(name == null || name == ""){
      appTextScaleValue = kAllAppTextScaleValues[0];
    }else{
      for(int i =0 ; i < kAllAppTextScaleValues.length; i++){
        if(name == kAllAppTextScaleValues[i].label){
          appTextScaleValue = kAllAppTextScaleValues[i];
          break;
        }
      }
    }
    return appTextScaleValue;
  }

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType)
      return false;
    final Options typedOther = other;
    return theme == typedOther.theme
        && textScaleFactor == typedOther.textScaleFactor
        && textDirection == typedOther.textDirection
        && platform == typedOther.platform;
  }

  @override
  int get hashCode => hashValues(
    theme,
    textScaleFactor,
    textDirection,
    platform,
  );

  @override
  String toString() {
    return '$runtimeType($theme)';
  }
}

