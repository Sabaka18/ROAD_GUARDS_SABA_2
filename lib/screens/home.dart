import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadguard/core/constants/appColors.dart';
import 'package:roadguard/l10n/app_localizations.dart';
import 'package:roadguard/models/Hazard_types.dart';
import 'package:roadguard/models/report_status.dart';
import 'package:roadguard/screens/Hazards.dart';
import 'package:roadguard/screens/profile.dart';
import 'package:roadguard/services/notification_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex=0;
  final pages = [
    HomeScreen(),
    Profile(),
    
  ];
  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationService notificationService = NotificationService();
    notificationService.requestNotificationPermission();
    notificationService.getFcmtoken();
  }
  @override
  Widget build(BuildContext context) {
    final dashboardTranslate={
      "total":AppLocalizations.of(context)!.total,
      "resolved":AppLocalizations.of(context)!.resolved,
      "pending":AppLocalizations.of(context)!.pending
    };
    return Scaffold(body: SafeArea(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
                    TextSpan(
                      style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.bold),
                      children: [TextSpan(
                        text: "Road",
                        style: TextStyle(color: AppColors.Text),
                      ),
                      TextSpan(
                        text: "Guard",
                        style: TextStyle(color: AppColors.Primary_Red),
                      )],
                    )
                  ),
                  Text("HAZARD REPORTING",style: TextStyle(letterSpacing: 2,color: AppColors.Text,fontSize: 11.sp),),
                  SizedBox(height: 20.h,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Hazards()));
                    },
                    child: Container(
                      width: double.infinity,
                     
                      decoration: BoxDecoration(color: AppColors.Primary_Red,borderRadius: BorderRadius.circular(12.r)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        
                        child: Row(children: [
                          Container(width: 40.w,height: 40.w,decoration: BoxDecoration(shape: BoxShape.rectangle,color: Color.fromARGB(90, 174, 171, 171),borderRadius: BorderRadius.circular(7.r)),child: Icon(Icons.add_circle_outline_outlined,color: Colors.white,),),
                          SizedBox(width: 10.w,),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,children: [Text(AppLocalizations.of(context)!.reportARoadHazard,style: TextStyle(color: Colors.white,fontSize: 13.sp,fontWeight: FontWeight.bold),),
                          SizedBox(height: 4.h,),
                          Text(AppLocalizations.of(context)!.submitWithLiveGPSLocation,style: 
                          TextStyle(color: Colors.grey[300],fontSize: 10.sp)
                          ),
                          ],),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_rounded,size: 15.sp,color: Colors.grey[300],)
                        ],),
                      ),
                    
                    ),
                  ),
                  SizedBox(height: 30.h,),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(reportStatus.length, (index){
                    return Container(
                      width: 95.w,height: 75.h,
                      decoration: BoxDecoration(
                        color: Colors.transparent,borderRadius: BorderRadius.circular(10.r),border: Border(
                          left: BorderSide(color: reportStatus[index].StatusColor,width: 3),
                      
                        )),
                      
                      child: Container(width: 95.w,height: 75.h,decoration: BoxDecoration(
                        color: AppColors.CardColor,borderRadius: BorderRadius.circular(10.r),border: Border.all(color:Color(0xffDDD8CF) )
                      ),child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(reportStatus[index].counter.toString(),style: TextStyle(
                            color: reportStatus[index].StatusColor
                            ,fontWeight: FontWeight.bold,
                            fontSize: 14.sp
                          ),),
                          Text(dashboardTranslate[reportStatus[index].Text]!,style: TextStyle(
                            color: reportStatus[index].StatusColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 10.sp
                          ),),
                        ],
                      ),),
                    );
      
                  })
                ],
               ),
               SizedBox(height: 20.h,),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text(AppLocalizations.of(context)!.myReports,style: TextStyle(color: AppColors.Text,fontWeight: FontWeight.bold,fontSize: 12.sp),),
                   Text(AppLocalizations.of(context)!.submitted,style: TextStyle(fontSize: 11.sp,color: Color(0xff6B6355)),),
                 ],
               ),
               SizedBox(height: 12.h,),
               Container(
                width: double.infinity,
                decoration:BoxDecoration(border: Border(left: BorderSide(color: reportStatus[0].StatusColor,width: 3.r)),borderRadius: BorderRadius.circular(10.r)) ,
                 child: Container(width: double.infinity,height: 90.h,
                 decoration: BoxDecoration(color:AppColors.CardColor,
                 border: Border.all(color:Color(0xffDDD8CF) ),
                 borderRadius: BorderRadius.circular(10.r),
                 ),
                 child: Padding(
                   padding:  EdgeInsets.all(8.r),
                   child: Column(
                     children: [
                       Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                        Container(
                                  width: 35.w,
                                  height: 35.w,
                                  decoration: BoxDecoration(
                                    color: Color(0xffFDF1F1),
                                    border: Border.all(color: Color(0xffEDBBBB)),
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.all(4.r),
                                    child: hazards[1].icon,
                                  ),
                                ),
                                SizedBox(width: 12.w,),
                                Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                  Text(hazards[1].hazardName(context),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.sp),),
                                  Text(AppLocalizations.of(context)!.submitted,style: TextStyle(color: Color(0xff6B6355),fontSize: 10.sp),),
                                  
                                                              
                                ],),
                                Spacer(),
                                Container(
                                  height: 20.h,
                                  decoration: BoxDecoration(color: Color(0xffFDF6E8),border: Border.all(color: Color(0xffDFC96A)),borderRadius: BorderRadius.circular(5.r)),
                                  child: Center(child: Padding(
                                    padding:  EdgeInsets.all(2.r),
                                    child: Text(AppLocalizations.of(context)!.submitted,style: TextStyle(fontSize: 9.sp,color: Color(0xffB8860B)),),
                                  )),
                                )
                                
                       ],),
                       Divider(),
                       Row(children: [
                        Text(
                          hazards[1].subProblems[0](context),
                          style: TextStyle(color: AppColors.MutedText,
                          fontSize: 10.sp),
      
      
                        ),
                        Spacer(),
                         Container(
                                  height: 20.h,
                                  decoration: BoxDecoration(color: Color(0xffFDF6E8),border: Border.all(color: Color(0xffDFC96A)),borderRadius: BorderRadius.circular(5.r)),
                                  child: Center(child: Padding(
                                    padding:  EdgeInsets.all(2.r),
                                    child: Text(AppLocalizations.of(context)!.moderate,style: TextStyle(fontSize: 9.sp,color: Color(0xffB8860B)),),
                                  )),
                                )
                       ],)
                     ],
                   ),
                 ),
                 
                 ),
               )
               
      
        
          ],
        ),
      ),
    ),);
  }
}