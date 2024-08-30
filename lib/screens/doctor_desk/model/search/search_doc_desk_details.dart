class SearchDocDeskDetails {
  SearchDocDeskDetails({
      this.patientId, 
      this.campCreateRequestId, 
      this.campDate, 
      this.userIdRegisterBy, 
      this.patientName, 
      this.age, 
      this.contactNumber, 
      this.addharCard, 
      this.abhaCard, 
      this.locationName, 
      this.lookupDetIdGender, 
      this.genderDescEn, 
      this.genderDescRg, 
      this.propCampDate, 
      this.address1, 
      this.address2, 
      this.lookupDetHierIdCountry, 
      this.lookupDetHierIdState, 
      this.lookupDetHierIdDistrict, 
      this.lookupDetHierIdTaluka, 
      this.lookupDetHierIdCity, 
      this.lookupDetIdDivision, 
      this.status, 
      this.countryDescEn, 
      this.countryDescRg, 
      this.stateDescEn, 
      this.stateDescRg, 
      this.districtDescEn, 
      this.districtDescRg, 
      this.talukaDescEn, 
      this.talukaDescRg, 
      this.cityDescEn, 
      this.cityDescRg,});

  SearchDocDeskDetails.fromJson(dynamic json) {
    patientId = json['patient_id'];
    campCreateRequestId = json['camp_create_request_id'];
    campDate = json['camp_date'];
    userIdRegisterBy = json['user_id_register_by'];
    patientName = json['patient_name'];
    age = json['age'];
    contactNumber = json['contact_number'];
    addharCard = json['addhar_card'];
    abhaCard = json['abha_card'];
    locationName = json['location_name'];
    lookupDetIdGender = json['lookup_det_id_gender'];
    genderDescEn = json['gender_desc_en'];
    genderDescRg = json['gender_desc_rg'];
    propCampDate = json['prop_camp_date'];
    address1 = json['address1'];
    address2 = json['address2'];
    lookupDetHierIdCountry = json['lookup_det_hier_id_country'];
    lookupDetHierIdState = json['lookup_det_hier_id_state'];
    lookupDetHierIdDistrict = json['lookup_det_hier_id_district'];
    lookupDetHierIdTaluka = json['lookup_det_hier_id_taluka'];
    lookupDetHierIdCity = json['lookup_det_hier_id_city'];
    lookupDetIdDivision = json['lookup_det_id_division'];
    status = json['status'];
    countryDescEn = json['country_desc_en'];
    countryDescRg = json['country_desc_rg'];
    stateDescEn = json['state_desc_en'];
    stateDescRg = json['state_desc_rg'];
    districtDescEn = json['district_desc_en'];
    districtDescRg = json['district_desc_rg'];
    talukaDescEn = json['taluka_desc_en'];
    talukaDescRg = json['taluka_desc_rg'];
    cityDescEn = json['city_desc_en'];
    cityDescRg = json['city_desc_rg'];
  }
  int? patientId;
  int? campCreateRequestId;
  String? campDate;
  int? userIdRegisterBy;
  String? patientName;
  int? age;
  String? contactNumber;
  String? addharCard;
  String? abhaCard;
  String? locationName;
  int? lookupDetIdGender;
  String? genderDescEn;
  String? genderDescRg;
  String? propCampDate;
  dynamic address1;
  dynamic address2;
  dynamic lookupDetHierIdCountry;
  int? lookupDetHierIdState;
  int? lookupDetHierIdDistrict;
  int? lookupDetHierIdTaluka;
  int? lookupDetHierIdCity;
  dynamic lookupDetIdDivision;
  int? status;
  dynamic countryDescEn;
  dynamic countryDescRg;
  String? stateDescEn;
  String? stateDescRg;
  String? districtDescEn;
  String? districtDescRg;
  String? talukaDescEn;
  String? talukaDescRg;
  String? cityDescEn;
  String? cityDescRg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patient_id'] = patientId;
    map['camp_create_request_id'] = campCreateRequestId;
    map['camp_date'] = campDate;
    map['user_id_register_by'] = userIdRegisterBy;
    map['patient_name'] = patientName;
    map['age'] = age;
    map['contact_number'] = contactNumber;
    map['addhar_card'] = addharCard;
    map['abha_card'] = abhaCard;
    map['location_name'] = locationName;
    map['lookup_det_id_gender'] = lookupDetIdGender;
    map['gender_desc_en'] = genderDescEn;
    map['gender_desc_rg'] = genderDescRg;
    map['prop_camp_date'] = propCampDate;
    map['address1'] = address1;
    map['address2'] = address2;
    map['lookup_det_hier_id_country'] = lookupDetHierIdCountry;
    map['lookup_det_hier_id_state'] = lookupDetHierIdState;
    map['lookup_det_hier_id_district'] = lookupDetHierIdDistrict;
    map['lookup_det_hier_id_taluka'] = lookupDetHierIdTaluka;
    map['lookup_det_hier_id_city'] = lookupDetHierIdCity;
    map['lookup_det_id_division'] = lookupDetIdDivision;
    map['status'] = status;
    map['country_desc_en'] = countryDescEn;
    map['country_desc_rg'] = countryDescRg;
    map['state_desc_en'] = stateDescEn;
    map['state_desc_rg'] = stateDescRg;
    map['district_desc_en'] = districtDescEn;
    map['district_desc_rg'] = districtDescRg;
    map['taluka_desc_en'] = talukaDescEn;
    map['taluka_desc_rg'] = talukaDescRg;
    map['city_desc_en'] = cityDescEn;
    map['city_desc_rg'] = cityDescRg;
    return map;
  }

}