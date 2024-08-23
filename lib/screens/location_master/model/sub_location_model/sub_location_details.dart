class SubLocationDetails {
  SubLocationDetails({
      this.lookupDetHierId, 
      this.lookupDetId, 
      this.orgId, 
      this.lookupDetHierValue, 
      this.lookupDetHierDescEn, 
      this.lookupDetHierDescRg, 
      this.lookupDetHierParentId, 
      this.status, 
      this.lookupDetHierOrderBy,});

  SubLocationDetails.fromJson(dynamic json) {
    lookupDetHierId = json['lookup_det_hier_id'];
    lookupDetId = json['lookup_det_id'];
    orgId = json['org_id'];
    lookupDetHierValue = json['lookup_det_hier_value'];
    lookupDetHierDescEn = json['lookup_det_hier_desc_en'];
    lookupDetHierDescRg = json['lookup_det_hier_desc_rg'];
    lookupDetHierParentId = json['lookup_det_hier_parent_id'];
    status = json['status'];
    lookupDetHierOrderBy = json['lookup_det_hier_order_by'];
  }
  int? lookupDetHierId;
  int? lookupDetId;
  int? orgId;
  String? lookupDetHierValue;
  String? lookupDetHierDescEn;
  String? lookupDetHierDescRg;
  int? lookupDetHierParentId;
  int? status;
  int? lookupDetHierOrderBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lookup_det_hier_id'] = lookupDetHierId;
    map['lookup_det_id'] = lookupDetId;
    map['org_id'] = orgId;
    map['lookup_det_hier_value'] = lookupDetHierValue;
    map['lookup_det_hier_desc_en'] = lookupDetHierDescEn;
    map['lookup_det_hier_desc_rg'] = lookupDetHierDescRg;
    map['lookup_det_hier_parent_id'] = lookupDetHierParentId;
    map['status'] = status;
    map['lookup_det_hier_order_by'] = lookupDetHierOrderBy;
    return map;
  }

}