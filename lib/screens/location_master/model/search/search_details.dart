class SearchDetails {
  SearchDetails({
      this.locationMasterId, 
      this.locationName, 
      this.contactNumber, 
      this.contactPersonName, 
      this.emailId, 
      this.address1, 
      this.address2, 
      this.lookupDetHierIdCountry, 
      this.lookupDetHierIdState, 
      this.lookupDetHierIdDistrict, 
      this.lookupDetHierIdTaluka, 
      this.lookupDetHierIdCity, 
      this.lookupDetIdDivision, 
      this.countryDescEn, 
      this.countryDescRg, 
      this.stateDescEn, 
      this.stateDescRg, 
      this.districtDescEn, 
      this.districtDescRg, 
      this.talukaDescEn, 
      this.talukaDescRg, 
      this.cityDescEn, 
      this.cityDescRg, 
      this.status,});

  SearchDetails.fromJson(dynamic json) {
    locationMasterId = json['location_master_id'];
    locationName = json['location_name'];
    contactNumber = json['contact_number'];
    contactPersonName = json['contact_person_name'];
    emailId = json['email_id'];
    address1 = json['address1'];
    address2 = json['address2'];
    lookupDetHierIdCountry = json['lookup_det_hier_id_country'];
    lookupDetHierIdState = json['lookup_det_hier_id_state'];
    lookupDetHierIdDistrict = json['lookup_det_hier_id_district'];
    lookupDetHierIdTaluka = json['lookup_det_hier_id_taluka'];
    lookupDetHierIdCity = json['lookup_det_hier_id_city'];
    lookupDetIdDivision = json['lookup_det_id_division'];
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
    status = json['status'];
  }
  int? locationMasterId;
  String? locationName;
  String? contactNumber;
  String? contactPersonName;
  String? emailId;
  String? address1;
  String? address2;
  int? lookupDetHierIdCountry;
  int? lookupDetHierIdState;
  int? lookupDetHierIdDistrict;
  int? lookupDetHierIdTaluka;
  int? lookupDetHierIdCity;
  dynamic lookupDetIdDivision;
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
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['location_master_id'] = locationMasterId;
    map['location_name'] = locationName;
    map['contact_number'] = contactNumber;
    map['contact_person_name'] = contactPersonName;
    map['email_id'] = emailId;
    map['address1'] = address1;
    map['address2'] = address2;
    map['lookup_det_hier_id_country'] = lookupDetHierIdCountry;
    map['lookup_det_hier_id_state'] = lookupDetHierIdState;
    map['lookup_det_hier_id_district'] = lookupDetHierIdDistrict;
    map['lookup_det_hier_id_taluka'] = lookupDetHierIdTaluka;
    map['lookup_det_hier_id_city'] = lookupDetHierIdCity;
    map['lookup_det_id_division'] = lookupDetIdDivision;
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
    map['status'] = status;
    return map;
  }

}