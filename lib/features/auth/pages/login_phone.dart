
import 'package:bay/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'UG';
  PhoneNumber number = PhoneNumber(isoCode: 'UG');
  String phone = "77 303 4565";
  @override
  Widget build(BuildContext context) {
    double topHeight = MediaQuery.of(context).size.height*0.3;
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;

    final authProvider = Provider.of<AuthProvider>(context);


    return Scaffold(
      // resizeToAvoidBottomInset:false,
      body:SizedBox(

          height: totalHeight ,

          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  // color: Colors.transparent,
                  color: Color(0xFC080D0C),

                  image: DecorationImage(

                    image: AssetImage("assets/logo_black.jpg"),
                    fit: BoxFit.contain,
                  ),
                ),
                height: totalHeight*0.32,

                // color: Colors.brown,

              ),
              Container(
                color: const Color(0xF7070908).withOpacity(0.3),
              ),
              SizedBox(

                child: Column(
                  children: [
                    Container(
                      // color: Color(0x088F81).withOpacity(0.8),
                      color: Colors.transparent,
                      height: topHeight,

                    ),

                    Expanded(

                      child: Container(
                        height: totalHeight-totalHeight,
                        // width:totalWidth ,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30.0),
                              topLeft: Radius.circular(30.0),
                            )),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,

                            children:  [

                              Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Text("Hi!",style:TextStyle(fontSize: 25,color:Colors.black,decoration: TextDecoration.none,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Let's Get Started",style:TextStyle(fontSize: 18,color:Colors.black,fontWeight: FontWeight.w400,decoration: TextDecoration.none),textAlign: TextAlign.center,),
                                  ),
                                ],
                              ),


                             Container(
                                  width: totalWidth,
                                  padding: EdgeInsets.all(20),
                                  // padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                        child: Text("Enter Phone Number",style: TextStyle(color: Colors.black,fontFamily: 'Poppins',fontWeight: FontWeight.w400,fontSize: 20,decoration: TextDecoration.none),),
                                      ),
                                      SizedBox(height: 10,),
                                      Stack(
                                        children: [

                                          Positioned(

                                            top: -12,
                                            right: 0,
                                            left: 0,

                                            child: Container(
                                              // top : 100,
                                              height: 50,
                                              width: totalWidth ,
                                              padding: EdgeInsets.all(20),
                                              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                              decoration: BoxDecoration(
                                                  color: const Color(0x1b0e1110),
                                                  borderRadius: const BorderRadius.all( Radius.circular(8)

                                                  ),
                                                  border: Border.all(color: const Color(
                                                      0xff040605)

                                                  )

                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: totalWidth ,
                                            height: 70,
                                            padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                                            child: InternationalPhoneNumberInput(


                                              onInputChanged: (PhoneNumber number) {
                                                print(number.phoneNumber);
                                                phone = number.phoneNumber!;
                                              },
                                              onInputValidated: (bool value) {
                                                print(value);
                                              },
                                              selectorConfig: const SelectorConfig(
                                                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                                              ),
                                              hintText: "77 394 5654",
                                              ignoreBlank: false,
                                              autoValidateMode: AutovalidateMode.disabled,
                                              selectorTextStyle: TextStyle(color: Colors.black),
                                              initialValue: number,
                                              textFieldController: controller,
                                              formatInput: false,
                                              inputBorder: InputBorder.none,
                                              keyboardType:
                                              TextInputType.numberWithOptions(signed: true, decimal: true),
                                              onSaved: (PhoneNumber number) {
                                                // print('On Saved: $number');
                                              },
                                            ),
                                          ),

                                          Positioned(
                                            top: 17,
                                            left: 100,
                                            height: 30,
                                            child: VerticalDivider(
                                              color: Color(0xff09100e),
                                              thickness: 0.5,
                                            ),
                                          )




                                        ],
                                      )
                                    ],
                                  ),
                                ),

                              SizedBox(height: 30,),
                              Container(
                                width: 140,
                                height: 40,


                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(

                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        )
                                    ),

                                    shadowColor:MaterialStateProperty.all<Color>(Color.fromRGBO(8, 143, 129, 0.4)) ,
                                    elevation: MaterialStateProperty.all<double>(20),

                                  ),
                                  onPressed: () async {
                                    // formKey.currentState?.save();
                                    formKey.currentState?.save();
                                    await authProvider.verifyPhone(phone,context);
                                    authProvider.setPhone(phone);
                                    Navigator.pushNamed(context, 'verify');                                  },
                                  child: Text('Get OTP',),

                                ),
                              ),
                              TextButton(
                                  onPressed: ()  {
                                    // formKey.currentState?.save();
                                    // Auth auth = Auth();
                                    // await auth.verifyPhone(number.toString(),context);
                                    // print("hiiii" + number.toString());
                                    // authProvider.setPhone(number.toString());
                                    // Navigator.pushNamed(context, 'verify');

                                  },
                                  child: const Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: Text("Have a Pin?",style: TextStyle( color: Colors.transparent,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Color(0xff09100f),
                                          shadows: [Shadow(color:Color(
                                              0xff010404) , offset: Offset(0, -3))]),
                                      )

                                  )),

                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        ),

    );
  }
  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
    await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'UG');

    setState(() {
      this.number = number;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

}
