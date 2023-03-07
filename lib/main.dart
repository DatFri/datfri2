
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bay/features/auth/pages/verify_phone.dart';
import 'package:bay/features/home/pages/home.dart';
import 'package:bay/providers/appointment_provider.dart';
import 'package:bay/providers/auth_provider.dart';
import 'package:bay/providers/places_provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/auth/pages/login_phone.dart';
import 'features/dashboard/pages/dashboard.dart';
import 'features/dashboard/pages/dashboard_page.dart';
import 'features/home/pages/location_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthProvider()),
          ChangeNotifierProvider(create: (context) => AppointmentProvider()),
          ChangeNotifierProvider(create: (context) => PlacesProvider()),

        ],
        child:
        // const MyApp())
        // DevicePreview( builder: (BuildContext context)=>
        const MyApp()
        //)
  )

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
          nextScreen: FirebaseAuth.instance.currentUser != null ? DashboardPage():LoginPage(),
          splashTransition: SplashTransition.rotationTransition,
          splashIconSize: 200,
          backgroundColor: Colors.black),
    routes: {
        'verify' : (context)=> VerifyPage(),
      "home" : (context) => DashboardPage(),
      "location" : (context) => LocationPage(),


    },
    );

  }
}
