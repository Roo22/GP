import 'package:flutter/material.dart';
import 'package:graduation_project/splash screen/splash_screen.dart';
class MLApp extends StatelessWidget {
  const MLApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen( ),
    );
  }
}
