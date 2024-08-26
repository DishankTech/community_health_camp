class LocationListData {
  LocationListData({
      this.locationMasterId, 
      this.locationName, 
      this.contactNumber, 
      this.contactPersonName, 
      this.districtDesEn,
      this.cityDescEn,
      this.emailId,
      this.address1, 
      this.address2, 
      this.lookupDetHierIdCountry, 
      this.lookupDetHierIdState, 
      this.lookupDetHierIdDistrict, 
      this.lookupDetHierIdTaluka, 
      this.lookupDetHierIdCity, 
      this.lookupDetIdDivision, 
      this.orgId, 
      this.status,});

  LocationListData.fromJson(dynamic json) {
    locationMasterId = json['location_master_id'];
    locationName = json['location_name'];
    contactNumber = json['contact_number'];
    contactPersonName = json['contact_person_name'];
    districtDesEn = json['district_desc_en'];
    cityDescEn = json['city_desc_en'];
    emailId = json['email_id'];
    address1 = json['address1'];
    address2 = json['address2'];
    lookupDetHierIdCountry = json['lookup_det_hier_id_country'];
    lookupDetHierIdState = json['lookup_det_hier_id_state'];
    lookupDetHierIdDistrict = json['lookup_det_hier_id_district'];
    lookupDetHierIdTaluka = json['lookup_det_hier_id_taluka'];
    lookupDetHierIdCity = json['lookup_det_hier_id_city'];
    lookupDetIdDivision = json['lookup_det_id_division'];
    orgId = json['org_id'];
    status = json['status'];
  }
  int? locationMasterId;
  String? locationName;
  String? contactNumber;
  String? contactPersonName;
  String? districtDesEn;
  String? cityDescEn;
  String? emailId;
  String? address1;
  String? address2;
  int? lookupDetHierIdCountry;
  int? lookupDetHierIdState;
  int? lookupDetHierIdDistrict;
  dynamic lookupDetHierIdTaluka;
  dynamic lookupDetHierIdCity;
  int? lookupDetIdDivision;
  dynamic orgId;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['location_master_id'] = locationMasterId;
    map['location_name'] = locationName;
    map['contact_number'] = contactNumber;
    map['contact_person_name'] = contactPersonName;
    map['district_desc_en'] = districtDesEn;
    map['city_desc_en'] = cityDescEn;
    map['email_id'] = emailId;
    map['address1'] = address1;
    map['address2'] = address2;
    map['lookup_det_hier_id_country'] = lookupDetHierIdCountry;
    map['lookup_det_hier_id_state'] = lookupDetHierIdState;
    map['lookup_det_hier_id_district'] = lookupDetHierIdDistrict;
    map['lookup_det_hier_id_taluka'] = lookupDetHierIdTaluka;
    map['lookup_det_hier_id_city'] = lookupDetHierIdCity;
    map['lookup_det_id_division'] = lookupDetIdDivision;
    map['org_id'] = orgId;
    map['status'] = status;
    return map;
  }

}