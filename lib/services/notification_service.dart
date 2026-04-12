import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
FirebaseMessaging messaging = FirebaseMessaging.instance;

void requestNotificationPermission()async{
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    criticalAlert: true,
    sound: true,

  );
  if(settings.authorizationStatus == AuthorizationStatus.authorized ){
    print("Permission granted by user");
  }else {
    print("Permission Denied by user");

  }
}

Future<String> getFcmtoken()async{
  String? token= await messaging.getToken();
  print("Token :${token}");
  return token!;


}


}