import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roadguard/core/constants/appColors.dart';
import 'package:roadguard/l10n/app_localizations.dart';
import 'package:roadguard/models/Hazard_types.dart';
import 'package:roadguard/models/reportData.dart';
import 'package:roadguard/screens/location.dart';
import 'package:roadguard/screens/vehicleObstruction.dart';
import 'package:roadguard/services/hazards_services.dart';

class HazradSubproblem extends StatefulWidget {
  final int index;
 
  final Reportdata report;
  const HazradSubproblem({super.key,required this.index,required this.report});

  @override
  State<HazradSubproblem> createState() => _HazradSubproblemState();
}

class _HazradSubproblemState extends State<HazradSubproblem> {
  List<bool> visible=[];





  Future<void> loadHazards()async{
    
    
    
    setState(() {
      
      visible = List.filled(HazardService.instance.subProblems.where((e)=>e["category_id"]==HazardService.instance.hazardData[widget.report.category_id!]["category_id"]).toList().length, false);
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
     var subCat = HazardService.instance.subProblems.where((e)=>  e["category_id"]==HazardService.instance.hazardData[widget.report.category_id!]["category_id"]).toList();
    int index = widget.index;
    String languageCode = Localizations.localeOf(context).languageCode;
    
    if(subCat.isEmpty)
    {
      
    return Scaffold(body: Location(report: widget.report,));
    }else  {
      return Scaffold(body: 
    SafeArea(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         Row(children: [
          Container(width: 30.w,
          height: 30.w,
          decoration: BoxDecoration(color: Color(0xffEDE8DF),borderRadius: BorderRadius.circular(5.r),border:Border.all(color: Color(0xffDDD8CF)) ),
          child: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_rounded,size: 14.sp,)),
          ),
          SizedBox(width: 8.w,),
          Text( AppLocalizations.of(context)!.specifyTheIssue,style: 
          TextStyle(fontWeight: FontWeight.bold,
        
          )
          ,)
         ],),
         SizedBox(height: 12.h,),
          Container(
            
            height: 35.h,
            decoration: BoxDecoration(color: Color(0xffFDF1F1),borderRadius: BorderRadius.circular(10.r),border: Border.all(color: Color(0xffEDBBBB))),
            child: Padding(
              padding:  EdgeInsets.all(6.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 20.w,child: Hero(tag: index, child: SvgPicture.memory(base64Decode(widget.report.icon),colorFilter: ColorFilter.mode(AppColors.Primary_Red, BlendMode.srcIn)))),
                SizedBox(width: 2.w,),
                Text(languageCode=="en"?HazardService.instance.hazardData[widget.report.category_id!]["category_name_en"]:HazardService.instance.hazardData[widget.report.category_id!]["category_name_ar"],style: TextStyle(fontWeight: FontWeight.bold),),
              ],),
            ),
          ),
          SizedBox(height: 20.h,),
          
          Column(
          children: [
            ...List.generate(subCat.length, (e){
              return AnimatedOpacity(
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 500),
                opacity: visible[e]?1:0,
                child: Padding(
                  padding:  EdgeInsets.only(bottom: 6.h),
                  child: Container(
                    width: double.infinity,
                    
                    decoration: BoxDecoration(
                      color: AppColors.CardColor,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Color(0xffDDD8CF)),
                      
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding:  EdgeInsets.all(12.w),
                          child: Text(languageCode=="en"? subCat[e]["subcategory_name_en"]:subCat[e]["subcategory_name_ar"],style:
                          TextStyle(fontSize: 12.sp) 
                          ,),
                        ),
                        Spacer(),
                        IconButton(onPressed: (){
                          
                          widget.report.subCategory_id=HazardService.instance.subProblems.indexOf(subCat[e]);
                          print("subcategory_id is ${widget.report.subCategory_id}");
                          if(HazardService.instance.hazardData[widget.report.category_id!]["category_name_en"]=="Vehicle Obstruction")
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VehicleObstruction()));
                          else
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Location(report: widget.report,)));
                          
                          
                        }, icon: Icon(Icons.arrow_forward_ios_rounded,size: 12.sp,))
                      ],
                    ),
                  
                  ),
                ),
              );
            })
          ],)
      
      
        
        ],),
      ),
    )
    ,);
    }
  }
}