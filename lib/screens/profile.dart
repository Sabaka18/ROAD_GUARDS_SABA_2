import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:roadguard/core/constants/appColors.dart';
import 'package:roadguard/l10n/app_localizations.dart';
import 'package:roadguard/models/profile_model.dart';
import 'package:roadguard/services/user_services.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  dynamic userInfo;
  dynamic profileSections;
  
  
 Future<void> get_user()async{
  final user = await get_user_info(FirebaseAuth.instance.currentUser!.uid);
  if(user["success"])
  setState(() {
    userInfo=user;
  });
  else
  userInfo=[];
  
 }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_user();
  }
  @override
  Widget build(BuildContext context) {
    Provider.of<LocaleProvider>(context);
    if (userInfo == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }else
    {
    final profileSections = buildSections(context,userInfo["result"]["full_name"],userInfo["result"]["phone_number"],userInfo["result"]["created_at"]);
    return Scaffold(
  body: Padding(
    padding: const EdgeInsets.all(20.0),
    child: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(onPressed: (){if(Navigator.canPop(context))Navigator.pop(context);}, icon: Icon(Icons.arrow_back_rounded)),
          Expanded(
            child: ListView.builder(
              itemCount: profileSections.length,
              itemBuilder: (context, index) {
                final section = profileSections[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(section.sectionName(context),style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 8.h),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.CardColor,
                        border: Border.all(
                          color: Color(0xffDDD8CF),
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: List.generate(section.sectionItems.length, (i) {
                          final item = section.sectionItems[i];
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10.r),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xffF5F1EA),
                                        borderRadius: BorderRadius.circular(8.r),
                                        border: Border.all(color: Color(0xffC8C2B7))
                                      ),
                                      padding: EdgeInsets.all(4.r),
                                      child: item.icon,
                                    ),
                                    SizedBox(width: 8.w),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(item.name(context),style: TextStyle(fontSize: 12.sp),),
                                        item.details!=null?Text(textDirection: TextDirection.ltr,item.details!,style: TextStyle(fontSize: 11.sp,color: AppColors.Primary_Red),):SizedBox()
                                        
                                      ],
                                    ),
                                    Spacer(),
                                    item.widget??SizedBox(),
                                  ],
                                  
                                ),
                              ),
                              
                              if (i < section.sectionItems.length - 1)
                                Divider(color: Colors.grey.shade300, height: 1),
                            ],
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    ),
  ),
);
    }


  }
}