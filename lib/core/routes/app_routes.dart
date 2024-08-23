import 'package:community_health_app/screens/camp_calendar/ui/camp_calendar_view.dart';
import 'package:community_health_app/screens/camp_calendar/ui/date_wise_camps.dart';
import 'package:community_health_app/screens/camp_calendar/ui/district_wise_camps.dart';
import 'package:community_health_app/screens/camp_approval/camp_approval.dart';
import 'package:community_health_app/screens/camp_coordinator/ui/add_referred_patient.dart';
import 'package:community_health_app/screens/camp_coordinator/ui/camp_coordinator_screen.dart';
import 'package:community_health_app/screens/camp_creation/camp_creation.dart';
import 'package:community_health_app/screens/dashboard/dashboard.dart';
import 'package:community_health_app/screens/location_master/location_master.dart';
import 'package:community_health_app/screens/location_master/location_master_list.dart';
import 'package:community_health_app/screens/patient_registration/ui/patient_registration.dart';
import 'package:community_health_app/screens/patient_registration/ui/patient_registration_edit.dart';
import 'package:community_health_app/screens/patient_registration/ui/registered_patients.dart';
import 'package:community_health_app/screens/camp_approval/camp_approval.dart';
import 'package:community_health_app/screens/camp_creation/camp_creation.dart';
import 'package:community_health_app/screens/location_master/add_location_master.dart';
import 'package:community_health_app/screens/stakeholder/ui/stakeholder_master_edit.dart';
import 'package:community_health_app/screens/stakeholder/ui/stakeholder_master_list.dart';

import 'package:community_health_app/screens/user_master/ui/registered_user_master.dart';
import 'package:community_health_app/screens/stakeholder/ui/stakeholder_master.dart';
import 'package:community_health_app/screens/user_master/ui/user_master.dart';
import 'package:community_health_app/screens/user_master/ui/user_master_edit.dart';
import 'package:community_health_app/user_auths/createnewpassword_view.dart';
import 'package:community_health_app/user_auths/enterpin_view.dart';
import 'package:community_health_app/user_auths/forgotpassword_view.dart';
import 'package:community_health_app/user_auths/login.dart';
import 'package:community_health_app/user_auths/resetpassword_view.dart';
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
  static const String addLocationMaster = "/locationMaster";
  static const String locationMasterList = "/locationMasterList";
  static const String campCreation = "/campCreation";
  static const String patientRegListScreen = "/patientRegListScreen";
  static const String patientRegScreen = "/patientRegScreen";
  static const String patientRegEditScreen = "/patientRegEditScreen";
  static const String userMasterScreen = "/userMasterScreen";
  static const String userMasterEditScreen = "/userMasterEditScreen";
  static const String stakeholderMasterScreen = "/stakeholderMasterScreen";
  static const String stakeholderMasterEditScreen = "/stakeholderMasterEditScreen";
  static const String stakeholderMasterListScreen = "/stakeholderMasterListScreen";
  static const String registeredUserMaster = "/registeredUserMaster";
  static const String pinValidationPage = "/PinValidationPage";
  static const String updatePasswordPage = "/UpdatePasswordPage";
  static const String campCalendar = "/CampCalendarPage";
  static const String dateWiseCamps = "/DateWiseCampsScreen";
  static const String districtWiseCamps = "/DistrictWiseCampsScreen";
  static const String campWiseRegisteredPatients = "/CampWiseRegisteredPatientsScreen";
  static const String campApproval = "/campApproval";
  static const String campCoordinator = "/campCoordinator";
  static const String addReferredPatient = "/addReferredPatient";

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
      case userMasterEditScreen:
        return MaterialPageRoute(
          builder: (_) => const UserMasterEditScreen(),
        );
      case stakeholderMasterScreen:
        return MaterialPageRoute(
          builder: (_) => const StakeHolderMasterScreen(),
        );
      case patientRegListScreen:
        return MaterialPageRoute(
          builder: (_) => const RegisteredPatientsScreen(),
        );
      case patientRegEditScreen:
        return MaterialPageRoute(
          builder: (_) => const PatientRegistrationEditScreen(),
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

      case addLocationMaster:
        return MaterialPageRoute(
          builder: (_) => const AddLocationMaster(),
        );
      case locationMasterList:
        return MaterialPageRoute(
          builder: (_) => const LocationMasterList(),
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
      case campApproval:
        return MaterialPageRoute(
          builder: (_) => const CampApprovalScreen(),
        );
      case stakeholderMasterListScreen:
        return MaterialPageRoute(
          builder: (_) => const StakeholderMasterList(),
        );
      case stakeholderMasterEditScreen:
        return MaterialPageRoute(
          builder: (_) => const StakeHolderMasterEditScreen(),
        );
      case resetPassword:
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordPage(),
        );
      case campCoordinator:
        return MaterialPageRoute(
          builder: (_) => const CampCoordinator(),
        );
      case addReferredPatient:
        return MaterialPageRoute(
          builder: (_) => const AddReferredPatient(),
        );

      default:
        throw const RouteException('Route not found!');
    }
  }
}
