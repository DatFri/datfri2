import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
      child: Column(
        children: [
          // SizedBox(
          //   height: 10,
          // ),
          Container(

            height: MediaQuery.of(context).size.height*0.3,

            decoration: BoxDecoration(
                color: Colors.black,

              borderRadius: BorderRadius.only(
                // topRight: Radius.circular(20),
                bottomLeft: Radius.elliptical(150, 30),
                // bottomRight: Radius.circular(20)
                bottomRight: Radius.elliptical(150, 30),

              )
            ),
          ),
    //       Container(
    //
    //         decoration: BoxDecoration(
    //             color: Colors.red,
    //             borderRadius: BorderRadius.circular(20)
    //       )
    // )

]
    ));
  }
}
