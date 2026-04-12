import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roadguard/core/constants/appColors.dart';
import 'package:roadguard/l10n/app_localizations.dart';
import 'package:roadguard/models/Hazard_types.dart';
import 'package:roadguard/models/reportData.dart';
import 'package:roadguard/screens/home.dart';
import 'package:roadguard/screens/image_preview.dart';
import 'package:roadguard/screens/mainPage.dart';
import 'package:roadguard/screens/reportDetails.dart';
import 'package:roadguard/services/hazards_services.dart';
import 'package:roadguard/services/image_service.dart';
import 'package:roadguard/services/location_services.dart';

class ReportReview extends StatefulWidget {
  final Reportdata report;
  const ReportReview({super.key, required this.report});

  @override
  State<ReportReview> createState() => _ReportReviewState();
}

class _ReportReviewState extends State<ReportReview> {
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  Color? severityColor;
  Color? severityBorderColor;
  String? response = "Moderate";
  Set<Marker> marker = {};
  String? placeName;
  GoogleMapController? controller;
  void severityOfHazard() {
    switch (response!.toLowerCase()) {
      case "mild":
        setState(() {
          severityColor = AppColors.MildStatus;
          severityBorderColor = AppColors.MildStatusBorder;
        });

        break;
      case "moderate":
        setState(() {
          severityColor = AppColors.ModerateStatus;
          severityBorderColor = AppColors.ModerateStatusBorder;
        });

        break;
      case "severe":
        setState(() {
          severityColor = AppColors.SevereStatus;
          severityBorderColor = AppColors.SevereStatusBorder;
        });

        break;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    descriptionTextEditingController.text = widget.report.description ?? "";
    severityOfHazard();
  }

  @override
  Widget build(BuildContext context) {
    var hcategory = HazardService.instance.hazardData;
    var subhCategory = HazardService.instance.subProblems;
    String languageCode = Localizations.localeOf(context).languageCode;

    TextEditingController searchTextEditingController= TextEditingController();
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 24.r, right: 24.r, bottom: 24.r),
        child: FilledButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Mainpage()));
          },
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.Primary_Red,
            fixedSize: Size(MediaQuery.of(context).size.width, 44.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          child: Text(
            AppLocalizations.of(context)!.submitReport,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.r),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
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
                    AppLocalizations.of(context)!.aiReview,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ]),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.CardColor,
                    border: Border.all(color: Color(0xffDDD8CF)),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.r),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 40.w,
                              height: 40.w,
                              decoration: BoxDecoration(
                                color: Color(0xffFDF1F1),
                                border: Border.all(color: Color(0xffEDBBBB)),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(4.r),
                                child: SvgPicture.memory(
                                    base64Decode(widget.report.icon),
                                    colorFilter: ColorFilter.mode(
                                        AppColors.Primary_Red,
                                        BlendMode.srcIn)),
                              ),
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    languageCode == "en"
                                        ? hcategory[widget.report.category_id!]
                                            ["category_name_en"]
                                        : hcategory[widget.report.category_id!]
                                            ["category_name_ar"],
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    languageCode == "en"
                                        ? subhCategory[
                                                widget.report.subCategory_id!]
                                            ["subcategory_name_en"]
                                        : subhCategory[
                                                    widget.report.subCategory_id!]
                                                ["subcategory_name_ar"] ??
                                            "",
                                    style: TextStyle(
                                        color: Color(0xff6B6355),
                                        fontSize: 10.sp),
                                  ),
                                  Text(
                                    widget.report.location!,
                                    style: TextStyle(
                                        color: Color(0xff6B6355),
                                        fontSize: 10.sp),
                                        softWrap: true,
                                        maxLines: 4,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: severityColor,
                              border: Border.all(color: severityBorderColor!),
                              borderRadius: BorderRadius.circular(5.r)),
                          child: Padding(
                            padding: EdgeInsets.all(2.r),
                            child: Center(
                                child: Text(
                              "Severity: \t${response!}",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10.sp),
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                SizedBox(
                  height: 8.h,
                ),
                 GooglePlaceAutoCompleteTextField(
                        boxDecoration: BoxDecoration(
                            border: Border.all(color: AppColors.Border),
                            color: AppColors.CardColor,
                            borderRadius: BorderRadius.circular(10.r)),
                        countries: ["jo"],
                        textEditingController: searchTextEditingController,
                        googleAPIKey: "AIzaSyCtIp0p0PjNE2yJ0DhzqVdPSKC31-xIOGc",
                        inputDecoration: InputDecoration(
                          prefixIcon: Icon(Icons.search_rounded),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText:
                              AppLocalizations.of(context)!.searchHintText,
                        ),
                        debounceTime: 800,
                        isLatLngRequired: true,
                        getPlaceDetailWithLatLng: (prediction) async {
                          Future.delayed(Duration(milliseconds: 100), () {
                            SystemChannels.textInput.invokeMethod(
                              'TextInput.hide',
                            );
                          });
                          FocusScope.of(context).unfocus();
                          LatLng newPosition = LatLng(
                            double.parse(prediction.lat!),
                            double.parse(prediction.lng!),
                          );
                          String newPlaceName = await getPlaceName(newPosition);
                          setState(() {
                            marker.clear();
                            marker.add(
                              Marker(
                                markerId: MarkerId("currentLocation"),
                                position: newPosition,
                              ),
                            
                            );
                            controller?.animateCamera(
                              CameraUpdate.newLatLng(newPosition),
                            );
                            widget.report.location = newPlaceName;
                            widget.report.pos=newPosition;
                          });
                        },
                        itemBuilder: (context, index, Prediction prediction) {
                          return Container(
                            decoration: BoxDecoration(
                              color: AppColors.CardColor,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12.r),
                              child: Row(
                                children: [
                                  Icon(Icons.location_on, color: Colors.red),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      prediction.description ?? "",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemClick: (prediction) {
                          searchTextEditingController.text =
                              prediction.description!;
                          searchTextEditingController.selection =
                              TextSelection.fromPosition(
                            TextPosition(
                              offset: prediction.description!.length,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 8.h,),
                Container(
                  height: MediaQuery.of(context).size.height / 3.5,
                  decoration: BoxDecoration(
                    color: AppColors.CardColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: GoogleMap(
                      markers: marker,
                      initialCameraPosition: CameraPosition(
                        target: widget.report.pos!,
                        zoom: 15,
                      ),
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      onMapCreated: (GoogleMapController c) {
                        controller = c;
                        if (widget.report.pos != null) {
                          controller?.animateCamera(
                            CameraUpdate.newLatLngZoom(
                              widget.report.pos!,
                              16,
                            ),
                          );
                        }
                        setState(() {
                          marker.clear();
                          marker.add(Marker(
                              markerId: MarkerId("currentLocation"),
                              position: widget.report.pos!));
                        });
                      },
                      gestureRecognizers: {
                        Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer(),
                        ),
                      },
                      onTap: (position) async {
                        String newPlaceName = await getPlaceName(position);
                        setState(() {
                          marker.clear();
                          marker.add(
                            Marker(
                              markerId: MarkerId(
                                "currentLocation",
                              ),
                              position: position,
                            ),
                          );
                          controller?.animateCamera(
                            CameraUpdate.newLatLng(position),
                          );
                          placeName = newPlaceName;
                          widget.report.location=newPlaceName;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 8.h,),
                Text(
                  "Image Preview",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.Text),
                ),
                SizedBox(
                  height: 8.h,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusGeometry.circular(10.r),
                                side: BorderSide(
                                    color: AppColors.Border, width: 2.r)),
                            backgroundColor: Color(0xffEDE8DF),
                            title: Center(
                              child: Text(
                                "Upload Picture",
                                style: TextStyle(
                                    fontFamily: "EnglishFont",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp),
                              ),
                            ),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                    onPressed: () async {
                                      final image =
                                          await pickImage(ImageSource.camera);
                                      setState(() {
                                        widget.report.image = image;
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Text(
                                      "Camera",
                                      style: TextStyle(
                                          fontFamily: "EnglishFont",
                                          color: AppColors.Primary_Red),
                                    ),
                                    style: ButtonStyle(
                                        overlayColor: WidgetStatePropertyAll(
                                            Colors.brown[100]))),
                                TextButton(
                                  onPressed: () async {
                                    await pickImage(ImageSource.gallery);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Gallery",
                                    style: TextStyle(
                                        fontFamily: "EnglishFont",
                                        color: AppColors.Primary_Red),
                                  ),
                                  style: ButtonStyle(
                                      overlayColor: WidgetStatePropertyAll(
                                          Colors.brown[100])),
                                )
                              ],
                            ),
                          );
                        });
                  },
                  child: DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                        color: Color(0xffC8C2B7),
                        radius: Radius.circular(14.r),
                        dashPattern: [6, 6]),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 6,
                      decoration: BoxDecoration(
                          color: AppColors.CardColor,
                          borderRadius: BorderRadius.circular(14.r)),
                      child: widget.report.image != null
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ImagePreview(
                                            image: widget.report.image!)));
                              },
                              child: Stack(
                                children: [
                                  Center(
                                      child: Image.file(widget.report.image!)),
                                  Positioned(
                                      top: 0,
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              widget.report.image = null;
                                            });
                                          },
                                          icon: Icon(Icons.close_rounded)))
                                ],
                              ))
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("No Image Selected",
                                    style: TextStyle(
                                        color: Color(0xff6B6355),
                                        fontSize: 11.sp)),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Text("Tap to Add An Image",
                                    style: TextStyle(
                                        color: Color(0xff6B6355),
                                        fontSize: 11.sp)),
                              ],
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(AppLocalizations.of(context)!.description,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.Text,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 8.h,
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 6,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Color(0xffC8C2B7)),
                      borderRadius: BorderRadius.circular(14.r)),
                  child: TextField(
                    controller: descriptionTextEditingController,
                    decoration: InputDecoration(
                        hintText:
                            AppLocalizations.of(context)!.descrtionHintText,
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontSize: 12.sp, color: Color(0xff6B6355))),
                    maxLines: 5,
                    cursorColor: AppColors.Primary_Red,
                  ),
                  padding: EdgeInsets.all(6.r),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
