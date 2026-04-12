import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roadguard/core/constants/appColors.dart';
import 'package:roadguard/l10n/app_localizations.dart';
import 'package:roadguard/models/Hazard_types.dart';
import 'package:roadguard/models/reportData.dart';
import 'package:roadguard/screens/Hazrad_subproblem.dart';
import 'package:roadguard/screens/reportDetails.dart';
import 'package:roadguard/services/hazards_services.dart';

class Hazards extends StatefulWidget {
  const Hazards({super.key});

  @override
  State<Hazards> createState() => _HazardsState();
}

class _HazardsState extends State<Hazards> {
 
  
  List<bool> visible=[];
  Reportdata report = Reportdata();
  var hazards = HazardService.instance.hazardData;

  Future<void> loadHazards()async{
    
    
    setState(() {
      hazards=hazards;
      visible = List.filled(hazards.length, false);
    });
    
     for (int i = 0; i < visible.length; i++) {
      Future.delayed(Duration(milliseconds: 150 * i), () {
        if (mounted) {
          setState(() {
            visible[i] = true;
          });
        }
      });
     
    
  }
  }


  @override
  void initState() {
    super.initState();
    print("hi there");
    loadHazards();
    }
  

  @override
  Widget build(BuildContext context) {
     String languageCode = Localizations.localeOf(context).languageCode;
    var hazards = HazardService.instance.hazardData;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Container(
                      width: 30.w,
                      height: 30.w,
                      decoration: BoxDecoration(
                          color: Color(0xffEDE8DF),
                          borderRadius: BorderRadius.circular(5.r),
                          border: Border.all(color: Color(0xffDDD8CF))),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            size: 14.sp,
                          )),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Flexible(
                      child: Text(
                        AppLocalizations.of(context)!.hazardSelection,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                ...List.generate(hazards.length, (index) {
                  return AnimatedOpacity(
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 700),
                    opacity: visible[index] ? 1.0 : 0.0,
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: GestureDetector(
                        onTap: () {
                         report.category_id = index ;//you made hazards[index]["category_id"]
                         report.icon = hazards[index]["icon"];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HazradSubproblem(index: index,report: report,)));
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColors.CardColor,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: Color(0xffDDD8CF))),
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 35.w,
                                  height: 35.h,
                                  decoration: BoxDecoration(
                                      color: Color(0xffFDF1F1),
                                      borderRadius: BorderRadius.circular(5.r),
                                      border:
                                          Border.all(color: Color(0xffEDBBBB))),
                                  child: Padding(
                                    padding: EdgeInsets.all(5.w),
                                    child: Hero(
                                        tag: index, child: SvgPicture.memory(base64Decode(hazards[index]["icon"]),colorFilter: ColorFilter.mode(AppColors.Primary_Red, BlendMode.srcIn))),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      languageCode=="en"? hazards[index]["category_name_en"]: hazards[index]["category_name_ar"],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11.sp,
                                        color: AppColors.Text,
                                      ),
                                    ),
                                    Text(
                                      languageCode=="en"? hazards[index]["detail_en"]: hazards[index]["detail_ar"],
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Color(0xff6B6355)),
                                    )
                                  ],
                                ),
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.all(8.r),
                                  child: GestureDetector(
                                      onTap: () {
                                        report.category_id = index ;//you made hazards[index]["category_id"]
                                        report.icon = hazards[index]["icon"];
                                        Navigator.push(
                                           
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HazradSubproblem(
                                                        index: index,report: report,)));
                                      },
                                      child: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 11.sp,
                                        color: Color(0xff6B6355),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
