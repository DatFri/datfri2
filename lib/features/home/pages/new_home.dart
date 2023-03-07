

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';

import '../../../keys.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/places_provider.dart';
import '../../../services/local_auth_fingerprint.dart';
import '../../appointment/pages/appointment_page.dart';
import '../../nearby_places/pages/nearby_places.dart';
import '../../palette.dart';
import '../../share/pages/share_page.dart';
import '../../wallet/pages/wallet_page.dart';
import 'data.dart';



class HomePage extends StatefulWidget {
   HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {

    final places = Provider.of<PlacesProvider>(context);
    final users = Provider.of<AuthProvider>(context);

    return SafeArea(
        child: Scaffold(
          body: Stack(
              children: [
                // Positioned(
                //   left: -45,
                //   top: -45,
                //   child: Container(
                //     height: 100,
                //     width: 100,
                //     decoration: BoxDecoration(
                //         color: Palette.primaryDartfri,
                //         borderRadius: BorderRadius.circular(100)
                //     ),
                //   ),
                // ),
                // Container(
                //   padding: EdgeInsets.fromLTRB(10, 0, 30, 0),
                //   height: 100,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       SizedBox(
                //           height: 130,width: 130,
                //           child: Image.asset('assets/logo_noback.png')),
                //       Icon(CupertinoIcons.bell,size: 30,color: Palette.primaryDartfri,)
                //
                //     ],
                //   ),
                // ),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),

                        Container(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),

                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(

                                  children: [
                                    Icon(Icons.location_pin,color: Palette.primaryDartfri,size: 20,),
                                    SizedBox(width: 20,),
                                    Text("${users.currentAddress}",style: TextStyle(height: 0.6),),
                                  ],
                                ),

                                TextButton(onPressed:(){}, child:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextButton(onPressed: () async {
                                      Prediction? p = await PlacesAutocomplete.show(
                                          offset: 0,
                                          radius: 1000,
                                          strictbounds: false,
                                          region: "ng",
                                          language: "en",
                                          context: context,
                                          mode: Mode.overlay,
                                          apiKey: Keys.kGoogleApiKey,
                                          sessionToken: Keys.sessionToken,
                                          components: [new Component(Component.country, "ng")],
                                          types: ["(cities)"],
                                          hint: "Search City",
                                          startText: places.city == null || places.city == "" ? "" : places.city
                                      );
                                      _getLatLng(p!,places);

                                    }, child: Row(
                                      children: [
                                        Text("Change",style: TextStyle(height:0.6,fontSize: 12),),
                                        Icon(Icons.arrow_drop_down,size: 25,)

                                      ],
                                    ))
                                    ,
                                  ],

                                )
                                )
                              ]
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width,
                          height: 190,
                          decoration: BoxDecoration(
                              color: Palette.primaryDartfri,
                              borderRadius: BorderRadius.circular(20)
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (users.username) != '' ? Text('Welcome Back , ${users.user.name?.split(' ')[0]}!',style: TextStyle(fontSize: 22,color: Colors.white),):
                              Text('Welcome Back , !',style: TextStyle(fontSize: 22,color: Colors.white),),
                              SizedBox(height: 10,),
                              SizedBox(
                                height: 70,
                                child:
                              GridView.builder(
                                itemCount: BarData.datas.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return  GestureDetector(
                                    onTap: () async {
                                  if (index == 0){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>WalletPage()));
                                  }else if (index == 1){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SharePage()));
                                  }else{
                                    if (isVisible == false){
                                      final isAuthenticated = await LocalAuthApi.authenticate();

                                      if (isAuthenticated) {

                                        setState(() {
                                          isVisible = !isVisible;
                                        });
                                      }
                                    }else{
                                    setState(() {
                                      isVisible = !isVisible;
                                    });


                                  }}}
                                    ,
                                    child: SizedBox(
                                      // height: 70,
                                      child: Column(
                                        children: [
                                          Container(
                                                      height:50,
                                                width: 50,
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  // color: Color(0xFFD3FBFF),
                                                  borderRadius: BorderRadius.circular(100),
                                                  color: Palette.secondaryDartfri,
                                                  // border: Border.all(color: Palette.primaryDartfri,width: 1.5),

                                                ),
                                                child: Center(

                                                    child:
                                                        Container(
                                                          height:20,

                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(100),
                                                            // color: Color(0x76D4D6D6),

                                                            // color: HomeData.datas[index].boxColor,
                                                          ),
                                                          child: (index != 2) ? BarData.datas[index].boxIcon :
    isVisible ?  Icon(Icons.visibility,size: 30,color: Palette.primaryDartfri,):
     Icon(Icons.visibility_off_outlined,size: 30,color: Palette.primaryDartfri,)),



                                                    )),

                                          Text(BarData.datas[index].text,style: TextStyle(fontSize: 12,color: Palette.secondaryDartfri),)

                                        ],
                                      ),
                                       )
                                    );

                                },

                              ),),
                              isVisible ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.center,
                                    child: Text('Balance : 60000',style: TextStyle(fontSize: 20,color: Palette.secondaryDartfri),)),
                              ):Container()

                            ],
                          ),
                        ),
                        // SizedBox(height: 10,),
                        // Text('Quick Services'),
                        // SizedBox(height: 10,),
                        //
                        // Container(
                        //   child: Row(
                        //     children: [
                        //       GestureDetector(
                        //         onTap: (){
                        //           Navigator.push(context, MaterialPageRoute(builder: (context)=>WalletPage()));
                        //         },
                        //         child: Card(
                        //           elevation: 8,
                        //           shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(20)
                        //           ),
                        //           child: Container(
                        //               width: 120,
                        //               height: 80,
                        //               padding: EdgeInsets.all(10),
                        //               decoration: BoxDecoration(
                        //                 // color: Color(0xFFD3FBFF),
                        //                 // color: Palette.primaryDartfri,
                        //                 border: Border.all(color: Palette.primaryDartfri,width: 1.5),
                        //                 borderRadius: BorderRadius.circular(20),
                        //
                        //               ),
                        //               child: Center(
                        //                   child: Column(
                        //                     crossAxisAlignment: CrossAxisAlignment.center,
                        //                     children: [
                        //                       Container(
                        //                         height:30,
                        //
                        //                         decoration: BoxDecoration(
                        //                           borderRadius: BorderRadius.circular(100),
                        //                           // color: Color(0xFFD3FBFF),
                        //
                        //                           // color: ,
                        //                         ),
                        //                         child: Image.asset('assets/wallet.png'),
                        //                       ),
                        //                       Text('Top Up Wallet',style: TextStyle(fontSize: 12),)
                        //                     ],
                        //                   ))),
                        //         ),
                        //       ),
                        //
                        //
                        //     ],
                        //   ),
                        // ),
                        SizedBox(height: 20,),
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Our Services',style: TextStyle(fontSize: 15),),
                              SizedBox(height: 10,),
                              Expanded(child:
                              SizedBox(
                                height: 70,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  elevation: 8,
                                  child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        // color: Color(0xFFD3FBFF),
                                        // color: Palette.primaryDartfri,
                                        // border: Border.all(color: Palette.primaryDartfri,width: 1.5),

                                      ),
                                      child: Center(

                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height:50,

                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(100),
                                                  color: Color(0x76D4D6D6),

                                                  // color: HomeData.datas[index].boxColor,
                                                ),
                                                child: Image.asset('assets/Car wash.png'),
                                              ),
                                              SizedBox(height: 20,),

                                              Text('Car Wash')
                                            ],
                                          ))),
                                ),
                              ),
                              // GridView.builder(
                              //   itemCount: 1,
                              //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              //     crossAxisCount: 1,
                              //     mainAxisSpacing: 15,
                              //     crossAxisSpacing: 15,
                              //   ),
                              //   itemBuilder: (BuildContext context, int index) {
                              //     return (index == 3 || index == 5 ) ? Container():GestureDetector(
                              //       onTap: (){
                              //         (index == 0 ) ? Navigator.push(context, MaterialPageRoute(builder: (context)=>NearbyPlaces())):
                              //         Navigator.push(context, MaterialPageRoute(builder: (context)=>WalletPage()));
                              //       },
                              //       child: SizedBox(
                              //         height: 100,
                              //         child: Card(
                              //           shape: RoundedRectangleBorder(
                              //             borderRadius: BorderRadius.circular(20)
                              //           ),
                              //           elevation: 8,
                              //           child: Container(
                              //               padding: EdgeInsets.all(10),
                              //               decoration: BoxDecoration(
                              //                 // color: Color(0xFFD3FBFF),
                              //                 // color: Palette.primaryDartfri,
                              //                 // border: Border.all(color: Palette.primaryDartfri,width: 1.5),
                              //
                              //               ),
                              //               child: Center(
                              //
                              //                   child: Column(
                              //                     crossAxisAlignment: CrossAxisAlignment.center,
                              //                     mainAxisAlignment: MainAxisAlignment.center,
                              //                     children: [
                              //                       Container(
                              //                         height:80,
                              //
                              //                         decoration: BoxDecoration(
                              //                           borderRadius: BorderRadius.circular(100),
                              //                           color: Color(0x76D4D6D6),
                              //
                              //                           // color: HomeData.datas[index].boxColor,
                              //                         ),
                              //                         child: Image.asset(HomeData.datas[index].boxIcon),
                              //                       ),
                              //                       SizedBox(height: 20,),
                              //
                              //                       Text(HomeData.datas[index].text,style: TextStyle(fontSize: 12),)
                              //                     ],
                              //                   ))),
                              //         ),
                              //       ),
                              //     );
                              //   },
                              //
                              // ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Popular Car Wash Nearby',style: TextStyle(fontWeight: FontWeight.w600),),
                            Row(
                              children: [
                                TextButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>NearbyPlaces()));

                                }, child:  Text('see all',style: TextStyle(fontWeight: FontWeight.w600),),
                                ),
                                Icon(Icons.arrow_forward_ios,size: 15,)
                              ],
                            ),


                          ],
                        ),
                        Container(
                          height: 180,
                          child:

                          ListView.builder(
                            itemCount: places.places.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return AppointmentFormPage(place: places.places[index]);
                                      }),
                                    );
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>NearbyPlaces()));
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(5),
                                      width: 160,
                                      height: 190,
                                      decoration: BoxDecoration(
                                        // color: Color(0xFFD3FBFF),
                                        // color: Palette.primaryDartfri,
                                        // border: Border.all(color: Palette.primaryDartfri,width: 1.5),
                                        borderRadius: BorderRadius.circular(20),

                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: CachedNetworkImageProvider(
                                                      '${places.places[index].imgUrl}',
                                                    ),
                                                    fit: BoxFit.cover),
                                                borderRadius: BorderRadius.circular(10)),
                                            height: 90,
                                            width: 150,
                                          ),
                                          SizedBox(height: 5,),

                                          Text(places.places[index].name!,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600),),
                                          SizedBox(height: 5,),
                                          Row(
                                            children: [
                                              Icon(Icons.location_on_outlined),
                                              Text(places.places[index].address!,style: TextStyle(fontSize: 12),),
                                            ],
                                          ),
                                          SizedBox(height: 5,),
                                          RatingBarIndicator(
                                            rating: double.parse(places.places[index].rating!),
                                            itemBuilder: (context, index) => Icon(
                                              Icons.star,
                                              color: Palette.primaryDartfri,
                                            ),
                                            itemCount: 5,
                                            itemSize: 15.0,
                                            direction: Axis.horizontal,
                                          )
                                        ],
                                      ))
                              );
                            },

                          ),),
                        Text('Special Packages and Offers',style: TextStyle(fontWeight: FontWeight.w600),),
                        SizedBox(height: 10,),
                        Container(
                          height: 120,
                          child:

                          ListView.builder(
                            itemCount: places.offers.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: (){
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>NearbyPlaces()));
                                  },
                                  child: Stack(
                                      children: [


                                        Container(
                                            padding: EdgeInsets.all(5),
                                            width: 250,
                                            height: 120,
                                            decoration: BoxDecoration(
                                              // color: Color(0xFFD3FBFF),
                                              // color: Palette.primaryDartfri,
                                              // border: Border.all(color: Palette.primaryDartfri,width: 1.5),
                                              borderRadius: BorderRadius.circular(20),

                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(

                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: CachedNetworkImageProvider(
                                                            '${places.offers[index].imgUrl}',
                                                          ),
                                                          fit: BoxFit.cover),
                                                      borderRadius: BorderRadius.circular(10)),
                                                  height: 110,
                                                  width: 250,
                                                ),

                                              ],
                                            )),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          height:90,

                                          child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [Container(
                                                child: Text('${places.offers[index].title}',style: TextStyle(color: Colors.white),),

                                              ),
                                                Container(
                                                  child: Text('${places.offers[index].place}',style: TextStyle(color: Colors.white),),

                                                ),
                                                Container(
                                                  child: Text('${places.offers[index].off} off',style: TextStyle(color: Colors.white),),

                                                ),
                                              ]
                                          ),
                                        ),
                                      ]
                                  )
                              );
                            },

                          ),),

                      ],
                    ),

                  ),
                ),
              ]

          ),
        ));
  }

  void _getLatLng(Prediction prediction,places) async {
    GoogleMapsPlaces _places = new
    GoogleMapsPlaces(apiKey:  Keys.kGoogleApiKey);  //Same API_KEY as above
    PlacesDetailsResponse detail =
    await _places.getDetailsByPlaceId(prediction.placeId!);
    double latitude = detail.result.geometry!.location.lat;
    double longitude = detail.result.geometry!.location.lng;
    String? address = prediction.description;
    places.setCity(address);
  }
}
