import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(

            height: MediaQuery.of(context).size.height*0.3,

            decoration: BoxDecoration(
                color: Colors.black,

              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)
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
