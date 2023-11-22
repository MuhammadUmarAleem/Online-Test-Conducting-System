import 'package:flutter/material.dart';

class Constants{
  final Color backGroundColor = const Color(0xffE0C8FE);
  final Color darkPurple = const Color(0xff8523D9);
  final Color lightOrange = const Color(0xffF9A51A);
  final Color whiteBackgroundBorder = const Color(0xffFFFFFF);
}

//heading text style
const HeadingStyle =
TextStyle(
    fontWeight: FontWeight.bold, fontSize: 45, color: Color(0xff8523D9)
);

//Exam heading text style
const HeadingStyle2 =
TextStyle(
    fontWeight: FontWeight.bold, fontSize: 30, color: Color(0xff8523D9)
);

//paragraph text style
const NormalTextStyle =
TextStyle(
  fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xff8523D9),
);

//score text style
const scoreTextStyle =
TextStyle(
  fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xff8523D9),
);

//Question Text Style
const QuestionTextStyle =
TextStyle(
  fontSize: 19, fontWeight: FontWeight.w600, color: Color(0xff8523D9),
);


//Option Text Style
const OptionTextStyle =
TextStyle(
  fontSize: 19, fontWeight: FontWeight.w600, color: Colors.white,
);

//paragraph text style
const NormalTextStyleWhite =
TextStyle(
  fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white,
);


//paragraph text style
const TextStyle18 =
TextStyle(
  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,
);

const ThinTextStyle =
TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: Color(0xff8523D9));

const SmallThinTextStyle =
TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Color(0xff8523D9));

//SideBar text style
const SideBarTextStyle =
TextStyle(
  fontSize: 18, fontWeight: FontWeight.w400, color: Color(0xff8523D9),
);


//email and password validation
class AppConstants {
  AppConstants._();

  static final navigationKey = GlobalKey<NavigatorState>();

  static final RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.([a-zA-Z]{2,})+",
  );

  static final RegExp passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$#!%*?&_])[A-Za-z\d@#$!%*?&_].{7,}$',
  );
}