import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roadguard/core/constants/appColors.dart';
import 'package:roadguard/l10n/app_localizations.dart';
import 'package:roadguard/models/reportData.dart';
import 'package:roadguard/screens/AIreview.dart';
import 'package:roadguard/screens/image_preview.dart';
import 'package:roadguard/services/image_service.dart';

class ReportDetails extends StatefulWidget {
  final Reportdata report;
  const ReportDetails({super.key,required this.report});

  @override
  State<ReportDetails> createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportDetails> {
  File? photo;
  TextEditingController descriptionTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body:SafeArea(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: 
           SingleChildScrollView(
             child: Column(
               children: [
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                    Row(children: [
                             Container(
                               width: 30.w,
                               height: 30.w,
                               decoration: BoxDecoration(
                                 color: const Color(0xffEDE8DF),
                                 borderRadius: BorderRadius.circular(5.r),
                                 border: Border.all(color: const Color(0xffDDD8CF)),
                               ),
                               child: IconButton(
                                 onPressed: () => Navigator.pop(context),
                                 icon: Icon(Icons.arrow_back_rounded, size: 14.sp),
                               ),
                             ),
                             SizedBox(width: 8.w),
                              Text(
                               AppLocalizations.of(context)!.addDetails,
                               style: TextStyle(fontWeight: FontWeight.bold),
                             ),
                           ]),
                           SizedBox(height: 30.h,),
                 
                           Text( AppLocalizations.of(context)!.photoEvidence,style: TextStyle(
                             fontSize: 12.sp,
                             color: Color(0xff3D3830),
                           ),),
                           SizedBox(height: 8.h,),
                           GestureDetector(
                            onTap:(){
                              showDialog(context: context, builder: (context){
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10.r),side: BorderSide(color: AppColors.Border,width: 2.r)),
                                  backgroundColor: Color(0xffEDE8DF),
                                  title: Center(
                                    child: Text("Upload Picture",style: TextStyle(
                                      fontFamily: "EnglishFont",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp
                                    ),),
                                  ),
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(onPressed: ()async{
                                       final image= await pickImage(ImageSource.camera);
                                       setState(() {
                                         photo=image;
                                         Navigator.pop(context);
                                       });
                                      }, child: Text(
                                        "Camera",style: TextStyle(
                                          fontFamily: "EnglishFont",
                                          color: AppColors.Primary_Red

                                        ),
                                      ),style: 
                                      ButtonStyle(overlayColor: WidgetStatePropertyAll(Colors.brown[100]))),
                                       TextButton(onPressed: ()async{
                                        await pickImage(ImageSource.gallery);
                                        Navigator.pop(context);
                                       }, child: Text(
                                        "Gallery",style: TextStyle(
                                          fontFamily: "EnglishFont",
                                          color: AppColors.Primary_Red
                                          
                                        ),
                                        
                                      ),style: 
                                      ButtonStyle(overlayColor: WidgetStatePropertyAll(Colors.brown[100])),)
                                    ],
                                  ),
                                  
                                );
                              });

                              

                            },
                             child: DottedBorder(
                               options: RoundedRectDottedBorderOptions(color: Color(0xffC8C2B7),radius: Radius.circular(14.r),dashPattern: [6,6]),
                               
                               
                               
                               child: Container(
                                 width: double.infinity,
                                 height: MediaQuery.of(context).size.height/6,
                                 decoration: BoxDecoration(
                                   color: AppColors.CardColor,
                                   borderRadius: BorderRadius.circular(14.r)
                                   
                                 ),
                                 child: photo!=null? GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (_)=>ImagePreview(image: photo!)));
                                  },
                                  child: Stack(
                                    children: [
                                      Center(child: Image.file(photo!)),
                                     Positioned(top: 0,child: IconButton(onPressed: (){
                                      setState(() {
                                        photo=null;
                                      });
                                     }, icon: Icon(Icons.close_rounded)))

                                    ],
                                    
                                      
                                        
                                        
                                      
                                    
                                  )): Column(
                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                   children: [
                                   Icon(Icons.camera_alt_outlined,color: Color(0xff6B6355),size:25.sp ,),
                                   Text( AppLocalizations.of(context)!.tapToAttachAPhoto,style: TextStyle(color: Color(0xff6B6355),fontSize: 11.sp),),
                                   Text( AppLocalizations.of(context)!.photoTypes,style: TextStyle(color: Color(0xff6B6355),fontSize: 11.sp))
                                 ],),
                               ),
                             ),
                           ),
                           SizedBox(height: 12.h,),
                           Text( AppLocalizations.of(context)!.description,style: TextStyle(
                             fontSize: 12.sp,
                             color: Color(0xff3D3830),
                           )),
                           SizedBox(height: 8.h,),
                           Container(
                             width: double.infinity,
                             height: MediaQuery.of(context).size.height/6,
                             decoration: BoxDecoration(color: Colors.transparent,border: Border.all(color:Color(0xffC8C2B7) ),borderRadius: BorderRadius.circular(14.r)),
                             child: TextField(controller: descriptionTextEditingController,decoration: InputDecoration(hintText: AppLocalizations.of(context)!.descrtionHintText,border: InputBorder.none,
                             hintStyle: TextStyle(fontSize: 12.sp,color: Color(0xff6B6355))
                             ),maxLines: 5,cursorColor: AppColors.Primary_Red,),padding: EdgeInsets.all(6.r),
                           ),
                           
                           
                 
                 ],),
                 SizedBox(height: MediaQuery.of(context).size.height/4 ,),
                  FilledButton(
                         onPressed: () {
                          widget.report.image=photo;
                          widget.report.description = descriptionTextEditingController.text;
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>ReportReview(report: widget.report,)));
                         },
                         style: FilledButton.styleFrom(
                           backgroundColor: AppColors.Primary_Red,
                           fixedSize: Size(MediaQuery.of(context).size.width, 44.h),
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(16.r),
                           ),
                         ),
                         child:  Text(
                            AppLocalizations.of(context)!.runAIAnalysis,
                           style: TextStyle(fontWeight: FontWeight.bold),
                         ),
                       ),
               ],
             ),
           ),
  
      ),
  
    ) ,);
  }
}
