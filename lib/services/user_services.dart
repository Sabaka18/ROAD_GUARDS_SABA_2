
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Map<String,dynamic>> create_user(String email,String full_name,String password,String phone_number)async{
  
  
  try {
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
     final user= _firebaseAuth.currentUser;
 final url = Uri.parse("https://ydco1qqdie.execute-api.eu-north-1.amazonaws.com/users");
    final response = await http.post(
      url,
      headers: {"Content-Type":"application/json"},
      body: jsonEncode({
        "full_name":full_name,
        "phone_number":phone_number,
        "firebase_uid": user?.uid,

      }) 
    );

     final Map<String,dynamic> result = jsonDecode(response.body);
    if(response.statusCode==200)
    {
      return {"success": true, "message": "user created successfully"};
     
    }else{
      if(user!=null){
        await user.delete();
      }
      return {"success": false, "message": result['error'] ?? "unknownErrorServer"};
    }
   
    
    
    
  } 
  on FirebaseAuthException catch(e){
    if(e.code == 'email-already-in-use')
    return {"success": false, "message": "emailAlreadyExists"};
  }
  
  return{};
 }


 Future<Map<String, dynamic>> user_LogIn({
  required email,
  required password
 })  async {
  try{
   FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
     await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
     return {"success":true ,"message":"Logged In Successfully" };
  }on FirebaseAuthException catch(e){
    if(e.code=="invalid-credential"){
      return  {"success":false ,"message":"incorrectEmailOrPassword" };
    }
    else if(e.code=="invalid-email"){
      return  {"success":false ,"message":"invalidEmail" };
    }
    return {};

  }



 }
 Future<Map<String,dynamic>> get_user_info(String uid)async{
  final url = Uri.parse("https://ydco1qqdie.execute-api.eu-north-1.amazonaws.com/user/${uid}");
  final response = await http.get(url);

  final result = json.decode(response.body);
  if(response.statusCode==200){
    return {"success":true,"result":result};
  }
  else 
  return {"success":false,"result":"error occured"};

 }
 

  
