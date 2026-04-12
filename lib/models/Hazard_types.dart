import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:roadguard/core/constants/appColors.dart';
import 'package:roadguard/l10n/app_localizations.dart';

class Hazard{
  late SvgPicture icon;
  late String Function(BuildContext) hazardName;
  late String Function(BuildContext) description;
  late List<String Function(BuildContext)> subProblems;

  Hazard({required this.icon, required this.hazardName,required this.description,required this.subProblems});
}

List<Hazard> hazards = [
  Hazard(icon: SvgPicture.asset("assets/svg/pothole_tight.svg",colorFilter: ColorFilter.mode(AppColors.Primary_Red, BlendMode.srcIn)), hazardName:(context)=>AppLocalizations.of(context)!.pothole, description: (context)=>AppLocalizations.of(context)!.potholeDescription,subProblems: []),
  Hazard(icon: SvgPicture.asset("assets/svg/traffic_light_outline (1).svg",colorFilter: ColorFilter.mode(AppColors.Primary_Red, BlendMode.srcIn)), hazardName: (context)=>AppLocalizations.of(context)!.trafficLight, description: (context)=>AppLocalizations.of(context)!.trafficLightDescription,subProblems: [
    (context)=>AppLocalizations.of(context)!.stuckOnOneColor
    ,(context)=>AppLocalizations.of(context)!.physicalDamage,
    (context)=>AppLocalizations.of(context)!.noLight
    ,(context)=>AppLocalizations.of(context)!.dimOrFlickering
    , (context)=>AppLocalizations.of(context)!.incorrectTiming
    ,(context)=>AppLocalizations.of(context)!.other
  ]),
  Hazard(icon: SvgPicture.asset("assets/svg/road_drain_icon (1).svg",colorFilter: ColorFilter.mode(AppColors.Primary_Red, BlendMode.srcIn)), hazardName: (context)=>AppLocalizations.of(context)!.roadDrain, description: (context)=>AppLocalizations.of(context)!.roadDrainDescription, subProblems: [
    (context)=>AppLocalizations.of(context)!.missingLid
    ,(context)=>AppLocalizations.of(context)!.brokenLid
    ,(context)=>AppLocalizations.of(context)!.cloggedDrain
    ,(context)=>AppLocalizations.of(context)!.other
  ]),
  Hazard(icon:SvgPicture.asset("assets/svg/manhole_cover_icon_v2 (1).svg",colorFilter: ColorFilter.mode(AppColors.Primary_Red, BlendMode.srcIn)) , hazardName: (context)=>AppLocalizations.of(context)!.manholeCover, description: (context)=>AppLocalizations.of(context)!.manholeCoverDescription, subProblems: [
    (context)=>AppLocalizations.of(context)!.missingCover,
    (context)=>AppLocalizations.of(context)!.brokenCover,
    (context)=>AppLocalizations.of(context)!.raisedOrSunken,
    (context)=>AppLocalizations.of(context)!.other
  ]),
  Hazard(icon:SvgPicture.asset("assets/svg/speed_bump_icon_v2 (1).svg",colorFilter: ColorFilter.mode(AppColors.Primary_Red, BlendMode.srcIn)) , hazardName: (context)=>AppLocalizations.of(context)!.speedBump, description: (context)=>AppLocalizations.of(context)!.speedBumpDescription, subProblems: [
    (context)=>AppLocalizations.of(context)!.noPaint,
    (context)=>AppLocalizations.of(context)!.incorrectHeightOrShape,
    (context)=>AppLocalizations.of(context)!.damagedSurface,
    (context)=>AppLocalizations.of(context)!.other
  ]),
  Hazard(icon: SvgPicture.asset("assets/svg/stop_sign_icon_v3 (1).svg",colorFilter: ColorFilter.mode(AppColors.Primary_Red, BlendMode.srcIn)), hazardName: (context)=>AppLocalizations.of(context)!.roadSign, description: (context)=>AppLocalizations.of(context)!.roadSignDescription, subProblems: [
    (context)=>AppLocalizations.of(context)!.physicalDamage,
    (context)=>AppLocalizations.of(context)!.fadedSurface,
    (context)=>AppLocalizations.of(context)!.missingSign,
    (context)=>AppLocalizations.of(context)!.wrongPosition,
    (context)=>AppLocalizations.of(context)!.other
  ]),
  Hazard(icon: SvgPicture.asset("assets/svg/street_light_icon (1).svg",colorFilter: ColorFilter.mode(AppColors.Primary_Red, BlendMode.srcIn)), hazardName: (context)=>AppLocalizations.of(context)!.streetLight, description: (context)=>AppLocalizations.of(context)!.streetLightDescription, subProblems: [
    (context)=>AppLocalizations.of(context)!.notWorking,
    (context)=>AppLocalizations.of(context)!.dim,
    (context)=>AppLocalizations.of(context)!.flickering,
    (context)=>AppLocalizations.of(context)!.notInstalled,
    (context)=>AppLocalizations.of(context)!.other
  ]),
  Hazard(icon:SvgPicture.asset("assets/svg/abandoned_vehicle_v3 (1).svg",colorFilter: ColorFilter.mode(AppColors.Primary_Red, BlendMode.srcIn)) , hazardName: (context)=>AppLocalizations.of(context)!.abandonedVehicle, description: (context)=>AppLocalizations.of(context)!.abandonedVehicleDescription, subProblems: [
    (context)=>AppLocalizations.of(context)!.oneToThreeDays,
    (context)=>AppLocalizations.of(context)!.moreThan3Days 
  ]),
  Hazard(icon: SvgPicture.asset("assets/svg/no_vehicle_icon (1).svg",colorFilter: ColorFilter.mode(AppColors.Primary_Red, BlendMode.srcIn)), hazardName: (context)=>AppLocalizations.of(context)!.vehicleObstruction, description: (context)=>AppLocalizations.of(context)!.vehicleObstructionDescription, subProblems: [
    (context)=>AppLocalizations.of(context)!.blockingDriveway,
    (context)=>AppLocalizations.of(context)!.blockingParkingSpace,
    (context)=>AppLocalizations.of(context)!.blockingTrafficLane
  ]),
  Hazard(icon: SvgPicture.asset("assets/svg/road_barrier_icon (1).svg",colorFilter: ColorFilter.mode(AppColors.Primary_Red, BlendMode.srcIn)), hazardName: (context)=>AppLocalizations.of(context)!.roadBarrier, description: (context)=>AppLocalizations.of(context)!.roadBarrierDescription, subProblems: [
    (context)=>AppLocalizations.of(context)!.physicalDamage
    ,(context)=>AppLocalizations.of(context)!.notInstalled
  ]),
  Hazard(icon: SvgPicture.asset("assets/svg/rockfall_net_clean (1).svg",colorFilter: ColorFilter.mode(AppColors.Primary_Red, BlendMode.srcIn)), hazardName: (context)=>AppLocalizations.of(context)!.rockfallNet, description: (context)=>AppLocalizations.of(context)!.rockfallNetDescription, subProblems: [
    (context)=>AppLocalizations.of(context)!.physicalDamage,
    (context)=>AppLocalizations.of(context)!.notInstalled
  ])

];
