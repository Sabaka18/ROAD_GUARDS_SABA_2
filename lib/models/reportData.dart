import 'dart:io';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Reportdata {
  int? category_id;
  int? subCategory_id;
  String? location;
  File? image;
  String? description;
  var icon;
  LatLng? pos;
  Reportdata({this.category_id,this.subCategory_id,this.location,this.description,this.image, this.pos});
}