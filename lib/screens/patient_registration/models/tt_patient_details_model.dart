class TtPatientDetails {
  TtPatientDetails({
      this.patientId, 
      this.campCreateRequestId, 
      this.campDate, 
      this.userIdRegisterBy, 
      this.patientName, 
      this.age, 
      this.lookupDetIdRefDepartment, 
      this.lookupDetIdGender, 
      this.contactNumber, 
      this.addharCard, 
      this.abhaCard, 
      this.address1, 
      this.address2, 
      this.lookupDetHierIdCountry, 
      this.lookupDetHierIdState, 
      this.lookupDetHierIdDistrict, 
      this.lookupDetHierIdTaluka, 
      this.lookupDetHierIdCity, 
      this.lookupDetIdDivision, 
      this.pinCode, 
      this.investigation, 
      this.provisionalDiagnosis, 
      this.orgId, 
      this.status,});

  TtPatientDetails.fromJson(dynamic json) {
    patientId = json['patient_id'];
    campCreateRequestId = json['camp_create_request_id'];
    campDate = json['camp_date'];
    userIdRegisterBy = json['user_id_register_by'];
    patientName = json['patient_name'];
    age = json['age'];
    lookupDetIdRefDepartment = json['lookup_det_id_ref_department'];
    lookupDetIdGender = json['lookup_det_id_gender'];
    contactNumber = json['contact_number'];
    addharCard = json['addhar_card'];
    abhaCard = json['abha_card'];
    address1 = json['address1'];
    address2 = json['address2'];
    lookupDetHierIdCountry = json['lookup_det_hier_id_country'];
    lookupDetHierIdState = json['lookup_det_hier_id_state'];
    lookupDetHierIdDistrict = json['lookup_det_hier_id_district'];
    lookupDetHierIdTaluka = json['lookup_det_hier_id_taluka'];
    lookupDetHierIdCity = json['lookup_det_hier_id_city'];
    lookupDetIdDivision = json['lookup_det_id_division'];
    pinCode = json['pin_code'];
    investigation = json['investigation'];
    provisionalDiagnosis = json['provisional_diagnosis'];
    orgId = json['org_id'];
    status = json['status'];
  }
  int? patientId;
  int? campCreateRequestId;
  String? campDate;
  int? userIdRegisterBy;
  String? patientName;
  int? age;
  dynamic lookupDetIdRefDepartment;
  int? lookupDetIdGender;
  String? contactNumber;
  String? addharCard;
  String? abhaCard;
  String? address1;
  String? address2;
  int? lookupDetHierIdCountry;
  int? lookupDetHierIdState;
  int? lookupDetHierIdDistrict;
  int? lookupDetHierIdTaluka;
  int? lookupDetHierIdCity;
  dynamic lookupDetIdDivision;
  String? pinCode;
  dynamic investigation;
  dynamic provisionalDiagnosis;
  int? orgId;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patient_id'] = patientId;
    map['camp_create_request_id'] = campCreateRequestId;
    map['camp_date'] = campDate;
    map['user_id_register_by'] = userIdRegisterBy;
    map['patient_name'] = patientName;
    map['age'] = age;
    map['lookup_det_id_ref_department'] = lookupDetIdRefDepartment;
    map['lookup_det_id_gender'] = lookupDetIdGender;
    map['contact_number'] = contactNumber;
    map['addhar_card'] = addharCard;
    map['abha_card'] = abhaCard;
    map['address1'] = address1;
    map['address2'] = address2;
    map['lookup_det_hier_id_country'] = lookupDetHierIdCountry;
    map['lookup_det_hier_id_state'] = lookupDetHierIdState;
    map['lookup_det_hier_id_district'] = lookupDetHierIdDistrict;
    map['lookup_det_hier_id_taluka'] = lookupDetHierIdTaluka;
    map['lookup_det_hier_id_city'] = lookupDetHierIdCity;
    map['lookup_det_id_division'] = lookupDetIdDivision;
    map['pin_code'] = pinCode;
    map['investigation'] = investigation;
    map['provisional_diagnosis'] = provisionalDiagnosis;
    map['org_id'] = orgId;
    map['status'] = status;
    return map;
  }

}