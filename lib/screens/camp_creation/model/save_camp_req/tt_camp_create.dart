class TtCampCreate {
  TtCampCreate({
      this.campCreateRequestId, 
      this.stakeholderMasterId, 
      this.locationMasterId, 
      this.propCampDate, 
      this.orgId, 
      this.status,});

  TtCampCreate.fromJson(dynamic json) {
    campCreateRequestId = json['camp_create_request_id'];
    stakeholderMasterId = json['stakeholder_master_id'];
    locationMasterId = json['location_master_id'];
    propCampDate = json['prop_camp_date'];
    orgId = json['org_id'];
    status = json['status'];
  }
  dynamic campCreateRequestId;
  int? stakeholderMasterId;
  int? locationMasterId;
  String? propCampDate;
  int? orgId;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['camp_create_request_id'] = campCreateRequestId;
    map['stakeholder_master_id'] = stakeholderMasterId;
    map['location_master_id'] = locationMasterId;
    map['prop_camp_date'] = propCampDate;
    map['org_id'] = orgId;
    map['status'] = status;
    return map;
  }

}