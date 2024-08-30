class DoctorDeskData {
  DoctorDeskData({
    this.patientId,
    this.campCreateRequestId,
    this.campDate,
    this.locationName,
    this.state,
    this.destrict,
    this.taluka,
    this.city,
    this.userIdRegisterBy,
    this.patientName,
    this.age,
    this.gender,
    this.lookupDetIdGender,
    this.contactNumber,
    this.addharCard,
    this.abhaCard,
    this.lookupDetHierIdCountry,
    this.lookupDetHierIdState,
    this.lookupDetHierIdDistrict,
    this.lookupDetHierIdTaluka,
    this.lookupDetHierIdCity,
    this.lookupDetIdDivision,
    this.pinCode,
    this.orgId,
    this.status,});

  DoctorDeskData.fromJson(dynamic json) {
    patientId = json['patient_id'];
    campCreateRequestId = json['camp_create_request_id'];
    campDate = json['camp_date'];
    locationName = json['location_name'];
    state = json['state_desc_en'];
    destrict = json['district_desc_en'];
    taluka = json['taluka_desc_en'];
    city = json['city_desc_en'];
    userIdRegisterBy = json['user_id_register_by'];
    patientName = json['patient_name'];
    age = json['age'];
    gender = json['gender_desc_en'];
    lookupDetIdGender = json['lookup_det_id_gender'];
    contactNumber = json['contact_number'];
    addharCard = json['addhar_card'];
    abhaCard = json['abha_card'];
    lookupDetHierIdCountry = json['lookup_det_hier_id_country'];
    lookupDetHierIdState = json['lookup_det_hier_id_state'];
    lookupDetHierIdDistrict = json['lookup_det_hier_id_district'];
    lookupDetHierIdTaluka = json['lookup_det_hier_id_taluka'];
    lookupDetHierIdCity = json['lookup_det_hier_id_city'];
    lookupDetIdDivision = json['lookup_det_id_division'];
    pinCode = json['pin_code'];
    orgId = json['org_id'];
    status = json['status'];
  }
  int? patientId;
  int? campCreateRequestId;
  String? campDate;
  String? locationName;
  String? state;
  String? destrict;
  String? taluka;
  String? city;
  int? userIdRegisterBy;
  String? patientName;
  int? age;
  String? gender;
  int? lookupDetIdGender;
  String? contactNumber;
  String? addharCard;
  String? abhaCard;
  dynamic lookupDetHierIdCountry;
  int? lookupDetHierIdState;
  int? lookupDetHierIdDistrict;
  int? lookupDetHierIdTaluka;
  int? lookupDetHierIdCity;
  dynamic lookupDetIdDivision;
  String? pinCode;
  dynamic orgId;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patient_id'] = patientId;
    map['camp_create_request_id'] = campCreateRequestId;
    map['camp_date'] = campDate;
    map['location_name'] = locationName;
    map['state_desc_en'] = state;
    map['district_desc_en'] = destrict;
    map['taluka_desc_en'] = taluka;
    map['city_desc_en'] = city;
    map['user_id_register_by'] = userIdRegisterBy;
    map['patient_name'] = patientName;
    map['age'] = age;
    map['gender_desc_en'] = gender;
    map['lookup_det_id_gender'] = lookupDetIdGender;
    map['contact_number'] = contactNumber;
    map['addhar_card'] = addharCard;
    map['abha_card'] = abhaCard;
    map['lookup_det_hier_id_country'] = lookupDetHierIdCountry;
    map['lookup_det_hier_id_state'] = lookupDetHierIdState;
    map['lookup_det_hier_id_district'] = lookupDetHierIdDistrict;
    map['lookup_det_hier_id_taluka'] = lookupDetHierIdTaluka;
    map['lookup_det_hier_id_city'] = lookupDetHierIdCity;
    map['lookup_det_id_division'] = lookupDetIdDivision;
    map['pin_code'] = pinCode;
    map['org_id'] = orgId;
    map['status'] = status;
    return map;
  }

}