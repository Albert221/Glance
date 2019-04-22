import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:reddigram/app.dart';

void main() {
  Crashlytics.instance.enableInDevMode = true;
  FlutterError.onError = (details) => Crashlytics.instance.onError(details);

  runApp(ReddigramApp());
}
