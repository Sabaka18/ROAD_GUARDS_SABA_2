 import 'dart:convert';

import 'package:http/http.dart' as http;

class HazardService {  

  static final HazardService instance = HazardService._internal();  

  HazardService._internal();  

  List<dynamic> hazardData = [];  
  List<dynamic> subProblems = [];

}

Future<List<dynamic>> get_hazard_info()async{
  final url = Uri.parse("https://ydco1qqdie.execute-api.eu-north-1.amazonaws.com/get_hazards");
  final response = await http.get(url);

  final result = json.decode(response.body);
  if(response.statusCode==200){
    return result;
  }
  else 
  return [];

 }
 Future<List<dynamic>> get_sub_hazard_info()async{
  final url = Uri.parse("https://ydco1qqdie.execute-api.eu-north-1.amazonaws.com/subcategory/");
  final response = await http.get(url);

  final result = json.decode(response.body);
  if(response.statusCode==200){
    return result;
  }
  else 
  return [-1];

 }
 
 