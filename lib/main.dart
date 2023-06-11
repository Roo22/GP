import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:graduation_project/layout/home_layout.dart';
import 'package:graduation_project/modules/burns/Burn_Image.dart';
import 'package:graduation_project/modules/login/cubit/cubit.dart';
import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:graduation_project/modules/register/cubit/cubit.dart';
import 'package:graduation_project/shared/bloc_observer.dart';
import 'package:graduation_project/shared/components/conistance.dart';
import 'package:graduation_project/shared/cubit/cubit.dart';
import 'package:graduation_project/shared/cubit/states.dart';
import 'package:graduation_project/shared/network/local/cache_helper.dart';
import 'package:graduation_project/shared/styles/themes.dart';
import 'modules/on_boarding/on_boarding_screen.dart';



Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  print(message.data.toString());
  print("ON a background message");
}



final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print('token:$token');


  const initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());

  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });


  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  firebaseMessaging.requestPermission();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);



  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  isDark= CacheHelper.get('isDark')??false;
  bool? onBoarding= CacheHelper.get('onBoarding');
  uId= CacheHelper.get('uId');

  Widget widget;

  if(onBoarding!=null)
    {
      if(uId!=null)
        {
          widget= HomeLayout();
        }
      else widget= LoginScreen();
    }
  else widget=OnBoardingScreen();

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget{
  final bool? isDark;
  final Widget? startWidget;

  MyApp({
    this.isDark,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context){

    return BlocProvider(
      create: (context) => AppCubit()..changeAppMode(fromShared:isDark)..getUserData()..getTrainerData()..getUsers()..getTrainers(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder:(context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }

}
