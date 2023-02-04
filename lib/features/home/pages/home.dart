import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widthSize = MediaQuery.of(context).size.width;
    return Scaffold(
      // padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [

              Container(
                  child: Center(
                    child: Text('Good Afternoon Emmilly',style: TextStyle(fontSize: 20,color: Colors.white),),
                  ),
                width: MediaQuery.of(context).size.width,

                height: MediaQuery.of(context).size.height*0.15,
                decoration: BoxDecoration(
                    color: Colors.black,

                  borderRadius: BorderRadius.only(
                    // topRight: Radius.circular(20),
                    bottomLeft: Radius.elliptical(275, 30),
                    // bottomRight: Radius.circular(20)
                    bottomRight: Radius.elliptical(275, 30),

                  )
                ),

              ),
            SizedBox(height: 10,),
            Container(
              height: 200,
               width: widthSize,
               child: Text('hi'),
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20)
            )
    )

]
    ),
        ),
      ));
  }
}
