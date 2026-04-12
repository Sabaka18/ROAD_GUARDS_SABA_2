import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roadguard/core/constants/appColors.dart';
import 'package:roadguard/l10n/app_localizations.dart';

class VehicleObstruction extends StatefulWidget {
  const VehicleObstruction({super.key});

  @override
  State<VehicleObstruction> createState() => _VehicleObstructionState();
}

class _VehicleObstructionState extends State<VehicleObstruction> {
  TextEditingController plate1 = TextEditingController();
  TextEditingController plate2 = TextEditingController();
  FocusNode field1Focus = FocusNode();
  FocusNode field2Focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    var containerWidth = MediaQuery.of(context).size.width / 1.5;

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(24.r),
        child: FilledButton(
          onPressed: () async {},
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.Primary_Red,
            fixedSize: Size(MediaQuery.of(context).size.width, 44.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          child: Text(
            AppLocalizations.of(context)!.notifyVehicleOwner,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.r),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.vehicleBlockingYours,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.h,),
              Text(
                AppLocalizations.of(context)!.reportIt,
                style: TextStyle(),
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Container(
                    height: 50.h,
                    width: containerWidth,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 3),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 4.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "الاردن",
                              style: GoogleFonts.notoNaskhArabic(
                                  fontWeight: FontWeight.bold),
                              textDirection: TextDirection.ltr,
                            ),
                            Text(
                              "JORDAN",
                              style: GoogleFonts.robotoMono(
                                  fontWeight: FontWeight.bold, fontSize: 8.sp),
                              textDirection: TextDirection.ltr,
                            )
                          ],
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        IntrinsicWidth(
                          child: TextField(
                              autofocus: true,
                              focusNode: field1Focus,
                              controller: plate1,
                              maxLength: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "PlateFont",
                                  fontSize: 30.sp,
                                  height: 1.0,
                                  letterSpacing: 3),
                              keyboardType: TextInputType.number,
                              textDirection: TextDirection.ltr,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                counterText: "",
                              ),
                              onChanged: (value) {
                                if (value.length == 2) {
                                  setState(() {
                                    FocusScope.of(context)
                                        .requestFocus(field2Focus);
                                  });
                                }
                              },
                              textInputAction: TextInputAction.next),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          "-",
                          style: TextStyle(
                            fontFamily: "PlateFont",
                            fontWeight: FontWeight.bold,
                            fontSize: 30.sp,
                          ),
                          textDirection: TextDirection.ltr,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Expanded(
                            child: TextField(
                          focusNode: field2Focus,
                          // textAlign: TextAlign.center,
                          maxLength: 5,
                          controller: plate2,
                          style: TextStyle(
                              fontFamily: "PlateFont",
                              fontSize: 30.sp,
                              height: 1.0,
                              letterSpacing: 3),
                          keyboardType: TextInputType.number,
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            counterText: "",
                          ),
                          onChanged: (value) {
                            if(value.isEmpty)
                            FocusScope.of(context).requestFocus(field1Focus);
                          },
                        )),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
