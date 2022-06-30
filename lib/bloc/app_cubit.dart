import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/utils.dart';
import '../../../server/webdav/webdav.dart';

class WebDAVConfig {
  String url;
  String username;
  String password;

  WebDAVConfig(
      {required this.url, required this.username, required this.password});

  Map<String, dynamic> toMap() {
    return <String, String>{
      'url': url,
      'username': username,
      'password': password,
    };
  }

  factory WebDAVConfig.fromMap(Map<String, dynamic> map) {
    return WebDAVConfig(
      url: map['url'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }
}

class AppConfig {
  MaterialColor primarySwatch;
  Locale? locale;
  String? fontFamily;
  dynamic server;

  AppConfig(
      {required this.primarySwatch, this.locale, this.fontFamily, this.server});

  @override
  String toString() {
    return 'AppConfig{primarySwatch: $primarySwatch, locale: $locale}';
  }

  AppConfig copyWith({
    MaterialColor? primarySwatch,
    Locale? locale,
    String? fontFamily,
    dynamic server,
  }) {
    return AppConfig(
      primarySwatch: primarySwatch ?? this.primarySwatch,
      locale: locale,
      fontFamily: fontFamily ?? this.fontFamily,
      server: server ?? this.server,
    );
  }
}

class AppCubit extends Cubit<AppConfig> {
  static Future<AppConfig> getDefaultConfig() async {
    var sp = await SharedPreferences.getInstance();
    var defaultColor = Colors.green.value;
    // if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    //   defaultColor = Colors.white.value;
    // }
    var color = sp.getInt("primarySwatch") ?? defaultColor;
    var language = sp.getString("language");
    var fontFamily = sp.getString("fontFamily");
    var configType = sp.getString("config_type");
    var config = sp.getString("webdav_config");
    var appConfig = AppConfig(
        primarySwatch: getSwatch(Color(color), fontFamily: fontFamily));
    if (language == null) {
      appConfig = appConfig.copyWith(locale: null);
    } else {
      appConfig = appConfig.copyWith(
          locale: Locale.fromSubtags(languageCode: language));
    }
    if (configType != null && config != null) {
      if (configType == 'webdav') {
        appConfig = appConfig.copyWith(
            server: WebDAVConfig.fromMap(jsonDecode(config)));
      }
    }
    return appConfig;
  }

  AppCubit(AppConfig initConfig) : super(initConfig);

  Future<void> setLanguage(Locale? locale) async {
    var sp = await SharedPreferences.getInstance();
    if (locale == null) {
      sp.remove("language");
    } else {
      sp.setString("language", locale.languageCode);
    }
    emit(state.copyWith(locale: locale));
  }

  Future<void> setFontFamily(String? fontFamily) async {
    var sp = await SharedPreferences.getInstance();
    if (fontFamily == null) {
      sp.remove("fontFamily");
    } else {
      sp.setString("fontFamily", fontFamily);
    }
    emit(state.copyWith(fontFamily: fontFamily));
  }

  Future<void> setPrimaryColor(Color color) async {
    emit(state.copyWith(primarySwatch: getSwatch(color)));
    var sp = await SharedPreferences.getInstance();
    sp.setInt("primarySwatch", color.value);
  }

  Future<void> setWebDAV(String url, String username, String password) async {
    var client = WebDAVClient(url, user: username, password: password);
    await client.ping();
    var config = WebDAVConfig(url: url, username: username, password: password);
    var sp = await SharedPreferences.getInstance();
    sp.setString("webdav_config", jsonEncode(config.toMap()));
    sp.setString("config_type", "webdav");
    emit(state.copyWith(server: config));
  }
}
