class TtDistirctCampApproval {
  TtDistirctCampApproval({
      this.distirctCampApprovalId, 
      this.campCreateRequestId, 
      this.confirmCampDate, 
      this.orgId, 
      this.status,});

  TtDistirctCampApproval.fromJson(dynamic json) {
    distirctCampApprovalId = json['distirct_camp_approval_id'];
    campCreateRequestId = json['camp_create_request_id'];
    confirmCampDate = json['confirm_camp_date'];
    orgId = json['org_id'];
    status = json['status'];
  }
  int? distirctCampApprovalId;
  int? campCreateRequestId;
  String? confirmCampDate;
  int? orgId;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['distirct_camp_approval_id'] = distirctCampApprovalId;
    map['camp_create_request_id'] = campCreateRequestId;
    map['confirm_camp_date'] = confirmCampDate;
    map['org_id'] = orgId;
    map['status'] = status;
    return map;
  }

}