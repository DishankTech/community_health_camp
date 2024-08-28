import 'package:community_health_app/screens/camp_coordinator/models/multiple_referred_to_request_model.dart';

class TtCampDashboardRefPatients {
  int? dashboardRefPatientsId;
  int? campDashboardId;
  int? patientId;
  String? patientName;
  int? age;
  int? lookupDetIdGender;
  String? contactNumber;
  int orgId;
  int status;
  List<TtCampDashboardRefStakeHoldersDet> detailsList;

  TtCampDashboardRefPatients({
    this.dashboardRefPatientsId,
    this.campDashboardId,
    this.patientId,
    this.patientName,
    this.age,
    this.lookupDetIdGender,
    this.contactNumber,
    this.orgId = 1,
    this.status = 1,
    required this.detailsList,
  });

  // Factory method to create an instance from JSON
  factory TtCampDashboardRefPatients.fromJson(Map<String, dynamic> json) {

    var list = json['tt_camp_dashboard_ref_patients_det_list'] as List;
    List<TtCampDashboardRefStakeHoldersDet> detailsList = list.map((i) => TtCampDashboardRefStakeHoldersDet.fromJson(i)).toList();


    return TtCampDashboardRefPatients(
      dashboardRefPatientsId: json['dashboard_ref_patients_id'],
      campDashboardId: json['camp_dashboard_id'],
      patientId: json['patient_id'],
      patientName: json['patient_name'],
      age: json['age'],
      lookupDetIdGender: json['lookup_det_id_gender'],
      contactNumber: json['contact_number'],
      orgId: json['org_id'] ?? 1,
      status: json['status'] ?? 1,
      detailsList: detailsList,
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'dashboard_ref_patients_id': dashboardRefPatientsId,
      'camp_dashboard_id': campDashboardId,
      'patient_id': patientId,
      'patient_name': patientName,
      'age': age,
      'lookup_det_id_gender': lookupDetIdGender,
      'contact_number': contactNumber,
      'org_id': orgId,
      'status': status,
      'tt_camp_dashboard_ref_patients_det_list': detailsList.map((i) => i.toJson()).toList(),

    };
  }
}
