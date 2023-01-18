
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bay/features/auth/pages/verify_phone.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'features/auth/pages/login_phone.dart';
import 'features/dashboard/pages/dashboard.dart';

void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    // DevicePreview( builder: (BuildContext context)=>
    const MyApp()

     );
}
const MaterialColor black = const MaterialColor(
  0xFF070606,
  const <int, Color>{
    50: const Color(0xFF070606),
    100: const Color(0xFF070606),
    200: const Color(0xFF070606),
    300: const Color(0xFF070606),
    400: const Color(0xFF070606),
    500: const Color(0xFF070606),
    600: const Color(0xFF070606),
    700: const Color(0xFF070606),
    800: const Color(0xFF070606),
    900: const Color(0xFF070606),
  },
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: black
      ),
      home: AnimatedSplashScreen(
          duration: 2000,
          splash: Container(

            child: Image.asset('assets/logo_black.jpg'),),
          nextScreen: LoginPage(),
          splashTransition: SplashTransition.rotationTransition,
          splashIconSize: 200,
          backgroundColor: Colors.black),
    routes: {
        'verify' : (context)=> VerifyPage(),
      'login' : (context)=> DashboardPage()

    },
    );

  }
}
