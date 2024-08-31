class DoctorDeskDiseaseList {
  DoctorDeskDiseaseList({
      this.patientDoctorDeskDiseaseTypesId, 
      this.patientDoctorDeskId, 
      this.lookupDetIdDiseaseTypes, 
      this.orgId, 
      this.status, 
      this.isInactive,});

  DoctorDeskDiseaseList.fromJson(dynamic json) {
    patientDoctorDeskDiseaseTypesId = json['patient_doctor_desk_disease_types_id'];
    patientDoctorDeskId = json['patient_doctor_desk_id'];
    lookupDetIdDiseaseTypes = json['lookup_det_id_disease_types'];
    orgId = json['org_id'];
    status = json['status'];
    isInactive = json['is_inactive'] != null ? json['is_inactive'].cast<String>() : [];
  }
  int? patientDoctorDeskDiseaseTypesId;
  int? patientDoctorDeskId;
  int? lookupDetIdDiseaseTypes;
  int? orgId;
  int? status;
  List<String>? isInactive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patient_doctor_desk_disease_types_id'] = patientDoctorDeskDiseaseTypesId;
    map['patient_doctor_desk_id'] = patientDoctorDeskId;
    map['lookup_det_id_disease_types'] = lookupDetIdDiseaseTypes;
    map['org_id'] = orgId;
    map['status'] = status;
    map['is_inactive'] = isInactive;
    return map;
  }

}