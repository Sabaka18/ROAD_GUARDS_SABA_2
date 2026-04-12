import 'dart:ui';

import 'package:roadguard/core/constants/appColors.dart';

class ReportStatus{
  late int counter;
  late String Text;
  late Color StatusColor; 
  ReportStatus({required this.counter,required this.Text, required this.StatusColor});

}

List<ReportStatus> reportStatus = [
  ReportStatus(counter: 0, Text: "total", StatusColor: AppColors.Primary_Red),
  ReportStatus(counter: 0, Text: "resolved", StatusColor: AppColors.ResolvedStatus),
  ReportStatus(counter: 0, Text: "pending", StatusColor:Color(0xffA06000)),
];