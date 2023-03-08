import 'dart:ui';

import 'package:flutter/material.dart';

class HomeData{
    Color boxColor;
    String boxIcon;
    String text;

    HomeData(this.text,this.boxColor,this.boxIcon);
    static List<HomeData> datas = [
        HomeData('Car Wash', Color(0xFFCBE11E), 'assets/Car wash.png'),
        HomeData('Top Up Wallet', Color(0xFFE11ECB), 'assets/wallet.png'),
        // HomeData('Engine Wash', Color(0xFF90D161), 'assets/Car engine.png'),
        //
        //
        // HomeData('Car Service', Color(0xFFE1341E), 'assets/service.png'),
    ];
}

class BarData{
    Icon boxIcon;
    String text;

    BarData(this.text,this.boxIcon);
    static List<BarData> datas = [
       BarData('Top Up', Icon(Icons.add,size: 20,)),
        BarData('Share', Icon(Icons.share,size: 18,)),
        BarData('Balance', Icon(Icons.visibility_off_outlined))

        //
        //
        // HomeData('Car Service', Color(0xFFE1341E), 'assets/service.png'),
    ];
}

