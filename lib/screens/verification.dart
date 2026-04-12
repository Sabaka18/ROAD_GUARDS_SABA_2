import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadguard/core/constants/appColors.dart';
import 'package:roadguard/screens/home.dart';
import 'package:roadguard/screens/mainPage.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  List<TextEditingController> controllers = List.generate(5, (_)=>TextEditingController());
  List<FocusNode> focusNodes = List.generate(5, (_)=>FocusNode());
  List<FocusNode> keyFocusNodes = List.generate(5, (_)=>FocusNode());
  
  

  void CodeChanged(int index, String value){
    if(value.length==1&&index<focusNodes.length-1)
    {
      FocusScope.of(context).requestFocus(focusNodes[index+1]);
    
    }
   
  }
  bool Valid(){
    bool valid=true;
    controllers.forEach((e){
      if(e.text.isEmpty)
      valid=false;
      

    });
    return valid;
  }
  void BackspaceCode(int index){
    if(controllers[index].text.isEmpty&&index>0){
      FocusScope.of(context).requestFocus(focusNodes[index-1]);
      controllers[index-1].clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 40.h,right: 24.w,left: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                size: 18.sp,
              ),
              color: AppColors.Primary_Red,
              
            ),
            Text(
              "Verify Your Number",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
            SizedBox(height: 4.h,),
            Text("Code sent to +962 787878197",style: TextStyle(fontSize: 12.sp),),
            SizedBox(height: 40.h,),
            
           Row(
  children: List.generate(5, (index) {
    
    return Expanded(
      child: Padding(
        padding:  EdgeInsets.all(8.w),
        child: KeyboardListener(
          focusNode: keyFocusNodes[index],
          onKeyEvent: (value) {
            if(value is KeyDownEvent && value.logicalKey == LogicalKeyboardKey.backspace){
              BackspaceCode(index);
            }
          },
          child: TextField(controller: controllers[index],focusNode: focusNodes[index],textAlign: TextAlign.center,keyboardType: TextInputType.number,maxLength: 1,decoration: InputDecoration(
            
            counterText: "",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.Primary_Red,width: 2),borderRadius: BorderRadius.circular(10.r))
            
          ),cursorColor: AppColors.Primary_Red,onChanged: (value){
            CodeChanged(index, value);
            setState(() {
              
            });
          },),
        ),
      ),
    );
  }),
),
SizedBox(height: 12.h,),
            Center(child: TextButton(onPressed: (){}, child: Text("Resend Code",style: TextStyle(color: AppColors.Primary_Red,fontWeight: FontWeight.bold),))),
            SizedBox(height: 30.h,),
            Center(child: SizedBox(width: double.infinity,child: FilledButton(onPressed:Valid()? (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Mainpage()));
              
            }:null, child: Text("Confirm Code"),style: FilledButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10.r)),backgroundColor:Valid()? AppColors.Primary_Red:Colors.grey),)))
          ],
        ),
      ),
    );
  }
}