

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:app_settings/app_settings.dart';
import 'package:bay/features/auth/pages/verify_phone.dart';
import 'package:bay/features/home/pages/home.dart';
import 'package:bay/providers/appointment_provider.dart';
import 'package:bay/providers/auth_provider.dart';
import 'package:bay/providers/places_provider.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:status_alert/status_alert.dart';

import 'features/auth/pages/login_phone.dart';
import 'features/dashboard/pages/dashboard.dart';
import 'features/dashboard/pages/dashboard_page.dart';
// import 'features/home/pages/location_page.dart' as Loc;
import 'firebase_options.dart';
// import 'package:location/location.dart' as Loc;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

   String _currentAddress = "Wakiso";

   late Position _currentPosition;
  bool loading = false;
  bool permission = false;

  final _messangerKey = GlobalKey<ScaffoldMessengerState>();

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }
  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
        ' ${place.subAdministrativeArea}';
        print('${_currentAddress},${_currentPosition}');
      });
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() => _currentPosition = position);
      await _getAddressFromLatLng(position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> getLocation() async {
    await _getCurrentPosition();

  }
    @override
  void initState() {
    super.initState();

    checkLocation();

    WidgetsBinding.instance.addObserver(this);

    }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  // @override
  //  didChangeAppLifecycleState(AppLifecycleState state)  {
  //   // If user resumed to this app, check permission
  //   if(state == AppLifecycleState.resumed) {
  //   }
  // }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // If user resumed to this app, check permission
    if(state == AppLifecycleState.resumed) {
       checkPermission();
       setState(() {

       });
       getLocation();
    }
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<AuthProvider>(context);
    // users.setPermission(permission);




    return MaterialApp(
      scaffoldMessengerKey: _messangerKey,

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: black
      ),


      home: FutureBuilder(
        future: setValue(users),
        builder: (
            BuildContext context,
            AsyncSnapshot<String> snapshot,
            ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(child: CircularProgressIndicator(color: Colors.white,),);
            } else if (snapshot.hasData) {
              return (FirebaseAuth.instance.currentUser != null) ? DashboardPage() :LoginPage();
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },



      ),
      // AnimatedSplashScreen(
      //
      //     duration: 2000,
      //     splash: Container(
      //
      //       child: Image.asset('assets/logo_black.jpg'),),
      //     nextScreen: (FirebaseAuth.instance.currentUser != null) ? DashboardPage() :LoginPage(),
      //     splashTransition: SplashTransition.rotationTransition,
      //     splashIconSize: 200,
      //     backgroundColor: Colors.black),
    routes: {
        'verify' : (context)=> VerifyPage(),
      "home" : (context) => DashboardPage(),
      // "location" : (context) => LocationPage(),


    },
    );

  }

  Future<void> checkLocation() async {
    bool serviceEnabled = await await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await AppSettings.openLocationSettings();
    }
    checkPermission();
  }

  Future<void> checkPermission() async {
    permission = await _handleLocationPermission();
    setState(() {

    });
    await getLocation();

    FlutterNativeSplash.remove();
  }

  Future<void> lastKnownLocation() async {
    Position? position = await Geolocator.getLastKnownPosition();
    setState(() {
      _currentPosition = position!;
    });
    await _getAddressFromLatLng(position!);

  }
   Future<String> setValue(AuthProvider users) async {
     // await Future.delayed(Duration(seconds: 3));
     users.setPosition(_currentPosition);
     users.setAddress(_currentAddress);
     return 'Finished';
   }
}


