import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:roadguard/core/constants/appColors.dart';
import 'package:roadguard/l10n/app_localizations.dart';
import 'package:roadguard/models/profile_model.dart';
import 'package:roadguard/screens/login.dart';
import 'package:roadguard/screens/mainPage.dart';
import 'package:roadguard/services/user_services.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController phoneNumberTextEditingController =
      TextEditingController();
  List<bool> disabled = [false, false, false, false];
  String emailError = "";
  String passwordError = "";
  String phoneError = "";
  String fullNameError = "";
  String signupError = "";
  bool seen = true;
  late final languageCode = Provider.of<LocaleProvider>(context).locale;
  late TextDirection _textDirection=TextDirection.ltr;

  bool get Isvalid =>
      nameTextEditingController.text.isNotEmpty &&
      emailTextEditingController.text.isNotEmpty &&
      passwordTextEditingController.text.isNotEmpty &&
      phoneNumberTextEditingController.text.isNotEmpty &&
      phoneNumberTextEditingController.text.length == 9 &&
      disabled.every((value) => value == false);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameTextEditingController.addListener(() {
      setState(() {});
    });
    emailTextEditingController.addListener(() {
      setState(() {});
    });
    passwordTextEditingController.addListener(() {
      setState(() {});
    });
    phoneNumberTextEditingController.addListener(() {
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
                  AppLocalizations.of(context)!.createAccount,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  AppLocalizations.of(context)!.registerAs,
                  style: TextStyle(color: AppColors.MutedText, fontSize: 12.sp),
                ),
                SizedBox(height: 30.h),
                Text(
                  AppLocalizations.of(context)!.fullName,
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
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.w),
                    child: TextField(
                      textDirection: _textDirection,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.person_2_rounded,
                          color: AppColors.Primary_Red,
                        ),
                        hintText: "eg: Ahmad Omar",
                        hintStyle: TextStyle(
                            fontSize: 12.sp, color: AppColors.MutedText),
                      ),
                      cursorColor: AppColors.Primary_Red,
                      controller: nameTextEditingController,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            fullNameError = AppLocalizations.of(context)!.enterName;
                            disabled[0] = true;
                          });
                        } else {
                          fullNameError = "";
                          disabled[0] = false;
                        }
                        if (value.isNotEmpty &&
                            RegExp(r'[\u0600-\u06FF]')
                                .hasMatch(value.characters.first)) {
                          setState(() {
                            _textDirection = TextDirection.rtl;
                          });
                        } else {
                          setState(() {
                            _textDirection = TextDirection.ltr;
                          });
                        }
                      },
                    ),
                  ),
                ),
                Text(
                  fullNameError,
                  style: TextStyle(color: AppColors.Primary_Red),
                ),
                SizedBox(
                  height: 10.h,
                ),
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
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.CardColor,
                      border: Border.all(color: AppColors.Border),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.w),
                    child: TextField(
                      textDirection: TextDirection.ltr,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.mail_rounded,
                          color: AppColors.Primary_Red,
                        ),
                        hintText: "you@example.com",
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
                            disabled[1] = true;
                          }); // returned here
                        } else if (!emailRegex.hasMatch(value)) {
                          setState(() {
                            emailError = AppLocalizations.of(context)!.invalidEmail;
                            disabled[1] = true;
                          }); // returned here
                        } else {
                          setState(() {
                            emailError = "";
                            disabled[1] = false;
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
                                seen = !seen;
                              });
                            },
                            icon: Icon(
                              seen
                                  ? Icons.visibility_off_rounded
                                  : Icons.remove_red_eye_rounded,
                              color: AppColors.Primary_Red,
                            ))),
                    cursorColor: AppColors.Primary_Red,
                    obscureText: seen,
                    controller: passwordTextEditingController,
                    onChanged: (value) {
                      final passwordRegex = RegExp(
                          r'^(?=.*[A-Z])(?=.*[.!@#$%^&*])[a-zA-Z0-9.!@#$%^&*]{8,15}$');

                      if (value == null || value.isEmpty) {
                        setState(() {
                          passwordError = AppLocalizations.of(context)!.enterPassword;
                          disabled[2] = true;
                        }); // returned here
                       
                      } if (value.isNotEmpty &&
                            RegExp(r'[\u0600-\u06FF]')
                                .hasMatch(value.characters.first)) {
                        setState(() {
                            _textDirection = TextDirection.rtl;
                          });
                      } else {
                        setState(() {
                            _textDirection = TextDirection.ltr;
                          });
                      }
                    
                      if (!passwordRegex.hasMatch(value)) {
                        setState(() {
                          passwordError =
                              AppLocalizations.of(context)!.passwordFormat;
                          disabled[2] = true;
                        }); // returned here
                      } else {
                        setState(() {
                          passwordError = "";
                          disabled[2] = false;
                        });
                      }
                    },
                  ),
                ),
                Text(
                  passwordError,
                  style: TextStyle(color: AppColors.Primary_Red),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  AppLocalizations.of(context)!.phoneNumber,
                  style: TextStyle(
                      color: AppColors.MutedText,
                      fontWeight: FontWeight.bold,
                      fontSize: 11.sp),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: AppColors.CardColor,
                          shape: BoxShape.rectangle,
                          border: Border.all(color: Color(0xffC8C2B7)),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Center(
                          child: Text(
                        "+962",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                              color: AppColors.CardColor,
                              shape: BoxShape.rectangle,
                              border: Border.all(color: Color(0xffC8C2B7)),
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Center(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                maxLength: 9,
                                onChanged: (value) {
                                  final phoneNumberReg =
                                      RegExp(r'(^7[7,8,9][0-9]{7})');
                                  if (value.isEmpty) {
                                    setState(() {
                                      phoneError =
                                          AppLocalizations.of(context)!.enterPhoneNumber;
                                      disabled[3] = true;
                                    });
                                  } else if (!phoneNumberReg.hasMatch(value)) {
                                    setState(() {
                                      phoneError = AppLocalizations.of(context)!.invalidPhoneNumber;
                                      disabled[3] = true;
                                    });
                                  } else {
                                    setState(() {
                                      phoneError = "";
                                      disabled[3] = false;
                                    });
                                  }
                                },
                                controller: phoneNumberTextEditingController,
                                decoration: InputDecoration(
                                    hintText: "7X XXX XXXX",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.grey),
                                    counterText: ""),
                                cursorColor: AppColors.Primary_Red,
                              ),
                            ),
                          )),
                    )
                  ],
                ),
                Text(
                  phoneError,
                  style: TextStyle(color: AppColors.Primary_Red),
                ),
                SizedBox(
                  height: 10.h,
                ),
                FilledButton(
                  onPressed: () async {
                    final data = await create_user(
                        emailTextEditingController.text,
                        nameTextEditingController.text,
                        passwordTextEditingController.text,
                        phoneNumberTextEditingController.text);
                    if (data["success"]) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Mainpage()));
                    } else {
                      setState(() {
                         switch(data["message"]){
                                case "phoneNumberExists":
                                signupError = AppLocalizations.of(context)!.phoneNumberExists;
                                break;
                                case "Internal server error":
                                signupError = AppLocalizations.of(context)!.unknownErrorServer;
                                break;
                                case "emailAlreadyExists":
                                 signupError = AppLocalizations.of(context)!.emailAlreadyExists;
                                break;

                              }
                        
                      });
                    }
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor:
                        Isvalid ? AppColors.Primary_Red : Color(0xffEDE8DF),
                    fixedSize: Size(MediaQuery.of(context).size.width, 44.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.signUp,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Isvalid ? Colors.white : Color(0xff9E9589)),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Center(
                    child: Text(
                  signupError,
                  style: TextStyle(color: AppColors.Primary_Red),
                )),
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.all(8.r),
                      child: Text(
                        AppLocalizations.of(context)!.alreadyHaveAnAccount,
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
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>LogIn()));
                  },
                  child: Text(
                    AppLocalizations.of(context)!.signInInstead,
                    style: TextStyle(
                        color: AppColors.Primary_Red,
                        fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(10.r)),
                      fixedSize: Size(MediaQuery.of(context).size.width, 30.h),
                      side: BorderSide(color: AppColors.Primary_Red)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
