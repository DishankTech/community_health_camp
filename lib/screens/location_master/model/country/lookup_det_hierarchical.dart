class LookupDetHierarchical {
  LookupDetHierarchical({
      this.lookupDetHierId, 
      this.lookupDetHierValue, 
      this.lookupDetHierDescEn, 
      this.lookupDetHierDescRg, 
      this.lookupDetHierParentId, 
      this.status,});

  LookupDetHierarchical.fromJson(dynamic json) {
    lookupDetHierId = json['lookup_det_hier_id'];
    lookupDetHierValue = json['lookup_det_hier_value'];
    lookupDetHierDescEn = json['lookup_det_hier_desc_en'];
    lookupDetHierDescRg = json['lookup_det_hier_desc_rg'];
    lookupDetHierParentId = json['lookup_det_hier_parent_id'];
    status = json['status'];
  }
  int? lookupDetHierId;
  String? lookupDetHierValue;
  String? lookupDetHierDescEn;
  String? lookupDetHierDescRg;
  dynamic lookupDetHierParentId;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lookup_det_hier_id'] = lookupDetHierId;
    map['lookup_det_hier_value'] = lookupDetHierValue;
    map['lookup_det_hier_desc_en'] = lookupDetHierDescEn;
    map['lookup_det_hier_desc_rg'] = lookupDetHierDescRg;
    map['lookup_det_hier_parent_id'] = lookupDetHierParentId;
    map['status'] = status;
    return map;
  }

}