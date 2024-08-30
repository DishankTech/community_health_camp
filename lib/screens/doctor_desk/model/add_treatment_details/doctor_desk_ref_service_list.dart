class DoctorDeskRefServiceList {
  DoctorDeskRefServiceList({
      this.patientDoctorDeskReferralServicesId, 
      this.patientDoctorDeskId, 
      this.lookupDetIdReferralServices, 
      this.orgId, 
      this.status, 
      this.isInactive,});

  DoctorDeskRefServiceList.fromJson(dynamic json) {
    patientDoctorDeskReferralServicesId = json['patient_doctor_desk_referral_services_id'];
    patientDoctorDeskId = json['patient_doctor_desk_id'];
    lookupDetIdReferralServices = json['lookup_det_id_referral_services'];
    orgId = json['org_id'];
    status = json['status'];
    isInactive = json['is_inactive'] != null ? json['is_inactive'].cast<String>() : [];
  }
  int? patientDoctorDeskReferralServicesId;
  int? patientDoctorDeskId;
  int? lookupDetIdReferralServices;
  int? orgId;
  int? status;
  List<String>? isInactive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patient_doctor_desk_referral_services_id'] = patientDoctorDeskReferralServicesId;
    map['patient_doctor_desk_id'] = patientDoctorDeskId;
    map['lookup_det_id_referral_services'] = lookupDetIdReferralServices;
    map['org_id'] = orgId;
    map['status'] = status;
    map['is_inactive'] = isInactive;
    return map;
  }

}