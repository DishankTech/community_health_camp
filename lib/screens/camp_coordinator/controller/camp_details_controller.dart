import 'package:community_health_app/screens/camp_coordinator/models/camp_details_referredpatients_request_model.dart';
import 'package:community_health_app/screens/camp_coordinator/models/multiple_referred_to_request_model.dart';
import 'package:community_health_app/screens/camp_coordinator/models/tt_camp_dashboard_ref_patients_list.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../models/camp_coordinator_registered_patient_model.dart';

class CampDetailsController extends GetxController {

  List<TtCampDashboardRefStakeHoldersDet> campReferredPatientStakeholderList = [];
  List<TtCampDashboardRefPatients> campReferredPatientList = [];

  // List<Map<String, dynamic>> ttCampDashboardRefPatientsDetList = [];
  List<Map<String, dynamic>> ttCampDashboardRefPatientsDetList = [];
  List<Map<String, dynamic>> ttCampDashboardRefPatientsNamesList = [];
  
  String camDashboardId="";

  late TtCampDashboardRefStakeHoldersDet stakeHolderDetailFromJson;
 var patientDetailsFromJson;

  TextEditingController patientsReferred = TextEditingController();

  List<CampDashboardRefPatients> patientList = [];

  List<CampCoordRegisteredPatientModel> campregisteredpatients = [];




   createMultiStakeholderJson(List selectedItems) {

    for(int i=0;i<selectedItems.length;i++)
    {
      var patientDetail = TtCampDashboardRefStakeHoldersDet(
        dashboardRefPatientsDetId: null,
        dashboardRefPatientsId: null,
        lookupDetHierIdStakeholderSubType2: null,
        stakeholderMasterId: int.parse(selectedItems[i]["stakeholder_master_id"].toString()),
      );
      Map<String, dynamic> json = patientDetail.toJson();
      stakeHolderDetailFromJson = TtCampDashboardRefStakeHoldersDet.fromJson(json);

      print("patientDetailFromJson===============");
      print(stakeHolderDetailFromJson);
      campReferredPatientStakeholderList.add(stakeHolderDetailFromJson);

    }
  }

  createMultiplePatients(List<CampCoordRegisteredPatientModel> campRegisteredPatients) {

    List<TtCampDashboardRefStakeHoldersDet> detailsList = ttCampDashboardRefPatientsDetList
        .map((item) => TtCampDashboardRefStakeHoldersDet.fromJson(item))
        .toList();

    for(int i=0;i<campRegisteredPatients.length;i++)
    {
      var patientDetail = TtCampDashboardRefPatients(
        dashboardRefPatientsId: null,
        campDashboardId: int.parse(camDashboardId),
        patientId: null,
        patientName: campRegisteredPatients[i].name.toString(),
        age: null,
        lookupDetIdGender: null,
        contactNumber: campRegisteredPatients[i].mobile.toString(),
        orgId: 1,
        status: 1,
        detailsList: detailsList,
      );
      Map<String, dynamic> json = patientDetail.toJson();
      patientDetailsFromJson = TtCampDashboardRefPatients.fromJson(json);

      print("patientDetailFromJson===============");
      print(patientDetailsFromJson);


    }

    campReferredPatientList.add(patientDetailsFromJson);
    patientDetailsFromJson = null;

    Map<String, dynamic> json_actual = {
      "actual_list":
      campReferredPatientList.map((patient) => patient.toJson()).toList()
    };

    print(json_actual);
  }



}