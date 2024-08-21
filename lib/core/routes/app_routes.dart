import 'package:community_health_app/screens/camp_creation/camp_creation.dart';
import 'package:community_health_app/screens/location_master/location_master.dart';
import 'package:community_health_app/screens/patient_registration/patient_registration.dart';
import 'package:community_health_app/screens/patient_registration/user_master.dart';
import 'package:flutter/material.dart';

import 'package:community_health_app/screens/splash_screen.dart';
import 'package:community_health_app/core/exceptions/route_exception.dart';

class AppRoutes {
  const AppRoutes._();

  static const String splash = "/";
  static const String loginScreen = "/loginScreen";
  static const String introScreen = "/introScreen";
  static const String dashboard = "/dashboard";
  static const String mobileOTP = "/mobileOTP";
  static const String setOTP = "/setOTP";
  static const String homeScreen = "/homeScreen";
  static const String forgotScreen = "/forgotScreen";
  static const String forgotPasswordOTP = "/forgotPasswordOTP";
  static const String resetPassword = "/resetPassword";
  static const String otpLoginScreen = "/otpLoginScreen";
  static const String registredPatientList = "/registredPatientList";
  static const String newRegistration = "/newRegistration";
  static const String bookAppointments = "/bookAppointments";
  static const String myAppointments = "/myAppointments";
  static const String confirmLoginOTP = "/confirmLoginOTP";
  static const String profileScreen = "/profileScreen";
  static const String registeredPatientScreen = "/registeredPatientScreen";
  static const String addFamilyMemberScreen = "/addFamilyMemberScreen";
  static const String updateFamilyMemberScreen = "/updateFamilyMemberScreen";
  static const String idCardList = "/idCardList";
  static const String idCard = "/idCard";
  static const String locationMaster = "/locationMaster";
  static const String campCreation = "/campCreation";
  static const String patientRegScreen = "/patientRegScreen";
  static const String userMasterScreen = "/userMasterScreen";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case patientRegScreen:
        return MaterialPageRoute(
          builder: (_) => const PatientRegistrationScreen(),
        );
      case userMasterScreen:
        return MaterialPageRoute(
          builder: (_) => const UserMasterScreen(),
        );

      case locationMaster:
        return MaterialPageRoute(
          builder: (_) => const LocationMaster(),
        );
      case campCreation:
        return MaterialPageRoute(
          builder: (_) => const CampCreation(),
        );

      default:
        throw const RouteException('Route not found!');
    }
  }
}
