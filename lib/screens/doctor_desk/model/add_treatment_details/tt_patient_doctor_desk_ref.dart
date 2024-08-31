class TtPatientDoctorDeskRef {
  TtPatientDoctorDeskRef({
      this.patientDoctorDeskReferId, 
      this.patientDoctorDeskId, 
      this.stakeholderMasterId, 
      this.lookupDetHierIdStakeholderSubType2, 
      this.orgId, 
      this.status, 
      this.isInactive,});

  TtPatientDoctorDeskRef.fromJson(dynamic json) {
    patientDoctorDeskReferId = json['patient_doctor_desk_refer_id'];
    patientDoctorDeskId = json['patient_doctor_desk_id'];
    stakeholderMasterId = json['stakeholder_master_id'];
    lookupDetHierIdStakeholderSubType2 = json['lookup_det_hier_id_stakeholder_sub_type2'];
    orgId = json['org_id'];
    status = json['status'];
    isInactive = json['is_inactive'] != null ? json['is_inactive'].cast<String>() : [];
  }
  int? patientDoctorDeskReferId;
  int? patientDoctorDeskId;
  int? stakeholderMasterId;
  int? lookupDetHierIdStakeholderSubType2;
  int? orgId;
  int? status;
  List<String>? isInactive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patient_doctor_desk_refer_id'] = patientDoctorDeskReferId;
    map['patient_doctor_desk_id'] = patientDoctorDeskId;
    map['stakeholder_master_id'] = stakeholderMasterId;
    map['lookup_det_hier_id_stakeholder_sub_type2'] = lookupDetHierIdStakeholderSubType2;
    map['org_id'] = orgId;
    map['status'] = status;
    map['is_inactive'] = isInactive;
    return map;
  }

}