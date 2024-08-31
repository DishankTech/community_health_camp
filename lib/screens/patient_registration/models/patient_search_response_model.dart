class PatientSearchResponseModel {
  int? statusCode;
  String? message;
  String? path;
  String? dateTime;
  List<PatientSearchData>? details;

  PatientSearchResponseModel(
      {this.statusCode, this.message, this.path, this.dateTime, this.details});

  PatientSearchResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    path = json['path'];
    dateTime = json['dateTime'];
    if (json['details'] != null) {
      details = <PatientSearchData>[];
      json['details'].forEach((v) {
        details!.add(new PatientSearchData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['message'] = message;
    data['path'] = path;
    data['dateTime'] = dateTime;
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PatientSearchData {
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
  String? address1;
  String? address2;
  int? lookupDetHierIdCountry;
  int? lookupDetHierIdState;
  int? lookupDetHierIdDistrict;
  int? lookupDetHierIdTaluka;
  int? lookupDetHierIdCity;
  int? lookupDetIdDivision;
  int? status;
  String? countryDescEn;
  String? countryDescRg;
  String? stateDescEn;
  String? stateDescRg;
  String? districtDescEn;
  String? districtDescRg;
  String? talukaDescEn;
  String? talukaDescRg;
  String? cityDescEn;
  String? cityDescRg;

  PatientSearchData(
      {this.patientId,
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
      this.cityDescRg});

  PatientSearchData.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['patient_id'] = patientId;
    data['camp_create_request_id'] = campCreateRequestId;
    data['camp_date'] = campDate;
    data['user_id_register_by'] = userIdRegisterBy;
    data['patient_name'] = patientName;
    data['age'] = age;
    data['contact_number'] = contactNumber;
    data['addhar_card'] = addharCard;
    data['abha_card'] = abhaCard;
    data['location_name'] = locationName;
    data['lookup_det_id_gender'] = lookupDetIdGender;
    data['gender_desc_en'] = genderDescEn;
    data['gender_desc_rg'] = genderDescRg;
    data['prop_camp_date'] = propCampDate;
    data['address1'] = address1;
    data['address2'] = address2;
    data['lookup_det_hier_id_country'] = lookupDetHierIdCountry;
    data['lookup_det_hier_id_state'] = lookupDetHierIdState;
    data['lookup_det_hier_id_district'] = lookupDetHierIdDistrict;
    data['lookup_det_hier_id_taluka'] = lookupDetHierIdTaluka;
    data['lookup_det_hier_id_city'] = lookupDetHierIdCity;
    data['lookup_det_id_division'] = lookupDetIdDivision;
    data['status'] = status;
    data['country_desc_en'] = countryDescEn;
    data['country_desc_rg'] = countryDescRg;
    data['state_desc_en'] = stateDescEn;
    data['state_desc_rg'] = stateDescRg;
    data['district_desc_en'] = districtDescEn;
    data['district_desc_rg'] = districtDescRg;
    data['taluka_desc_en'] = talukaDescEn;
    data['taluka_desc_rg'] = talukaDescRg;
    data['city_desc_en'] = cityDescEn;
    data['city_desc_rg'] = cityDescRg;
    return data;
  }
}
