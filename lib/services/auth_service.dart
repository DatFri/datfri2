import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class Auth {
  Future<String> verifyPhone(String number, BuildContext context) async {
    String code = "";
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '$number',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        Navigator.pushNamed(context, 'verify');
        code = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    return code;
  }

  Future<void> verifyCode(context, String code , String smsCode) async {
    try{
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: code, smsCode: smsCode);
      print("oneeeeeeeeee "+ code);
      print("oneeeeeeeeee "+ smsCode);
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushNamedAndRemoveUntil(context, "home", (route) => false);
    }catch(e){
     print("Wrong Otp");
    }


  }
}
