
import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:bay/services/auth_service.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../palette.dart';
import '../models/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'UG';
  PhoneNumber number = PhoneNumber(isoCode: 'UG');
  String phone = "77 303 4565";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double topHeight = MediaQuery.of(context).size.height*0.3;
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;

    final authProvider = Provider.of<AuthProvider>(context);


    return Scaffold(
      // resizeToAvoidBottomInset:false,
      body: SizedBox(

          height: totalHeight ,

          child: Form(
            key: formKey,
            child: Column(
              children: [
               SizedBox(height: MediaQuery.of(context).size.height*0.2,),



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
                            child: Container(
                              padding: EdgeInsets.all(20),
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
                                      SizedBox(
                                        height: 70,
                                        child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          controller: _nameController,
                                          validator: (name) =>
                                          name != '' ? null : "Enter full name",
                                          decoration: InputDecoration(
                                            labelText: 'Full name',
                                            hintText: 'John Doe',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20)
                                            ),
                                            // Here is key idea
                                            suffixIcon: IconButton(
                                              icon: Icon(Icons.person_outline),
                                              color: Colors.grey,
                                              onPressed: () {},
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10,),

                                      SizedBox(
                                        height: 70,
                                        child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          controller: _emailController,
                                          validator: (email) =>
                                          email != null && EmailValidator.validate(email.trim())
                                              ? null
                                              : "Enter valid Email",
                                          decoration: InputDecoration(
                                            labelText: 'Email Address',
                                            hintText: 'johndoe@gmail.com',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20)
                                            ),

                                            // Here is key idea
                                            suffixIcon: IconButton(
                                              icon: Icon(Icons.email_outlined),
                                              color: Colors.grey,
                                              onPressed: () {},
                                            ),
                                          ),
                                        ),
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
                                          // Padding(
                                          //   padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                          //   child: Text("Enter Phone Number",style: TextStyle(color: Colors.black,fontFamily: 'Poppins',fontWeight: FontWeight.w400,fontSize: 20,decoration: TextDecoration.none),),
                                          // ),
                                          SizedBox(height: 10,),
                                          Stack(
                                              children:[
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                  decoration: BoxDecoration(
                                                    // border: Border.all(color: Colors.grey)
                                                  ),
                                                  child: InternationalPhoneNumberInput(


                                                    onInputChanged: (PhoneNumber number) {
                                                      print(number.phoneNumber);
                                                      phone = number.phoneNumber!;

                                                    },
                                                    // onInputValidated: (bool value) {
                                                    //   print(value);
                                                    // },
                                                    selectorConfig: const SelectorConfig(
                                                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                                                    ),
                                                    hintText: "772024843",
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
                                                      print('On Saved: $number');
                                                    },
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 10,
                                                  left: 90,
                                                  height: 30,
                                                  child: VerticalDivider(
                                                    color: Palette.primaryDartfri,
                                                    thickness: 0.8,
                                                  ),
                                                )
                                              ]
                                          ),

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


                                          await login(authProvider);

                                                                       },
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
                                        Navigator.pushNamed(context, 'verify');

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
                      ),

                    ],
                  ),
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

  Future<void> login( authProvider) async {
    final isValid = formKey.currentState!.validate();
    if(isValid){
      Users user = Users();
      user.phone = phone;
      user.email = _emailController.text.trim();
      user.name = _nameController.text.trim();
      authProvider.setPhone(phone);

      formKey.currentState?.save();
       await authProvider.verifyPhone(user,context,);
    } else {
      BotToast.showText(text: "Fill all field correctly");
    }

  }

}
