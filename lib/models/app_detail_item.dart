import 'dart:ui';

import 'package:roadguard/core/constants/appColors.dart';
import 'package:roadguard/l10n/app_localizations.dart';
import 'package:roadguard/screens/appDetail.dart';

class AppDetailItem {
  late String question;
  late String heading;
  late String description;
  late String iconPath;
  late Color PrimaryColor;
  late Color BackgroundColor;
  late Color borderColor;

  AppDetailItem({required this.question,required this.heading,required this.description,required this.PrimaryColor,required this.BackgroundColor,required this.borderColor,iconpath});
  
}

List<AppDetailItem> AppDetails =[
  AppDetailItem(question: "WhatIsRG", heading: "splashScreen1p1", description: "splashScreen1p2",PrimaryColor: AppColors.Primary_Red,BackgroundColor: Color(0xffFDF1F1),borderColor: Color(0XFFEDBBBB)),
  AppDetailItem(question: "howItWorks", heading:  "splashScreen2p1", description: "splashScreen2p2",PrimaryColor: Color(0xffB8860B),BackgroundColor: Color(0xffFDF8EC),borderColor: Color(0xffDFC96A)),
  AppDetailItem(question: "whyItMatters", heading: "splashScreen3p1", description: "splashScreen3p2",PrimaryColor:Color(0xff1A7A4A),BackgroundColor: Color(0xffEDF7F2),borderColor: Color(0xff86EFAC) )

];

