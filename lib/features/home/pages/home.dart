// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../card.dart';
//
// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var widthSize = MediaQuery.of(context).size.width;
//     var heightSize = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//         backgroundColor: Colors.black,
//       // padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
//       body: SafeArea(
//         child: Container(
//           // padding: EdgeInsets.all(20),
//           child: Stack(
//             children: [
//               Container(
//                 color: Colors.black,
//               ),
//
//               Container(
//                 width: widthSize,
//                   child: Column(
//                     children: [
//                       Container(
//                         height:heightSize*0.01 ,
//                         color: Colors.transparent,
//                       ),
//                       Expanded(
//                         child: Container(
//                           padding: EdgeInsets.all(20),
//                             width: widthSize,
//                           decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 begin:Alignment.bottomLeft ,
//                                 end: Alignment.topRight,
//                                 colors: [
//                                   Colors.grey.shade200,
//                                   Colors.white,
//                                 ],
//                               ),
//                               // color: Color.fromRGBO(205, 205, 205,
//                               //     1.0),
//
//                               borderRadius: BorderRadius.only(
//                                 // topRight: Radius.circular(20),
//                                 topLeft: Radius.circular(50),
//                                 // bottomRight: Radius.circular(20)
//                                 topRight: Radius.circular(50),
//
//
//                               )
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(height: 10,),
//                               Text("Welcome to Datfri!",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
//                               SizedBox(height: 10,),
//                               Text("Need a car wash today?",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
//                               SizedBox(height: 30,),
//                               Text("What next?",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
//
//                               Container(
//                                 height: 100,
//                                           child:Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                             children: [
//                                               itemCard(index : 0),
//                                               itemCard(index : 1),
//                                               itemCard(index : 2),
//                                               itemCard(index : 3),
//                                             ],
//                                           ))
//
//
//                                   ],
//                                 ),
//
//
//                         ),
//                       ),
//                     ],
//                   ),
//                 // width: MediaQuery.of(context).size.width,
//                 //
//                 // height: MediaQuery.of(context).size.height*0.7,
//
//
//               ),
//     //         Container(
//     //           height: 200,
//     //            width: widthSize,
//     //            child: Text('hi'),
//     //           decoration: BoxDecoration(
//     //               color: Colors.grey,
//     //               borderRadius: BorderRadius.circular(20)
//     //         )
//     // )
//
// ]
//     ),
//         ),
//       ));
//   }
// }
//
// class itemCard extends StatelessWidget {
//   const itemCard({
//     Key? key, required this.index,
//   }) : super(key: key);
// final int index;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(10),
//
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Cards.cards[index][1] as IconData),
//           SizedBox(height: 10,),
//           Text( Cards.cards[index][2] as String ,style: TextStyle(fontSize: 10),)
//         ],
//       ),
//       height: 80,
//       width: 80,
//       decoration: BoxDecoration(
//         color: Cards.cards[index][0] as Color,
//         borderRadius: BorderRadius.circular(20),
//       ),
//     );
//   }
// }
