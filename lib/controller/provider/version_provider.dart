import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionProvider with ChangeNotifier {
  String _version = '';

  String get version => _version;

  Future<void> loadAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _version = '${packageInfo.version} (Build ${packageInfo.buildNumber})';
    notifyListeners(); // Notify listeners after the version is loaded
  }
}