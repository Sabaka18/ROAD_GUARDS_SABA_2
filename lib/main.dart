import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:roadguard/core/constants/appColors.dart';
import 'package:roadguard/firebase_options.dart';
import 'package:roadguard/l10n/app_localizations.dart';
import 'package:roadguard/models/profile_model.dart';
import 'package:roadguard/screens/Hazards.dart';
import 'package:roadguard/screens/appDetail.dart';
import 'package:roadguard/screens/home.dart';
import 'package:roadguard/screens/login.dart';
import 'package:roadguard/screens/mainPage.dart';
import 'package:roadguard/screens/profile.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:roadguard/screens/reportDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> _backgroundMessageHandler(RemoteMessage message)async{
 await Firebase.initializeApp();
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
 
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool hasSeenSplash = pref.getBool('hasSeenSplash') ?? false;

  
  
  if (!hasSeenSplash) {
    pref.setBool('hasSeenSplash', true); //for the next app launch
  } 

  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: MyApp(hasSeenSplash: hasSeenSplash),
    ),
  );
}

class MyApp extends StatefulWidget {
  final bool hasSeenSplash;
  MyApp({super.key, required this.hasSeenSplash});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget homeScreen;
    if(!widget.hasSeenSplash)
    homeScreen = Appdetail();
    else
    homeScreen = LogIn();
    final localeProvider = Provider.of<LocaleProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          supportedLocales: [Locale('en'), Locale('ar')],
          routes: {
            'appDetail': (context) => Appdetail(),
            'login': (context) => LogIn(),
          },
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: localeProvider.locale,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              fontFamily: localeProvider.locale == Locale("en")
                  ? "EnglishFont"
                  : "ArabicFont",
              scaffoldBackgroundColor: AppColors.background,
              textSelectionTheme: TextSelectionThemeData(
                  cursorColor: AppColors.Primary_Red,
                  selectionHandleColor: AppColors.Primary_Red,
                  selectionColor: Color(0xffFEF2F2))),
          home: PageDecider(hasSeenSplah: widget.hasSeenSplash),
        );
      },
    );
  }
}
class PageDecider extends StatelessWidget {
  final bool hasSeenSplah;
  const PageDecider({super.key,required this.hasSeenSplah});

  @override
  Widget build(BuildContext context) {
    if(!hasSeenSplah)
    return Appdetail();

    return StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(), 
    builder: (context,snapshot){
      if(snapshot.connectionState == ConnectionState.waiting)
      {
        return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
      }
      if(snapshot.hasData){
        return Mainpage();
      }
      return LogIn();

    });
    
  }
}
