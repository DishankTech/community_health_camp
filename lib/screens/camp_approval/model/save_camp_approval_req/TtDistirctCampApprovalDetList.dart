class TtDistirctCampApprovalDetList {
  TtDistirctCampApprovalDetList({
      this.distirctCampApprovalDetId, 
      this.distirctCampApprovalId, 
      this.stakeholderMasterIdRef, 
      this.acceptedYN, 
      this.suggestedDate, 
      this.orgId, 
      this.status, 
      this.isInactive,});

  TtDistirctCampApprovalDetList.fromJson(dynamic json) {
    distirctCampApprovalDetId = json['distirct_camp_approval_det_id'];
    distirctCampApprovalId = json['distirct_camp_approval_id'];
    stakeholderMasterIdRef = json['stakeholder_master_id_ref'];
    acceptedYN = json['accepted_y_n'];
    suggestedDate = json['suggested_date'];
    orgId = json['org_id'];
    status = json['status'];
    isInactive = json['is_inactive'];
  }
  int? distirctCampApprovalDetId;
  int? distirctCampApprovalId;
  int? stakeholderMasterIdRef;
  String? acceptedYN;
  String? suggestedDate;
  int? orgId;
  int? status;
  dynamic isInactive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['distirct_camp_approval_det_id'] = distirctCampApprovalDetId;
    map['distirct_camp_approval_id'] = distirctCampApprovalId;
    map['stakeholder_master_id_ref'] = stakeholderMasterIdRef;
    map['accepted_y_n'] = acceptedYN;
    map['suggested_date'] = suggestedDate;
    map['org_id'] = orgId;
    map['status'] = status;
    map['is_inactive'] = isInactive;
    return map;
  }

}