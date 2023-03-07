import 'dart:async';

import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../providers/auth_provider.dart';


class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  late TextEditingController textEditingController;
  bool isVerified = false;
  bool canResend = false;
  Timer? timer;
  Duration myDuration = Duration(minutes: 1);
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  String phone = "9900265566";
  String time = "00:59";
  int seconds = 00;



  final formKey = GlobalKey<FormState>();

  String _comingSms = 'Unknown';

  Future<void> initSmsListener() async {

    String? comingSms;
    try {
      comingSms = await AltSmsAutofill().listenForSms;
    } on PlatformException {
      comingSms = 'Failed to get Sms.';
    }
    if (!mounted) return;
    setState(() {
      _comingSms = comingSms!;
      print("====>Message: ${_comingSms}");
      print("${_comingSms[0]}");
      textEditingController.text = _comingSms[0] + _comingSms[1] + _comingSms[2] + _comingSms[3]
          + _comingSms[4] + _comingSms[5]; //used to set the code in the message to a string and setting it to a textcontroller. message length is 38. so my code is in string index 32-37.
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    textEditingController = TextEditingController();
       initSms();
    initSmsListener();
  }
  @override
  void dispose() {
    textEditingController.dispose();
    AltSmsAutofill().unregisterListener();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double topHeight = MediaQuery.of(context).size.height * 0.3;
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    final authProvider = Provider.of<AuthProvider>(context);


    return Scaffold(
        resizeToAvoidBottomInset:false,
        body: SizedBox(
            height: totalHeight,
            child: Stack(children: [

              SizedBox(
                height: totalHeight,
                child: Column(
                  children: [
                    Container(
                      // color: Color(0x088F81).withOpacity(0.8),
                      color: Colors.transparent,
                      height: topHeight,


                    ),
                    //white container
                    Expanded(
                      child: Container(
                        width: totalWidth,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30.0),
                              topLeft: Radius.circular(30.0),
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                "Enter OTP!",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff033934),
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            // const Padding(
                            //   padding: EdgeInsets.all(8.0),
                            //   child: Text(
                            //     "Enter OTP",
                            //     style: TextStyle(
                            //         fontSize: 14,
                            //         color: Color(0xff7FA89C),
                            //         fontWeight: FontWeight.w400,
                            //         decoration: TextDecoration.none),
                            //     textAlign: TextAlign.center,
                            //   ),
                            // ),
                            const SizedBox(height: 10),

                            Expanded(
                                child: Container(
                                  color: Colors.white,

                                  width: totalWidth,
                                  // padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child:
                                        Form(
                                          key: formKey,
                                          child: Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  vertical: 2.0,
                                                  horizontal:
                                                  30),
                                              child:
                                              PinCodeTextField(
                                                appContext:
                                                context,
                                                pastedTextStyle:
                                                const TextStyle(
                                                  color: Color(0xFC080D0C),
                                                  fontWeight:
                                                  FontWeight
                                                      .bold,
                                                ),
                                                textStyle: TextStyle(
                                                    color: Color(0xFC080D0C)
                                                ),

                                                length: 6,
                                                obscureText:
                                                true,
                                                obscuringCharacter:
                                                '*',

                                                blinkWhenObscuring:
                                                true,
                                                animationType:
                                                AnimationType
                                                    .fade,
                                                // validator: (v) {
                                                //   if (v!.length < 3) {
                                                //     return "I'm from validator";
                                                //   } else {
                                                //     return null;
                                                //   }
                                                // },
                                                pinTheme:
                                                PinTheme(

                                                  inactiveColor:const Color(0x1b0e1110) ,
                                                  inactiveFillColor: const Color(0x1b0e1110),
                                                  selectedFillColor: const Color(0x1b0e1110),
                                                  selectedColor:  const Color(0xFC080D0C),
                                                  activeColor: Color(0xFC080D0C),
                                                  shape:
                                                  PinCodeFieldShape
                                                      .box,
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      10),
                                                  fieldHeight:
                                                  60,
                                                  fieldWidth:
                                                  40,
                                                  activeFillColor:
                                                  const Color.fromRGBO(8, 143, 129, 0.08)                                                ,
                                                ),
                                                cursorColor:
                                                const Color.fromRGBO(8, 143, 129, 0.08),
                                                animationDuration:
                                                const Duration(
                                                    milliseconds:
                                                    300),
                                                enableActiveFill:
                                                true,
                                                keyboardType:
                                                TextInputType
                                                    .number,
                                                controller: textEditingController,
                                                onCompleted:
                                                    (v) {
                                                  debugPrint(
                                                      "Completed");
                                                },
                                                // onTap: () {
                                                //   print("Pressed");
                                                // },
                                                onChanged:
                                                    (value) {
                                                  debugPrint(
                                                      value);
                                                  setState(() {
                                                    currentText =
                                                        value;
                                                  });
                                                },
                                                beforeTextPaste:
                                                    (text) {
                                                  debugPrint(
                                                      "Allowing to paste $text");
                                                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                                  return true;
                                                },
                                              )
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "OTP sent to ${authProvider.phoneNumber}",style: TextStyle(color:  Color(0xFC080D0C)),),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.access_time_filled_rounded ,color: Color(0xFC080D0C),),
                                          Text("00:${seconds}",style: TextStyle(color: Color(0xFC080D0C)),)
                                        ],
                                      ),


                                    ],
                                  ),





                                )),
                            // SizedBox(
                            //   height: 140,
                            // ),
                            Container(
                              width: 140,
                              height: 40,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      )),
                                  shadowColor: MaterialStateProperty.all<Color>(
                                      Color.fromRGBO(8, 143, 129, 0.4)),
                                  elevation:
                                  MaterialStateProperty.all<double>(20),
                                ),
                                onPressed: () async {
                                  formKey.currentState?.save();
                                  print("jjjj "+ currentText);

                                  await authProvider.verifyCode(context,currentText);
                                  timer!.cancel();
                                },
                                child: Text(
                                  'Login',
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 40,
                            )


                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ])));
  }
  void startTimer() {
    timer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }
  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds == 0) {
        timer!.cancel();

      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  Future<void> initSms() async {
    await SmsAutoFill().listenForCode();

  }
}
