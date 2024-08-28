class DocDeskData {
  DocDeskData({
      this.patientDoctorDeskId, 
      this.campCreateRequestId, 
      this.patientId, 
      this.patientName, 
      this.symptons,
      this.provisionalDiagnosis,
      this.contactNumber,
      this.lookupDetDescEn, 
      this.lookupDetDescRg, 
      this.lookupDetHierIdDistrict, 
      this.lookupDetHierIdTaluka, 
      this.lookupDetHierIdCity, 
      this.countryEn, 
      this.countryRg, 
      this.stateEn, 
      this.stateRg, 
      this.districtEn, 
      this.districtRg, 
      this.talukaEn, 
      this.talukaRg, 
      this.cityEn, 
      this.cityRg, 
      this.pinCode, 
      this.stakeholderNameEn, 
      this.stakeholderNameRg, 
      this.locationName, 
      this.status, 
      this.age, 
      this.propCampDate,});

  DocDeskData.fromJson(dynamic json) {
    patientDoctorDeskId = json['patient_doctor_desk_id'];
    campCreateRequestId = json['camp_create_request_id'];
    patientId = json['patient_id'];
    patientName = json['patient_name'];
    symptons = json['symptons'];
    provisionalDiagnosis = json['provisional_diagnosis'];
    contactNumber = json['contact_number'];
    lookupDetDescEn = json['lookup_det_desc_en'];
    lookupDetDescRg = json['lookup_det_desc_rg'];
    lookupDetHierIdDistrict = json['lookup_det_hier_id_district'];
    lookupDetHierIdTaluka = json['lookup_det_hier_id_taluka'];
    lookupDetHierIdCity = json['lookup_det_hier_id_city'];
    countryEn = json['country_en'];
    countryRg = json['country_rg'];
    stateEn = json['state_en'];
    stateRg = json['state_rg'];
    districtEn = json['district_en'];
    districtRg = json['district_rg'];
    talukaEn = json['taluka_en'];
    talukaRg = json['taluka_rg'];
    cityEn = json['city_en'];
    cityRg = json['city_rg'];
    pinCode = json['pin_code'];
    stakeholderNameEn = json['stakeholder_name_en'];
    stakeholderNameRg = json['stakeholder_name_rg'];
    locationName = json['location_name'];
    status = json['status'];
    age = json['age'];
    propCampDate = json['prop_camp_date'];
  }
  int? patientDoctorDeskId;
  int? campCreateRequestId;
  dynamic patientId;
  String? patientName;
  String? symptons;
  String? provisionalDiagnosis;
  String? contactNumber;
  String? lookupDetDescEn;
  String? lookupDetDescRg;
  int? lookupDetHierIdDistrict;
  int? lookupDetHierIdTaluka;
  int? lookupDetHierIdCity;
  dynamic countryEn;
  dynamic countryRg;
  String? stateEn;
  String? stateRg;
  String? districtEn;
  String? districtRg;
  String? talukaEn;
  String? talukaRg;
  String? cityEn;
  String? cityRg;
  String? pinCode;
  String? stakeholderNameEn;
  String? stakeholderNameRg;
  String? locationName;
  int? status;
  int? age;
  String? propCampDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patient_doctor_desk_id'] = patientDoctorDeskId;
    map['camp_create_request_id'] = campCreateRequestId;
    map['patient_id'] = patientId;
    map['patient_name'] = patientName;
    map['symptons'] = symptons;
    map['provisional_diagnosis'] = provisionalDiagnosis;
    map['contact_number'] = contactNumber;
    map['lookup_det_desc_en'] = lookupDetDescEn;
    map['lookup_det_desc_rg'] = lookupDetDescRg;
    map['lookup_det_hier_id_district'] = lookupDetHierIdDistrict;
    map['lookup_det_hier_id_taluka'] = lookupDetHierIdTaluka;
    map['lookup_det_hier_id_city'] = lookupDetHierIdCity;
    map['country_en'] = countryEn;
    map['country_rg'] = countryRg;
    map['state_en'] = stateEn;
    map['state_rg'] = stateRg;
    map['district_en'] = districtEn;
    map['district_rg'] = districtRg;
    map['taluka_en'] = talukaEn;
    map['taluka_rg'] = talukaRg;
    map['city_en'] = cityEn;
    map['city_rg'] = cityRg;
    map['pin_code'] = pinCode;
    map['stakeholder_name_en'] = stakeholderNameEn;
    map['stakeholder_name_rg'] = stakeholderNameRg;
    map['location_name'] = locationName;
    map['status'] = status;
    map['age'] = age;
    map['prop_camp_date'] = propCampDate;
    return map;
  }

}