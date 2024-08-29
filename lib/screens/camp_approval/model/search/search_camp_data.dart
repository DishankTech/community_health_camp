class SearchCampData {
  SearchCampData({
      this.campCreateRequestId, 
      this.propCampDate, 
      this.stakeholderMasterId, 
      this.locationMasterId, 
      this.status, 
      this.locationName, 
      this.stakeholderNameEn, 
      this.stakeholderNameRg, 
      this.districtEn, 
      this.districtRg, 
      this.campNumber,});

  SearchCampData.fromJson(dynamic json) {
    campCreateRequestId = json['camp_create_request_id'];
    propCampDate = json['prop_camp_date'];
    stakeholderMasterId = json['stakeholder_master_id'];
    locationMasterId = json['location_master_id'];
    status = json['status'];
    locationName = json['location_name'];
    stakeholderNameEn = json['stakeholder_name_en'];
    stakeholderNameRg = json['stakeholder_name_rg'];
    districtEn = json['district_en'];
    districtRg = json['district_rg'];
    campNumber = json['camp_number'];
  }
  int? campCreateRequestId;
  String? propCampDate;
  int? stakeholderMasterId;
  int? locationMasterId;
  int? status;
  String? locationName;
  String? stakeholderNameEn;
  String? stakeholderNameRg;
  String? districtEn;
  String? districtRg;
  dynamic campNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['camp_create_request_id'] = campCreateRequestId;
    map['prop_camp_date'] = propCampDate;
    map['stakeholder_master_id'] = stakeholderMasterId;
    map['location_master_id'] = locationMasterId;
    map['status'] = status;
    map['location_name'] = locationName;
    map['stakeholder_name_en'] = stakeholderNameEn;
    map['stakeholder_name_rg'] = stakeholderNameRg;
    map['district_en'] = districtEn;
    map['district_rg'] = districtRg;
    map['camp_number'] = campNumber;
    return map;
  }

}