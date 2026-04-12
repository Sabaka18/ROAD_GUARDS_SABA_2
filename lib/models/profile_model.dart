import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:roadguard/core/constants/appColors.dart';
import 'package:roadguard/l10n/app_localizations.dart';
import 'package:roadguard/screens/login.dart';
import 'package:roadguard/services/user_services.dart';

 

class ProfileSection{
  late SvgPicture icon;
  late String Function(BuildContext) name;
   String? details;
  late Widget? widget;
  

  ProfileSection({required this.icon,required this.name,this.details,this.widget});
}
class ProfileModel {
  late String Function(BuildContext) sectionName;
  late List<ProfileSection> sectionItems;

  ProfileModel({required this.sectionName,required this.sectionItems});

}
List<ProfileModel> buildSections(BuildContext context2,String name,String phone_number,String created_at)  {
  final localeProvider = Provider.of<LocaleProvider>(context2);
return[
  ProfileModel(sectionName: (context)=>AppLocalizations.of(context)!.account, sectionItems: [
    ProfileSection(icon: SvgPicture.asset("assets/svg/person.svg"), name: (context)=>AppLocalizations.of(context)!.fullName,details: name ),
    ProfileSection(icon: SvgPicture.asset("assets/svg/phone.svg"), name: (context)=>AppLocalizations.of(context)!.phoneNumber,details: phone_number ),
    ProfileSection(icon: SvgPicture.asset("assets/svg/calendar.svg"), name: (context)=>AppLocalizations.of(context)!.memberSince,details: created_at.substring(0,4))
  ]),

 
  ProfileModel(sectionName: (context)=>AppLocalizations.of(context)!.supportAndLegal, sectionItems: [
    ProfileSection(icon: SvgPicture.asset("assets/svg/help-circle.svg"), name: (context)=>AppLocalizations.of(context)!.helpAndFaq,widget: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_rounded,size: 14.sp,))),
    ProfileSection(icon: SvgPicture.asset("assets/svg/document.svg"), name: (context)=>AppLocalizations.of(context)!.termsOfService,widget: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_rounded,size: 14.sp,))),
    ProfileSection(icon: SvgPicture.asset("assets/svg/shield.svg"), name: (context)=>AppLocalizations.of(context)!.privacyPolicy,widget: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_rounded,size: 14.sp,))),
    ProfileSection(icon: SvgPicture.asset("assets/svg/info-circle.svg"), name: (context)=>AppLocalizations.of(context)!.about,widget: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_rounded,size: 14.sp,))),

  ]),

  ProfileModel(sectionName: (context)=>AppLocalizations.of(context)!.preferences, sectionItems: [
    ProfileSection(icon: SvgPicture.asset("assets/svg/language-svgrepo-com.svg",width: 20.w,), name: (context)=>AppLocalizations.of(context)!.language,widget: 
    DropdownMenu(
      initialSelection:Locale(Localizations.localeOf(context2).languageCode ),
      textStyle: TextStyle(fontSize: 12.sp),
      inputDecorationTheme: InputDecorationTheme(
       
        suffixIconColor: AppColors.Primary_Red,
        border:  OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(color: AppColors.Primary_Red),
      
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(color: AppColors.Primary_Red),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(color: AppColors.Primary_Red, width: 2),
    ),
      ),
menuStyle: MenuStyle(backgroundColor: WidgetStatePropertyAll(AppColors.CardColor)),
      dropdownMenuEntries: [DropdownMenuEntry(value:Locale("en") , label: "English"),
    DropdownMenuEntry(value:Locale("ar") , label: "العربية"),
    
    ],onSelected: (value) {
      Provider.of<LocaleProvider>(context2,listen: false).setLocale(value!);
      
      
    },)
    ),
    
  ]),

  ProfileModel(sectionName: (context)=>AppLocalizations.of(context)!.session, sectionItems: [
    ProfileSection(icon: SvgPicture.asset("assets/svg/sign-out.svg",colorFilter: ColorFilter.mode(AppColors.Primary_Red, BlendMode.srcIn),), name: (context)=>AppLocalizations.of(context)!.signOut,widget: IconButton(onPressed: (){
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context2, MaterialPageRoute(builder: (context2)=>LogIn()));
      
     
      
    }, icon: Icon(Icons.arrow_forward_ios_rounded,size: 14.sp,)))
  ])
];
}
class LocaleProvider extends ChangeNotifier{
  Locale _locale= WidgetsBinding.instance.platformDispatcher.locale;
  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

}