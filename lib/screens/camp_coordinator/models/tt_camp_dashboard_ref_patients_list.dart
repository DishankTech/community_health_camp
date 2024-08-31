import 'dart:convert';

class CampDashboardRefPatientsList {
  List<CampDashboardRefPatients> ttCampDashboardRefPatientsList;

  CampDashboardRefPatientsList({required this.ttCampDashboardRefPatientsList});

  factory CampDashboardRefPatientsList.fromJson(Map<String, dynamic> json) {
    return CampDashboardRefPatientsList(
      ttCampDashboardRefPatientsList: (json['tt_camp_dashboard_ref_patients_list'] as List)
          .map((item) => CampDashboardRefPatients.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tt_camp_dashboard_ref_patients_list':
      ttCampDashboardRefPatientsList.map((item) => item.toJson()).toList(),
    };
  }
}

class CampDashboardRefPatients {
  String? dashboardRefPatientsId;
  String? campDashboardId;
  String? patientId;
  String patientName;
  int? age;
  String? lookupDetIdGender;
  String contactNumber;
  int orgId;
  int status;
  List<CampDashboardRefPatientsDet> ttCampDashboardRefPatientsDetList;

  CampDashboardRefPatients({
    this.dashboardRefPatientsId,
    this.campDashboardId,
    this.patientId,
    required this.patientName,
    this.age,
    this.lookupDetIdGender,
    required this.contactNumber,
    required this.orgId,
    required this.status,
    required this.ttCampDashboardRefPatientsDetList,
  });

  factory CampDashboardRefPatients.fromJson(Map<String, dynamic> json) {
    return CampDashboardRefPatients(
      dashboardRefPatientsId: json['dashboard_ref_patients_id'],
      campDashboardId: json['camp_dashboard_id'],
      patientId: json['patient_id'],
      patientName: json['patient_name'],
      age: json['age'],
      lookupDetIdGender: json['lookup_det_id_gender'],
      contactNumber: json['contact_number'],
      orgId: json['org_id'],
      status: json['status'],
      ttCampDashboardRefPatientsDetList: (json['tt_camp_dashboard_ref_patients_det_list'] as List)
          .map((item) => CampDashboardRefPatientsDet.fromJson(item))
          .toList(),
    );
  }

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
      'tt_camp_dashboard_ref_patients_det_list':
      ttCampDashboardRefPatientsDetList.map((item) => item.toJson()).toList(),
    };
  }
}

class CampDashboardRefPatientsDet {
  String? dashboardRefPatientsDetId;
  String? dashboardRefPatientsId;
  String? lookupDetHierIdStakeholderSubType2;
  int stakeholderMasterId;
  int orgId;
  int status;

  CampDashboardRefPatientsDet({
    this.dashboardRefPatientsDetId,
    this.dashboardRefPatientsId,
    this.lookupDetHierIdStakeholderSubType2,
    required this.stakeholderMasterId,
    required this.orgId,
    required this.status,
  });

  factory CampDashboardRefPatientsDet.fromJson(Map<String, dynamic> json) {
    return CampDashboardRefPatientsDet(
      dashboardRefPatientsDetId: json['dashboard_ref_patients_det_id'],
      dashboardRefPatientsId: json['dashboard_ref_patients_id'],
      lookupDetHierIdStakeholderSubType2: json['lookup_det_hier_id_stakeholder_sub_type2'],
      stakeholderMasterId: json['stakeholder_master_id'],
      orgId: json['org_id'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dashboard_ref_patients_det_id': dashboardRefPatientsDetId,
      'dashboard_ref_patients_id': dashboardRefPatientsId,
      'lookup_det_hier_id_stakeholder_sub_type2': lookupDetHierIdStakeholderSubType2,
      'stakeholder_master_id': stakeholderMasterId,
      'org_id': orgId,
      'status': status,
    };
  }
}

// Initialize list to store patients
List<CampDashboardRefPatients> ttCampDashboardRefPatientsList = [];

// Method to add multiple patients
void addPatients(List<CampDashboardRefPatients> patients) {
  ttCampDashboardRefPatientsList.addAll(patients);
}

// Method to update 'ttCampDashboardRefPatientsDetList' for a patient by index
void updatePatientDetails(int index, List<CampDashboardRefPatientsDet> details) {
  if (index >= 0 && index < ttCampDashboardRefPatientsList.length) {
    ttCampDashboardRefPatientsList[index].ttCampDashboardRefPatientsDetList = details;
  } else {
    print("Invalid index.");
  }
}

/*// Example Usage
void main() {
  // Add multiple patients
  addPatients([
    CampDashboardRefPatients(
      patientName: "Test1",
      contactNumber: "9999999999",
      orgId: 1,
      status: 1,
      ttCampDashboardRefPatientsDetList: [],
    ),
    CampDashboardRefPatients(
      patientName: "Test2",
      contactNumber: "8888888888",
      orgId: 1,
      status: 1,
      ttCampDashboardRefPatientsDetList: [],
    ),
  ]);

  // Update 'ttCampDashboardRefPatientsDetList' for the first patient
  updatePatientDetails(0, [
    CampDashboardRefPatientsDet(
      stakeholderMasterId: 3168,
      orgId: 1,
      status: 1,
    ),
    CampDashboardRefPatientsDet(
      stakeholderMasterId: 3169,
      orgId: 1,
      status: 1,
    ),
  ]);

  // Print updated list
  print(jsonEncode(ttCampDashboardRefPatientsList.map((patient) => patient.toJson()).toList()));
}*/
