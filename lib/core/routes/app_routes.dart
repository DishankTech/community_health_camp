import 'package:community_health_app/screens/camp_calendar/ui/camp_calendar_view.dart';
import 'package:community_health_app/screens/camp_calendar/ui/date_wise_camps.dart';
import 'package:community_health_app/screens/camp_calendar/ui/district_wise_camps.dart';
import 'package:community_health_app/screens/camp_creation/camp_creation.dart';
import 'package:community_health_app/screens/dashboard/ui/dashboard_view.dart';
import 'package:community_health_app/screens/location_master/location_master.dart';
import 'package:community_health_app/screens/patient_registration/patient_registration.dart';
import 'package:community_health_app/screens/patient_registration/registered_patients.dart';
import 'package:community_health_app/screens/patient_registration/registered_user_master.dart';
import 'package:community_health_app/screens/patient_registration/stakeholder_master.dart';
import 'package:community_health_app/screens/patient_registration/user_master.dart';
import 'package:community_health_app/user_auths/createnewpassword_view.dart';
import 'package:community_health_app/user_auths/enterpin_view.dart';
import 'package:community_health_app/user_auths/forgotpassword_view.dart';
import 'package:community_health_app/user_auths/login.dart';
import 'package:flutter/material.dart';

import 'package:community_health_app/screens/splash_screen.dart';
import 'package:community_health_app/core/exceptions/route_exception.dart';

import '../../screens/camp_calendar/ui/camp_wise_registered_patients.dart';

class AppRoutes {
  const AppRoutes._();

  static const String splash = "/";
  static const String loginScreen = "/loginScreen";
  static const String introScreen = "/introScreen";
  static const String dashboard = "/dashboard_view";
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
  static const String patientRegListScreen = "/patientRegListScreen";
  static const String patientRegScreen = "/patientRegScreen";
  static const String userMasterScreen = "/userMasterScreen";
  static const String stakeholderMasterScreen = "/stakeholderMasterScreen";
  static const String registeredUserMaster = "/registeredUserMaster";
  static const String pinValidationPage = "/PinValidationPage";
  static const String updatePasswordPage = "/UpdatePasswordPage";
  static const String campCalendar = "/CampCalendarPage";
  static const String dateWiseCamps = "/DateWiseCampsScreen";
  static const String districtWiseCamps = "/DistrictWiseCampsScreen";
  static const String campWiseRegisteredPatients = "/CampWiseRegisteredPatientsScreen";

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
      case stakeholderMasterScreen:
        return MaterialPageRoute(
          builder: (_) => const StakeHolderMasterScreen(),
        );
      case patientRegListScreen:
        return MaterialPageRoute(
          builder: (_) => const RegisteredPatientsScreen(),
        );
      case registeredUserMaster:
        return MaterialPageRoute(
          builder: (_) => const RegisteredUserMasterScreen(),
        );
      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(
            title: "Login",
          ),
        );
      case forgotScreen:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordPage(),
        );
      case pinValidationPage:
        return MaterialPageRoute(
          builder: (_) => const PinValidationPage(),
        );
      case updatePasswordPage:
        return MaterialPageRoute(
          builder: (_) => const UpdatePasswordPage(),
        );

      case locationMaster:
        return MaterialPageRoute(
          builder: (_) => const LocationMaster(),
        );
      case campCreation:
        return MaterialPageRoute(
          builder: (_) => const CampCreation(),
        );
      case dashboard:
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        );
      case campCalendar:
        return MaterialPageRoute(
          builder: (_) => const CampCalendarPage(),
        );
      case dateWiseCamps:
        return MaterialPageRoute(
          builder: (_) => const DateWiseCampsScreen(),
        );
      case districtWiseCamps:
        return MaterialPageRoute(
          builder: (_) => const DistrictWiseCampsScreen(),
        );
      case campWiseRegisteredPatients:
        return MaterialPageRoute(
          builder: (_) => const CampWiseRegisteredPatientsScreen(),
        );

      default:
        throw const RouteException('Route not found!');
    }
  }
}
