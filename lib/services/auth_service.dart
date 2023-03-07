import 'package:bay/features/dashboard/pages/dashboard.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

import '../features/auth/models/user.dart';
import '../features/notifications/models/notifications.dart';

class Auth {
  final _auth = FirebaseAuth.instance;
   late String Vcode;



  Future<String> verifyPhone(Users user, BuildContext context) async {

    showDialog(context: context,barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));


     int? resendToken = 0;


    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '${user.phone}',
      verificationCompleted: (PhoneAuthCredential credential) async {

      },
      timeout: const Duration(seconds: 60),
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
          BotToast.showText(text: 'The provided phone number is not valid');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        Vcode = verificationId;
        resendToken = resendToken;
        print('dddddddddddddddddddddddd$verificationId');

        Navigator.pop(context);
        Navigator.pushNamed(context, 'verify');
      },
      forceResendingToken: resendToken,

      codeAutoRetrievalTimeout: (String verificationId) {},

    );
    print('dddddddddddddddddddddddd$Vcode');
    return Vcode;

  }

  Future<void> verifyCode(context, String code , String smsCode, Users user) async {
   print('ttttttttttttt${Vcode}----$smsCode -----${user.phone}');
    showDialog(context: context,barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    try{
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: Vcode, smsCode: smsCode);
      print("oneeeeeeeeee "+ Vcode);
      print("oneeeeeeeeee "+ smsCode);
      await FirebaseAuth.instance.signInWithCredential(credential)
    .then(
    (value) => postDetailsToFirestore(user,context) )
        .catchError((e)=>BotToast.showText(text: "$e"));
      Navigator.pushNamedAndRemoveUntil(context, "location", (route) => false);
    }catch(e){
     print("Wrong Otp");
    }


  }
  postDetailsToFirestore(Users users,context) async {
    User? user=_auth.currentUser;
    // users.email = user!.email;
    users.uid = user!.uid;


    Navigator.pushNamedAndRemoveUntil(context, "location", (route) => false);

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    // box1.put('userid', user!.uid);

    await firebaseFirestore
        .collection("users")
        .doc(users.uid)
        .set(users.toJson());
    BotToast.showText(text: "Account created successfully :) ");


  }
  Future<Users> getUserDetails() async {
    late Users doc ;
    //     builder: (context) => const Center(child: CircularProgressIndicator()));
    // final prefs = await SharedPreferences.getInstance();
    // final userid = prefs.getString('userid');
    // final username = prefs.getString('username');
    // final photoUrl = prefs.getString('photoUrl');

    try{
      FirebaseFirestore mFirebaseFirestore = FirebaseFirestore.instance;

      await mFirebaseFirestore.collection('users')
          .where('uid', isEqualTo: _auth.currentUser?.uid)
          .get()
          .then((snapshot)  async {
        doc =  Users.fromJson(snapshot.docs[0].data()) ;
      });

    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    // navigatorKey.currentState!.popUntil((route)=>route.);
    // print(doc['nin']);
    return doc;
  }

  Future<void> sendNotifications(Notifications notification) async {

    try{
      await FirebaseFirestore.instance
          .collection("notifications")
          .add(notification.toJson())
          .catchError((e){
        BotToast.showText(text: e!.message);
      });
    }catch(e){
      BotToast.showText(text:"Failed to post notification");
    }

    // Fluttertoast.showToast(msg: "Account created successfully :) ");

  }
  Future<List<Notifications>>  getNotifications(userId) async {
    List<Notifications>  notifications= [];
    try{
      await FirebaseFirestore.instance
          .collection("notifications").where(
          "userId" ,whereIn: <String>[userId, 'all'] )
          .get()
          .then((snapshot) {
        snapshot.docs.forEach((doc) {
          Notifications notification = Notifications.fromJson(
              Map<String, dynamic>.from(doc.data()));
          notifications.add(notification);

        });
      })
          .catchError((e){
        BotToast.showText(text: e!.message);

      });
    }catch(e){
      BotToast.showText(text: "Failed to get appointments");

    }
    return notifications;
  }
}
