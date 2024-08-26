class TtPatientDoctorDesk {
  TtPatientDoctorDesk({
      this.patientDoctorDeskId, 
      this.patientId, 
      this.campCreateRequestId, 
      this.campDate, 
      this.userId, 
      this.symptons, 
      this.provisionalDiagnosis, 
      this.orgId, 
      this.status,});

  TtPatientDoctorDesk.fromJson(dynamic json) {
    patientDoctorDeskId = json['patient_doctor_desk_id'];
    patientId = json['patient_id'];
    campCreateRequestId = json['camp_create_request_id'];
    campDate = json['camp_date'];
    userId = json['user_id'];
    symptons = json['symptons'];
    provisionalDiagnosis = json['provisional_diagnosis'];
    orgId = json['org_id'];
    status = json['status'];
  }
  int? patientDoctorDeskId;
  int? patientId;
  int? campCreateRequestId;
  String? campDate;
  int? userId;
  String? symptons;
  String? provisionalDiagnosis;
  int? orgId;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patient_doctor_desk_id'] = patientDoctorDeskId;
    map['patient_id'] = patientId;
    map['camp_create_request_id'] = campCreateRequestId;
    map['camp_date'] = campDate;
    map['user_id'] = userId;
    map['symptons'] = symptons;
    map['provisional_diagnosis'] = provisionalDiagnosis;
    map['org_id'] = orgId;
    map['status'] = status;
    return map;
  }

}