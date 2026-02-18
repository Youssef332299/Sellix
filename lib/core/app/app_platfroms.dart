import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import '../enum/screen_enum.dart';

AppPlatform getCurrentPlatform() {
  if (kIsWeb) return AppPlatform.web;

  if (Platform.isAndroid) return AppPlatform.android;
  if (Platform.isIOS) return AppPlatform.ios;
  if (Platform.isWindows) return AppPlatform.windows;
  if (Platform.isMacOS) return AppPlatform.macos;
  if (Platform.isLinux) return AppPlatform.linux;

  throw UnsupportedError('Unsupported platform');
}
