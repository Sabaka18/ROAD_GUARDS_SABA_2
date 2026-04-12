import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:roadguard/l10n/app_localizations.dart';

Future<LatLng?> getCurrentPosition() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) return null;

  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied|| permission==LocationPermission.unableToDetermine) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return null;
  }

  if (permission == LocationPermission.deniedForever) return null;

  Position pos = await Geolocator.getCurrentPosition(
    
  );

  return LatLng(pos.latitude, pos.longitude);
}

 Future<String> getPlaceName(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        
        position.latitude,
        position.longitude,
        
        
      );
      
     
      Placemark place = placemarks.first;
      return ' ${place.subLocality},  ${place.street},  ';
    } catch (e) {
      return 'Unknown location';
    }
  }
  


