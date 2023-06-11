import 'dart:async';
import 'package:graduation_project/shared/components/conistance.dart';
import 'package:graduation_project/Ml Model/mi_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _time;
  //Start Time
  Start()
  {
     _time = Timer(Duration(seconds: 6), call);
  }
  //Navigat to another screen
  void call()
  {
    Navigator.pushReplacement(context, 
    MaterialPageRoute(builder: (context)=>MIModel(),));
  }
  @override
  void initState() {
    Start();
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    _time.cancel();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.kLightFuchsiaColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.black,
          systemNavigationBarColor: Colors.black,
        ),
        backgroundColor: Constants.kLightFuchsiaColor,
        elevation: 0,
      ),
      body: Center(
        // lottie is animation picture that appear on splashscreen
        child: Lottie.network('https://assets6.lottiefiles.com/packages/lf20_xfhjdjbn.json'),

      ),
    );
  }
}
