import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadguard/core/constants/appColors.dart';
import 'package:roadguard/l10n/app_localizations.dart';
import 'package:roadguard/screens/home.dart';
import 'package:roadguard/screens/pastReports.dart';
import 'package:roadguard/screens/profile.dart';
import 'package:roadguard/services/hazards_services.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  bool loading=true;
  void loadCatAndSubCat()async{
    var categories = await get_hazard_info();
    var subCat=await get_sub_hazard_info();
    setState(() {
      HazardService.instance.hazardData=categories;
      HazardService.instance.subProblems=subCat;
      loading =false;
      
    });
    print("yessss");


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCatAndSubCat();
  }
  final List<Widget> pages = [
    HomeScreen(),
    PastReports(),
    Profile(),
  ];
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    if(loading){
      return Scaffold();
    }
    else {
      return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: selectedIndex,
          children: pages,
        
        ),
      ),
      bottomNavigationBar:  SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(12.r),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusGeometry.circular(15.r),
              border: Border.all(color: Color(0xffDDD8CF))
            ),
            
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(15.r),

              child: NavigationBar(
                selectedIndex: selectedIndex,
                height: 50.h,
                backgroundColor: AppColors.CardColor,
                indicatorColor: Colors.transparent,
                indicatorShape:CircleBorder() ,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex=value;
                    
                  });
                },
                destinations: [
                NavigationDestination(icon: Icon(Icons.home_rounded), label: AppLocalizations.of(context)!.home,
                selectedIcon: Icon(Icons.home_rounded,color: AppColors.Primary_Red,),
                ),
                NavigationDestination(icon: Icon(Icons.archive_rounded), label:AppLocalizations.of(context)!.pastReports ,selectedIcon: Icon(Icons.archive_rounded,color: AppColors.Primary_Red,),),
                NavigationDestination(icon: Icon(Icons.person_2_rounded), label: AppLocalizations.of(context)!.profile,
                 selectedIcon: Icon(Icons.person_2_rounded,color: AppColors.Primary_Red,),)
              ]),
            ),
          ),
        ),
      ),
    );
    }
  }
}