import 'package:flutter/material.dart';



///..............Fonts....................
const String mainFontFamily = "Tajawal";


///..............Colors....................
const Color searchFieldFill1 = Color.fromRGBO(38, 43, 51, 1);
const Color searchFieldColor = Color.fromRGBO(15, 28, 27, 1);
const Color appPrimaryColorCart =Color.fromRGBO(38, 40, 51,0.6) ;
const Color appPrimaryColor =Color.fromRGBO(7, 40, 37,1) ;
const secondaryColor = Color.fromRGBO( 191, 160, 95,1);

const darkGreenColor = Color.fromRGBO(7, 40, 37, 1);


const Color appWhiteColor = Color(0xffffffff);
const Color appGreyColor = Color(0xffa1a1ae);
const Color lightGreyColor = Color(0xfff2f2f5);

Color errorColor = const Color.fromARGB(255, 231, 76, 60);
Color successColor = const Color.fromARGB(255, 46, 204, 113);

const lightBlueColor= Color(0xFF1A6EA0);
const darkBlueColor= Color(0xFF144870);

Color lightGreyBorder = Colors.grey.shade300;
Color lightBrownColor = const Color(0xD8F8DDD4);
Color yellowColor= const Color.fromARGB(255, 253, 255, 0);


const Color facebookColor = Color.fromARGB(249, 7, 80, 243);
const Color instagramColor =Colors.pink;
const Color twitterColor = Colors.blue;
const Color snapChatColor = Colors.amber;
const Color whatsappColor = Colors.green;

const Color searchFieldFill = Color.fromRGBO(38, 43, 51, 1);

/// Figma — شاشات Auth (Login / Register)
const Color authCreamBackground = Color(0xFFF5EBD8);
const Color authSagePanelColor = Color.fromRGBO(107, 128, 118, 1);

/// Figma — Coupon / Cubons
const Color couponProfileCardBg = Color.fromRGBO(12, 38, 34, 1);
const Color couponCardBg = Color.fromRGBO(10, 32, 28, 1);
const Color couponGold = Color.fromRGBO(206, 182, 132, 1);


///..............TextStyle....................


//main color (primary)
TextStyle mainPrimaryTextStyle =   TextStyle(fontSize: 24 ,fontWeight: FontWeight.w800,color: appPrimaryColor,fontFamily: mainFontFamily);
TextStyle mediumPrimaryTextStyle =  TextStyle(fontSize: 16 , fontWeight: FontWeight.w500, color: appPrimaryColor, fontFamily: mainFontFamily);
TextStyle smallPrimaryTextStyle =  TextStyle(fontSize: 14 ,color: appPrimaryColor,fontFamily: mainFontFamily);

// black
TextStyle bigBlackTextStyle =    TextStyle(fontSize: 26 ,fontWeight: FontWeight.bold,color: Colors.black,fontFamily: mainFontFamily);
TextStyle mainBlackTextStyle =   TextStyle(fontSize: 24 ,fontWeight: FontWeight.w600,color: Colors.black,fontFamily: mainFontFamily);
TextStyle mediumBlackTextStyle =  TextStyle(fontSize: 16 ,color: Colors.black,fontWeight: FontWeight.w400,fontFamily: mainFontFamily, overflow: TextOverflow.ellipsis);
TextStyle smallBlackTextStyle =  TextStyle(fontSize: 14 ,color: Colors.black,fontFamily: mainFontFamily);

// grey
TextStyle bigGreyTextStyle =    TextStyle(fontSize: 26 ,fontWeight: FontWeight.bold,color: appGreyColor,fontFamily: mainFontFamily);
TextStyle mainGreyTextStyle =   TextStyle(fontSize: 24 ,fontWeight: FontWeight.w800,color: appGreyColor,fontFamily: mainFontFamily);
TextStyle mediumGreyTextStyle = TextStyle(fontSize: 16 , color: appGreyColor, fontFamily: mainFontFamily, overflow: TextOverflow.ellipsis);
TextStyle smallGreyTextStyle =  TextStyle(fontSize: 14 ,color: appGreyColor,fontFamily: mainFontFamily);

// white
TextStyle bigWhiteTextStyle =    TextStyle(fontSize: 26 ,fontWeight: FontWeight.bold,color: appWhiteColor,fontFamily: mainFontFamily);
TextStyle mainWhiteTextStyle =   TextStyle(fontSize: 24 ,fontWeight: FontWeight.w800,color: appWhiteColor,fontFamily: mainFontFamily);
TextStyle appBarTextStyle =   TextStyle(fontSize: 20 ,fontWeight: FontWeight.bold,color: appWhiteColor,fontFamily: mainFontFamily);
TextStyle mediumWhiteTextStyle =  TextStyle(fontSize: 16 , fontWeight: FontWeight.w500, color: appWhiteColor, fontFamily: mainFontFamily);
TextStyle smallWhiteTextStyle =  TextStyle(fontSize: 14 , color: appWhiteColor, fontFamily: mainFontFamily);
TextStyle bestWhiteTextStyle =  TextStyle(fontSize: 22 , color: appWhiteColor, fontFamily: mainFontFamily,fontWeight: FontWeight.w600);

TextStyle bigTextStyle =    TextStyle(fontSize: 26 ,fontWeight: FontWeight.bold,fontFamily: mainFontFamily);
TextStyle mainTextStyle =   TextStyle(fontSize: 24 ,fontWeight: FontWeight.w800,fontFamily: mainFontFamily);
TextStyle mediumTextStyle =  TextStyle(fontSize: 16 , fontWeight: FontWeight.w500,fontFamily: mainFontFamily);
TextStyle smallTextStyle =  TextStyle(fontSize: 14 , fontFamily: mainFontFamily);

TextStyle smallHeaderTextStyle = TextStyle(fontFamily: mainFontFamily, fontSize: 15 , color: appPrimaryColor,);
TextStyle bigHeaderTextStyle = TextStyle(color: appPrimaryColor, fontSize: 18 , fontWeight: FontWeight.w400);




///..............BoxShadow....................

List<BoxShadow>? boxShadow =   [
  BoxShadow(
    color: Colors.black.withValues(alpha: 0.2),
    blurRadius: 10,
    spreadRadius: 2,
    offset: const Offset(0, 6),
  ),
];


///...........Gradient........................
LinearGradient advancedGradient =  const  LinearGradient(

  begin: Alignment.topRight,
  end: Alignment.bottomLeft,

  colors: [
    Color.fromRGBO(38, 43, 51, 0),
    Color.fromRGBO(38, 43, 51, 1),


  ],
);



