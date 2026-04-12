import 'package:flutter/widgets.dart';
import 'package:roadguard/models/Hazard_types.dart';

class HazardAnimation extends StatefulWidget {
  const HazardAnimation({super.key});

  @override
  State<HazardAnimation> createState() => _HazardAnimationState();
}

class _HazardAnimationState extends State<HazardAnimation> {
  List<bool> visible = [];
  @override
  void initState() {
    super.initState();
    visible = List.filled(hazards.length, false);
    for(int i=0;i<visible.length;i++){
      Future.delayed(Duration(milliseconds: 300*i),(){
        setState(() {
          visible[i]=true;
        });

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    
    return const Placeholder();
  }
}