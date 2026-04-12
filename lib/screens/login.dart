import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadguard/core/constants/appColors.dart';
import 'package:roadguard/l10n/app_localizations.dart';
import 'package:roadguard/screens/appDetail.dart';
import 'package:roadguard/screens/home.dart';
import 'package:roadguard/screens/mainPage.dart';
import 'package:roadguard/screens/signup.dart';
import 'package:roadguard/screens/verification.dart';
import 'package:roadguard/services/user_services.dart';

class LogIn extends StatefulWidget {
  LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String emailError = "";
  String passwordError = "";
  String LogInError = "";
  bool Notseen = true;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  List<bool> disabled = [false, false];
  late TextDirection _textDirection=TextDirection.ltr;


  bool Isvalid() {
    return emailTextEditingController.text.isNotEmpty &&
        passwordTextEditingController.text.isNotEmpty &&
        disabled.every((value) => value == false);
  }

  @override
  void initState() {
    // TODO: implement initState

    emailTextEditingController.addListener(() {
      setState(() {});
    });
    passwordTextEditingController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.signIn,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  AppLocalizations.of(context)!.welcomeBackSignIn,
                  style: TextStyle(color: AppColors.MutedText, fontSize: 12.sp),
                ),
                SizedBox(height: 40.h),
                Text(
                  AppLocalizations.of(context)!.email,
                  style: TextStyle(
                      color: AppColors.MutedText,
                      fontWeight: FontWeight.bold,
                      fontSize: 11.sp),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.CardColor,
                          border: Border.all(color: AppColors.Border),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 12.w),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.mail_rounded,
                              color: AppColors.Primary_Red,
                            ),
                            hintText: "you@example.com",
                            hintTextDirection: TextDirection.ltr,
                            hintStyle: TextStyle(
                                fontSize: 12.sp, color: AppColors.MutedText),
                          ),
                          cursorColor: AppColors.Primary_Red,
                          controller: emailTextEditingController,
                          onChanged: (value) {
                            
                              final emailRegex = RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$',
                              );
                              if (value == null || value.isEmpty) {
                                setState(() {
                                  emailError = AppLocalizations.of(context)!.enterEmail;
                                  disabled[0] = true;
                                }); // returned here
                              } else if (!emailRegex.hasMatch(value)) {
                                setState(() {
                                  emailError = AppLocalizations.of(context)!.invalidEmail;
                                  disabled[0] = true;
                                }); // returned here
                              } else {
                                setState(() {
                                  emailError = "";
                                  disabled[0] = false;
                                });
                              }
                            
                          },
                        ),
                      ),
                    ),
                    Text(
                      emailError,
                      style: TextStyle(color: AppColors.Primary_Red),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  AppLocalizations.of(context)!.password,
                  style: TextStyle(
                      color: AppColors.MutedText,
                      fontWeight: FontWeight.bold,
                      fontSize: 11.sp),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.CardColor,
                      border: Border.all(color: AppColors.Border),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: TextField(
                    textDirection: _textDirection,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: AppColors.Primary_Red,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                Notseen = !Notseen;
                              });
                            },
                            icon: Icon(
                             Notseen?Icons.visibility_off_rounded:Icons.visibility_rounded,
                              color: AppColors.Primary_Red,
                            ))),
                    cursorColor: AppColors.Primary_Red,
                    obscureText: Notseen,
                    controller: passwordTextEditingController,
                    onChanged: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          passwordError = AppLocalizations.of(context)!.enterPassword;
                          disabled[1] = true;
                        });
                      }
                      else {
                        if (value.isNotEmpty &&
                            RegExp(r'[\u0600-\u06FF]')
                                .hasMatch(value.characters.first))
                          setState(() {
                            _textDirection = TextDirection.rtl;
                          });
                        else
                          setState(() {
                            _textDirection = TextDirection.ltr;
                          });

                        setState(() {
                          passwordError = "";
                          disabled[1] = false;
                        });
                      }
                    },
                  ),
                ),
                Text(
                  passwordError,
                  style: TextStyle(color: AppColors.Primary_Red),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          AppLocalizations.of(context)!.forgotPassword,
                          style: TextStyle(
                              color: AppColors.Primary_Red,
                              fontWeight: FontWeight.bold,
                              fontSize: 11.sp),
                        ))),
                SizedBox(
                  height: 20.h,
                ),
                FilledButton(
                  onPressed: () async {
                    if (Isvalid()) {
                      SystemChannels.textInput.invokeMethod(
                        'TextInput.hide',
                      );
                      FocusScope.of(context).unfocus();
                      await Future.delayed(Duration(milliseconds: 500))
                          .then((_) async {
                            final user = await user_LogIn(email: emailTextEditingController.text, password: passwordTextEditingController.text);
                            if(user["success"]){
                              Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Mainpage()));

                            }
                            else {
                              setState(() {
                              switch(user["message"]){
                                case "incorrectEmailOrPassword":
                                LogInError = AppLocalizations.of(context)!.incorrectEmailOrPassword;
                                break;
                                case "invalidEmail":
                                LogInError = AppLocalizations.of(context)!.invalidEmail;
                                break;

                              }
                              
                            });
                            }


                            

                        
                      });
                    } else
                      null;
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor:
                        Isvalid() ? AppColors.Primary_Red : Color(0xffEDE8DF),
                    fixedSize: Size(MediaQuery.of(context).size.width, 44.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.signIn,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Isvalid() ? Colors.white : Color(0xff9E9589)
                    ),
                  ),
                ),
                SizedBox(height: 4.h,),
                Center(
                  child: Text(LogInError,style: TextStyle(
                    color: AppColors.Primary_Red
                  ),),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.all(8.r),
                      child: Text(
                        AppLocalizations.of(context)!.newToRG,
                        style: TextStyle(
                            color: AppColors.Dimtext, fontSize: 12.sp),
                      ),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                OutlinedButton(
                  onPressed: () {
                    Future.delayed(Duration(milliseconds: 500), () {
                      SystemChannels.textInput.invokeMethod(
                        'TextInput.hide',
                      );
                    }).then((_) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Signup()));
                    });
                  },
                  child: Text(
                    AppLocalizations.of(context)!.createAnAccount,
                    style: TextStyle(
                        color: AppColors.Primary_Red,
                        fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(10.r)),
                      fixedSize: Size(MediaQuery.of(context).size.width, 30.h),
                      side: BorderSide(color: AppColors.Primary_Red)),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
