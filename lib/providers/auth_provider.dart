import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../features/auth/models/user.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier{
  late Users user;
  bool isLoaded = false;
  bool photonull = true;
  String username ='';
  String photoUrl='';
  String code = '';
  String phoneNumber = '';
  var _auth ;
  String currentAddress = '';
  late Position currentPosition;
  // AppointmentService appointmentService= AppointmentService();
  List appointments =[];
  List notifications =[];
  Auth auth = Auth();
   bool hasPermission = false;

  AuthProvider(){
    user = Users();
    _auth = Auth();
    isLoaded = false;
    getUserDetails();
  }

  void setPhone(String number){
    phoneNumber = number;
    notifyListeners();
  }
  void setPosition(Position position){
    currentPosition = position;
    notifyListeners();
  }
  void setAddress(String address){
    currentAddress = address;
    notifyListeners();
  }
  void setPermission(bool permission){
    hasPermission = permission;
    notifyListeners();
  }

  void getUserDetails() async {
    user = await _auth.getUserDetails() ;
    isLoaded = true;
    photonull = false;
    username  = user.name!;
    // photoUrl = user.photoUrl;
    if (kDebugMode) {
      print(isLoaded);
    }
    notifyListeners();
    // getAppointments(user.uid);
    getNotifications();

  }


   Future<void> verifyPhone(Users user,context)async {
     setUser(user);
    print('${user.phone}');
    print('${user.name}');
    print('${user.email}');

    code = await auth.verifyPhone(user, context);
     print('ttttttttttt${code}');

     notifyListeners();
     print('ssssssssssssss${code}');

  }

  Future<void> verifyCode(context, String smsCode) async {
     await auth.verifyCode(context,code, smsCode,user);
     notifyListeners();
  }

  void setUser(Users userNew) {
    user.name = userNew.name;
    user.email = userNew.email;
    user.phone = userNew.phone;
    notifyListeners();
  }

  Future<List> getNotifications() async {
    notifications = await _auth.getNotifications(user.uid);
    // username = user.name!;
    notifyListeners();
    // print('apppppppppppppppppppppppp ${appointments.length}');
    return notifications;
  }
  Future<void> sendNotification(notification) async {
    await _auth.sendNotifications(notification);
    // username = user.name!;
    getNotifications();
    notifyListeners();





}



}