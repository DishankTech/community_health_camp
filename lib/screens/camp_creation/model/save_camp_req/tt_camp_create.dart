class TtCampCreate {
  TtCampCreate({
      this.campCreateRequestId, 
      this.stakeholderMasterId, 
      this.locationMasterId, 
      this.propCampDate, 
      this.campNumber,
      this.requestOrCreateFlag,
      this.orgId,
      this.status,});

  TtCampCreate.fromJson(dynamic json) {
    campCreateRequestId = json['camp_create_request_id'];
    stakeholderMasterId = json['stakeholder_master_id'];
    locationMasterId = json['location_master_id'];
    propCampDate = json['prop_camp_date'];
    campNumber = json['camp_number'];
    requestOrCreateFlag = json['request_or_create_flag'];
    orgId = json['org_id'];
    status = json['status'];
  }
  dynamic campCreateRequestId;
  int? stakeholderMasterId;
  int? locationMasterId;
  String? propCampDate;
  String? campNumber;
  String? requestOrCreateFlag;
  int? orgId;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['camp_create_request_id'] = campCreateRequestId;
    map['stakeholder_master_id'] = stakeholderMasterId;
    map['location_master_id'] = locationMasterId;
    map['prop_camp_date'] = propCampDate;
    map['camp_number'] = campNumber;
    map['request_or_create_flag'] = requestOrCreateFlag;
    map['org_id'] = orgId;
    map['status'] = status;
    return map;
  }

}