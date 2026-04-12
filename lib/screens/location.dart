import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:roadguard/core/constants/appColors.dart';
import 'package:roadguard/l10n/app_localizations.dart';
import 'package:roadguard/models/reportData.dart';
import 'package:roadguard/screens/reportDetails.dart';
import 'package:roadguard/services/location_services.dart';

class Location extends StatefulWidget {
 final Reportdata report;
  const Location({super.key,required this.report});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  TextEditingController searchTextEditingController = TextEditingController();
  String LocationState = "Location Acquired";
  bool locationFlag = false;
  GoogleMapController? controller;
  LatLng? currentPos;
  String? placeName;
  Set<Marker> marker = {};
  bool loading=true;

  Future<void> _loadLocation() async {
    final location = await getCurrentPosition();

    if (location == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.cancel_rounded,color: AppColors.Primary_Red,),
              Text(
                AppLocalizations.of(context)!.couldNotGetLocation,
                style: TextStyle(
                  color: AppColors.Text,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10.r),
            side: BorderSide(color: Color(0xffEDBBBB))
          ),
          backgroundColor: Color(0xffFDF1F1),
        ),
      );
      setState(() {
        LocationState = AppLocalizations.of(context)!.locationNotAcquired;
        locationFlag = false;
        loading=false;
      });
      return;
    } else {
      final name = await getPlaceName(location);
      setState(() {
        LocationState = AppLocalizations.of(context)!.locationAcquired;
        currentPos = location;
        placeName = name;
        locationFlag = true;
        loading =false;
         marker.clear();
         marker.add(
         Marker(
         markerId: MarkerId("currentLocation"),
        position: location,)
         );
         
      });
      controller?.animateCamera(CameraUpdate.newLatLngZoom(location, 16));
    }
  }

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  @override
  Widget build(BuildContext context) {
    if(loading){
      return Scaffold(body: Center(child: CircularProgressIndicator(color: AppColors.Primary_Red,)),);
    }else {
      return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: FilledButton(
            onPressed: () async{
             bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
              if (serviceEnabled)
              {
                if(placeName==null)
                {
                await _loadLocation();
                }
                else{
              widget.report.location = placeName!;
              widget.report.pos=currentPos;
                
              print(widget.report.pos);
                // Navigator.push(
                //   context,
                //   // MaterialPageRoute(builder: (context) => ReportDetails(report: widget.report,)),
                // );
                }
              }else{
                 ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.cancel_rounded,color: AppColors.Primary_Red,),
              Text(
                AppLocalizations.of(context)!.couldNotGetLocation,
                style: TextStyle(
                  color: AppColors.Text,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10.r),
            side: BorderSide(color: Color(0xffEDBBBB))
          ),
          backgroundColor: Color(0xffFDF1F1),
        ),
      );

              }
             
                
              
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.Primary_Red,
              fixedSize: Size(MediaQuery.of(context).size.width, 44.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            child: Text(
              locationFlag
                  ? AppLocalizations.of(context)!.confirmLocation
                  : AppLocalizations.of(context)!.reloadLocation,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 30.w,
                            height: 30.w,
                            decoration: BoxDecoration(
                              color: const Color(0xffEDE8DF),
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(
                                color: const Color(0xffDDD8CF),
                              ),
                            ),
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.arrow_back_rounded, size: 14.sp),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            AppLocalizations.of(context)!.confirmLocation,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        AppLocalizations.of(context)!.locationRequired,
                        style: TextStyle(
                          color: const Color(0xff6B6355),
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      GooglePlaceAutoCompleteTextField(
                        boxDecoration: BoxDecoration(
                            border: Border.all(color: AppColors.Border),
                            color: AppColors.CardColor,
                            borderRadius: BorderRadius.circular(10.r)),
                        countries: ["jo"],
                        textEditingController: searchTextEditingController,
                        googleAPIKey: "AIzaSyCtIp0p0PjNE2yJ0DhzqVdPSKC31-xIOGc",
                        inputDecoration: InputDecoration(
                          enabled: locationFlag,
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
                            placeName = newPlaceName;
                            currentPos=newPosition;
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
                      SizedBox(height: 8.h),
                      !locationFlag
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height / 2.5,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(10.r),
                                      child: Image.asset(
                                        "assets/images/map.PNG",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.map_rounded,
                                          color: AppColors.Primary_Red,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .locationNotAcquired,
                                          style: TextStyle(
                                            color: AppColors.Primary_Red,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2.5,
                                  decoration: BoxDecoration(
                                    color: AppColors.CardColor,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: GoogleMap(
                                      markers: marker,
                                      initialCameraPosition: CameraPosition(
                                        target: currentPos!,
                                        zoom: 15,
                                      ),
                                      mapType: MapType.normal,
                                      myLocationEnabled: true,
                                      myLocationButtonEnabled: true,
                                      onMapCreated: (GoogleMapController c) {
                                        controller = c;
                                        if (currentPos != null) {
                                          controller?.animateCamera(
                                            CameraUpdate.newLatLngZoom(
                                              currentPos!,
                                              16,
                                            ),
                                          );
                                        }
                                      },
                                      onTap: (position) async {
                                        String newPlaceName =
                                            await getPlaceName(position);
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
                                          currentPos=position;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 12.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: locationFlag
                                        ? Color(0xffEDF7F2)
                                        : Color(0xffFEF2F2),
                                    border: Border.all(
                                      color: locationFlag
                                          ? const Color(0xff86EFAC)
                                          : Color(0xffFCA5A5),
                                    ),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        locationFlag
                                            ? "\u2713  ${LocationState}"
                                            : "\u2717 ${LocationState} ",
                                        style: TextStyle(
                                          color: Color(0xff1A7A4A),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        locationFlag
                                            ? placeName.toString()
                                            : "",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Color(0xff1A7A4A),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
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
