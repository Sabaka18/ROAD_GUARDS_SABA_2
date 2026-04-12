import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadguard/l10n/app_localizations.dart';
import 'package:roadguard/models/app_detail_item.dart';
import 'package:roadguard/screens/login.dart';


class Appdetail extends StatefulWidget {
  const Appdetail({super.key});

  @override
  State<Appdetail> createState() => _AppdetailState();
}

class _AppdetailState extends State<Appdetail> {
  final appDetails = AppDetails;
  int itemIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void goToNextPage() {
    if (itemIndex < appDetails.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LogIn()),
      );
    }
  }

  void skipOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LogIn()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final  questionTranslation={
  "WhatIsRG":AppLocalizations.of(context)!.whatIsRG,
  "howItWorks":AppLocalizations.of(context)!.howItWorks,
  "whyItMatters":AppLocalizations.of(context)!.whyItMatters,
};
final  headingTranslation={
  "splashScreen1p1":AppLocalizations.of(context)!.splashScreen1p1,
  "splashScreen2p1":AppLocalizations.of(context)!.splashScreen2p1,
  "splashScreen3p1":AppLocalizations.of(context)!.splashScreen3p1,
};
final  descriptionTranslation={
  "splashScreen1p2":AppLocalizations.of(context)!.splashScreen1p2,
  "splashScreen2p2":AppLocalizations.of(context)!.splashScreen2p2,
  "splashScreen3p2":AppLocalizations.of(context)!.splashScreen3p2,
};
    final width = MediaQuery.of(context).size.width;
    final currentItem = appDetails[itemIndex];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: skipOnboarding,
                  child: Text(
                    AppLocalizations.of(context)!.skip,
                    style: TextStyle(
                      color: currentItem.PrimaryColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              SizedBox(
                height: 260.h,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: appDetails.length,
                  onPageChanged: (index) {
                    setState(() {
                      itemIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final item = appDetails[index];
                    

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: item.BackgroundColor,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(color: item.borderColor),
                          ),
                          child: Text(
                            questionTranslation[item.question]!,
                            style: TextStyle(
                              color: item.PrimaryColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          headingTranslation[item.heading]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(
                            descriptionTranslation[item.description]!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.sp,
                              height: 1.5,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              SizedBox(height: 24.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(appDetails.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    width: itemIndex == index ? 22.w : 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: itemIndex == index
                          ? currentItem.PrimaryColor
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  );
                }),
              ),

              const Spacer(),

              FilledButton(
                style: FilledButton.styleFrom(
                  fixedSize: Size(width, 52.h),
                  backgroundColor: currentItem.PrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                onPressed: goToNextPage,
                child: Text(
                  itemIndex == appDetails.length - 1 ? AppLocalizations.of(context)!.getStarted : AppLocalizations.of(context)!.next,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}