import 'package:flutter/cupertino.dart';

import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier{

  var phoneNumber = '';
  String code = '';
  Auth auth = Auth();
  AuthProvider(){
     // auth =  Auth();
  }
  void setPhone(String number){
    phoneNumber = number;
    notifyListeners();
  }
   Future<void> verifyPhone(String number,context)async {
    code = await auth.verifyPhone(number, context);
    notifyListeners();

  }

  Future<void> verifyCode(context, String smsCode) async {
     await auth.verifyCode(context,code, smsCode);
     notifyListeners();
  }






}