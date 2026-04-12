import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @whatIsRG.
  ///
  /// In en, this message translates to:
  /// **'What is RoadGuard?'**
  String get whatIsRG;

  /// No description provided for @splashScreen1p1.
  ///
  /// In en, this message translates to:
  /// **'Your city\'s safety net'**
  String get splashScreen1p1;

  /// No description provided for @splashScreen1p2.
  ///
  /// In en, this message translates to:
  /// **'RoadGuard is an official government platform that lets citizens report road hazards directly to municipal maintenance teams — no phone calls, no waiting.'**
  String get splashScreen1p2;

  /// No description provided for @howItWorks.
  ///
  /// In en, this message translates to:
  /// **'How it works?'**
  String get howItWorks;

  /// No description provided for @splashScreen2p1.
  ///
  /// In en, this message translates to:
  /// **'Three steps to a safer road'**
  String get splashScreen2p1;

  /// No description provided for @splashScreen2p2.
  ///
  /// In en, this message translates to:
  /// **'Spot a hazard → take a photo and drop a GPS pin → submit. Our AI analyses severity and estimated repair cost automatically before dispatching.'**
  String get splashScreen2p2;

  /// No description provided for @whyItMatters.
  ///
  /// In en, this message translates to:
  /// **'Why it matters?'**
  String get whyItMatters;

  /// No description provided for @splashScreen3p1.
  ///
  /// In en, this message translates to:
  /// **'Reports become real repairs'**
  String get splashScreen3p1;

  /// No description provided for @splashScreen3p2.
  ///
  /// In en, this message translates to:
  /// **'Every submission is logged, prioritised by AI severity score, and assigned to a maintenance crew. You receive a reference ID and can track status in-app.'**
  String get splashScreen3p2;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @welcomeBackSignIn.
  ///
  /// In en, this message translates to:
  /// **'Welcome back! — enter your credentials to continue. '**
  String get welcomeBackSignIn;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already Have An Account?'**
  String get alreadyHaveAnAccount;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @newToRG.
  ///
  /// In en, this message translates to:
  /// **'New to RoadGuard'**
  String get newToRG;

  /// No description provided for @createAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Create An Account'**
  String get createAnAccount;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @registerAs.
  ///
  /// In en, this message translates to:
  /// **'Register as a verified citizen reporter. '**
  String get registerAs;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @signInInstead.
  ///
  /// In en, this message translates to:
  /// **'Sign In Instead'**
  String get signInInstead;

  /// No description provided for @reportARoadHazard.
  ///
  /// In en, this message translates to:
  /// **'Report A Road Hazard'**
  String get reportARoadHazard;

  /// No description provided for @submitWithLiveGPSLocation.
  ///
  /// In en, this message translates to:
  /// **'Submit With Live GPS Location'**
  String get submitWithLiveGPSLocation;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @resolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get resolved;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @myReports.
  ///
  /// In en, this message translates to:
  /// **'My Reports'**
  String get myReports;

  /// No description provided for @submitted.
  ///
  /// In en, this message translates to:
  /// **'Submitted'**
  String get submitted;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @pastReports.
  ///
  /// In en, this message translates to:
  /// **'Past Reports'**
  String get pastReports;

  /// No description provided for @hazardSelection.
  ///
  /// In en, this message translates to:
  /// **'Select the type of road hazard you wish to report.'**
  String get hazardSelection;

  /// No description provided for @specifyTheIssue.
  ///
  /// In en, this message translates to:
  /// **'Specify The Issue'**
  String get specifyTheIssue;

  /// No description provided for @pothole.
  ///
  /// In en, this message translates to:
  /// **'Pothole'**
  String get pothole;

  /// No description provided for @potholeDescription.
  ///
  /// In en, this message translates to:
  /// **'Hole or depression in road surface'**
  String get potholeDescription;

  /// No description provided for @trafficLight.
  ///
  /// In en, this message translates to:
  /// **'Traffic Light'**
  String get trafficLight;

  /// No description provided for @trafficLightDescription.
  ///
  /// In en, this message translates to:
  /// **'Faulty or damaged traffic signals'**
  String get trafficLightDescription;

  /// No description provided for @roadDrain.
  ///
  /// In en, this message translates to:
  /// **'Road Drain'**
  String get roadDrain;

  /// No description provided for @roadDrainDescription.
  ///
  /// In en, this message translates to:
  /// **'Blocked or broken drainage'**
  String get roadDrainDescription;

  /// No description provided for @manholeCover.
  ///
  /// In en, this message translates to:
  /// **'Manhole Cover'**
  String get manholeCover;

  /// No description provided for @manholeCoverDescription.
  ///
  /// In en, this message translates to:
  /// **'Missing or damaged manhole cover'**
  String get manholeCoverDescription;

  /// No description provided for @speedBump.
  ///
  /// In en, this message translates to:
  /// **'Speed Bump'**
  String get speedBump;

  /// No description provided for @speedBumpDescription.
  ///
  /// In en, this message translates to:
  /// **'Unmarked or misshapen speed bumps'**
  String get speedBumpDescription;

  /// No description provided for @roadSign.
  ///
  /// In en, this message translates to:
  /// **'Road Sign'**
  String get roadSign;

  /// No description provided for @roadSignDescription.
  ///
  /// In en, this message translates to:
  /// **'Damaged, faded or missing signs'**
  String get roadSignDescription;

  /// No description provided for @streetLight.
  ///
  /// In en, this message translates to:
  /// **'Street Light'**
  String get streetLight;

  /// No description provided for @streetLightDescription.
  ///
  /// In en, this message translates to:
  /// **'Faulty or absent street lighting'**
  String get streetLightDescription;

  /// No description provided for @abandonedVehicle.
  ///
  /// In en, this message translates to:
  /// **'Abandoned Vehicle'**
  String get abandonedVehicle;

  /// No description provided for @abandonedVehicleDescription.
  ///
  /// In en, this message translates to:
  /// **'Vehicle left blocking the road'**
  String get abandonedVehicleDescription;

  /// No description provided for @vehicleObstruction.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Obstruction'**
  String get vehicleObstruction;

  /// No description provided for @vehicleObstructionDescription.
  ///
  /// In en, this message translates to:
  /// **'Another vehicle is blocking yours'**
  String get vehicleObstructionDescription;

  /// No description provided for @roadBarrier.
  ///
  /// In en, this message translates to:
  /// **'Road Barrier'**
  String get roadBarrier;

  /// No description provided for @roadBarrierDescription.
  ///
  /// In en, this message translates to:
  /// **'Damaged or missing metal barriers'**
  String get roadBarrierDescription;

  /// No description provided for @rockfallNet.
  ///
  /// In en, this message translates to:
  /// **'Rockfall Net'**
  String get rockfallNet;

  /// No description provided for @rockfallNetDescription.
  ///
  /// In en, this message translates to:
  /// **'Damaged or absent rockfall protection'**
  String get rockfallNetDescription;

  /// No description provided for @stuckOnOneColor.
  ///
  /// In en, this message translates to:
  /// **'Stuck on one color'**
  String get stuckOnOneColor;

  /// No description provided for @physicalDamage.
  ///
  /// In en, this message translates to:
  /// **'Physical Damage'**
  String get physicalDamage;

  /// No description provided for @noLight.
  ///
  /// In en, this message translates to:
  /// **'No Light'**
  String get noLight;

  /// No description provided for @dimOrFlickering.
  ///
  /// In en, this message translates to:
  /// **'Dim or flickering'**
  String get dimOrFlickering;

  /// No description provided for @incorrectTiming.
  ///
  /// In en, this message translates to:
  /// **'incorrect timing'**
  String get incorrectTiming;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @missingLid.
  ///
  /// In en, this message translates to:
  /// **'Missing Lid'**
  String get missingLid;

  /// No description provided for @brokenLid.
  ///
  /// In en, this message translates to:
  /// **'BrokenLid'**
  String get brokenLid;

  /// No description provided for @cloggedDrain.
  ///
  /// In en, this message translates to:
  /// **'Clogged Drain'**
  String get cloggedDrain;

  /// No description provided for @missingCover.
  ///
  /// In en, this message translates to:
  /// **'Missing Cover'**
  String get missingCover;

  /// No description provided for @brokenCover.
  ///
  /// In en, this message translates to:
  /// **'Broken Cover'**
  String get brokenCover;

  /// No description provided for @raisedOrSunken.
  ///
  /// In en, this message translates to:
  /// **'Raised Or Sunken'**
  String get raisedOrSunken;

  /// No description provided for @noPaint.
  ///
  /// In en, this message translates to:
  /// **'No Paint'**
  String get noPaint;

  /// No description provided for @incorrectHeightOrShape.
  ///
  /// In en, this message translates to:
  /// **'Incorrect height or shape'**
  String get incorrectHeightOrShape;

  /// No description provided for @damagedSurface.
  ///
  /// In en, this message translates to:
  /// **'Damaged surface'**
  String get damagedSurface;

  /// No description provided for @fadedSurface.
  ///
  /// In en, this message translates to:
  /// **'Faded surface'**
  String get fadedSurface;

  /// No description provided for @missingSign.
  ///
  /// In en, this message translates to:
  /// **'Missing sign'**
  String get missingSign;

  /// No description provided for @wrongPosition.
  ///
  /// In en, this message translates to:
  /// **'Wrong position'**
  String get wrongPosition;

  /// No description provided for @notWorking.
  ///
  /// In en, this message translates to:
  /// **'Not working'**
  String get notWorking;

  /// No description provided for @dim.
  ///
  /// In en, this message translates to:
  /// **'Dim'**
  String get dim;

  /// No description provided for @flickering.
  ///
  /// In en, this message translates to:
  /// **'Flickering'**
  String get flickering;

  /// No description provided for @notInstalled.
  ///
  /// In en, this message translates to:
  /// **'Not installed'**
  String get notInstalled;

  /// No description provided for @oneToThreeDays.
  ///
  /// In en, this message translates to:
  /// **'1-3 days'**
  String get oneToThreeDays;

  /// No description provided for @moreThan3Days.
  ///
  /// In en, this message translates to:
  /// **'More than 3 days'**
  String get moreThan3Days;

  /// No description provided for @blockingDriveway.
  ///
  /// In en, this message translates to:
  /// **'Blocking driveway'**
  String get blockingDriveway;

  /// No description provided for @blockingParkingSpace.
  ///
  /// In en, this message translates to:
  /// **'Blocking parking space'**
  String get blockingParkingSpace;

  /// No description provided for @blockingTrafficLane.
  ///
  /// In en, this message translates to:
  /// **'Blocking traffic lane'**
  String get blockingTrafficLane;

  /// No description provided for @confirmLocation.
  ///
  /// In en, this message translates to:
  /// **'Confirm Location'**
  String get confirmLocation;

  /// No description provided for @reloadLocation.
  ///
  /// In en, this message translates to:
  /// **'Reload Location'**
  String get reloadLocation;

  /// No description provided for @couldNotGetLocation.
  ///
  /// In en, this message translates to:
  /// **'Could not get location. Please enable GPS.'**
  String get couldNotGetLocation;

  /// No description provided for @locationRequired.
  ///
  /// In en, this message translates to:
  /// **'Your Location is required to mark this hazard for maintenance teams.'**
  String get locationRequired;

  /// No description provided for @searchHintText.
  ///
  /// In en, this message translates to:
  /// **'Search for any Place'**
  String get searchHintText;

  /// No description provided for @locationAcquired.
  ///
  /// In en, this message translates to:
  /// **'Location Acquired'**
  String get locationAcquired;

  /// No description provided for @locationNotAcquired.
  ///
  /// In en, this message translates to:
  /// **'Location Not Acquired'**
  String get locationNotAcquired;

  /// No description provided for @addDetails.
  ///
  /// In en, this message translates to:
  /// **'Add Details'**
  String get addDetails;

  /// No description provided for @photoEvidence.
  ///
  /// In en, this message translates to:
  /// **'Photo Evidence'**
  String get photoEvidence;

  /// No description provided for @tapToAttachAPhoto.
  ///
  /// In en, this message translates to:
  /// **'Tap To Attach A Photo'**
  String get tapToAttachAPhoto;

  /// No description provided for @photoTypes.
  ///
  /// In en, this message translates to:
  /// **'JPG,PNG up to 10 MB'**
  String get photoTypes;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description (optional)'**
  String get description;

  /// No description provided for @descrtionHintText.
  ///
  /// In en, this message translates to:
  /// **'Describe the hazard — size, duration, danger level etc; '**
  String get descrtionHintText;

  /// No description provided for @runAIAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Run AI Analysis'**
  String get runAIAnalysis;

  /// No description provided for @aiReview.
  ///
  /// In en, this message translates to:
  /// **'AI Review'**
  String get aiReview;

  /// No description provided for @ai.
  ///
  /// In en, this message translates to:
  /// **'AI'**
  String get ai;

  /// No description provided for @damageAssessment.
  ///
  /// In en, this message translates to:
  /// **'DAMAGE ASSESSMENT'**
  String get damageAssessment;

  /// No description provided for @severity.
  ///
  /// In en, this message translates to:
  /// **'Severity'**
  String get severity;

  /// No description provided for @riskScore.
  ///
  /// In en, this message translates to:
  /// **'Risk Score'**
  String get riskScore;

  /// No description provided for @mild.
  ///
  /// In en, this message translates to:
  /// **'Mild'**
  String get mild;

  /// No description provided for @moderate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get moderate;

  /// No description provided for @severe.
  ///
  /// In en, this message translates to:
  /// **'Severe'**
  String get severe;

  /// No description provided for @submitReport.
  ///
  /// In en, this message translates to:
  /// **'Submit Report'**
  String get submitReport;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @memberSince.
  ///
  /// In en, this message translates to:
  /// **'Member Since'**
  String get memberSince;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @supportAndLegal.
  ///
  /// In en, this message translates to:
  /// **'Support & Legal'**
  String get supportAndLegal;

  /// No description provided for @helpAndFaq.
  ///
  /// In en, this message translates to:
  /// **'Help & FAQ'**
  String get helpAndFaq;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms Of Service'**
  String get termsOfService;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About RoadGuard'**
  String get about;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @session.
  ///
  /// In en, this message translates to:
  /// **'Session'**
  String get session;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get enterEmail;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid Email'**
  String get invalidEmail;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get enterPassword;

  /// No description provided for @enterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your full name'**
  String get enterName;

  /// No description provided for @passwordFormat.
  ///
  /// In en, this message translates to:
  /// **'Your password must be 8–15 characters long, include at least one uppercase letter, at least one special character (such as !, @, #, \$, %, ^, & or *)'**
  String get passwordFormat;

  /// No description provided for @incorrectEmailOrPassword.
  ///
  /// In en, this message translates to:
  /// **'Email or Password is Incorrect'**
  String get incorrectEmailOrPassword;

  /// No description provided for @phoneNumberExists.
  ///
  /// In en, this message translates to:
  /// **'Phone number already exists'**
  String get phoneNumberExists;

  /// No description provided for @emailAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'Email Already Exists'**
  String get emailAlreadyExists;

  /// No description provided for @unknownErrorServer.
  ///
  /// In en, this message translates to:
  /// **'Unknown error from server'**
  String get unknownErrorServer;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter your Phone Number'**
  String get enterPhoneNumber;

  /// No description provided for @invalidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid Phone Number'**
  String get invalidPhoneNumber;

  /// No description provided for @vehicleBlockingYours.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Blocking Yours?'**
  String get vehicleBlockingYours;

  /// No description provided for @reportIt.
  ///
  /// In en, this message translates to:
  /// **'Report it,and we will take care of the rest!'**
  String get reportIt;

  /// No description provided for @notifyVehicleOwner.
  ///
  /// In en, this message translates to:
  /// **'Notify Vehicle Owner'**
  String get notifyVehicleOwner;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
