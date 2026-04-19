import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fittrack/app/app_controller.dart';
import 'package:fittrack/app/fitness_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  AppController().initialize();

  runApp(const FitnessApp());
}
