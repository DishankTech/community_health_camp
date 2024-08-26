class StakeHolderDetails {
  StakeHolderDetails({
      this.stakeholderMasterId, 
      this.stakeholderNameEn, 
      this.stakeholderNameRg, 
      this.lookupDetHierIdDistrict, 
      this.lookupDetHierDescEn, 
      this.lookupDetHierDescRg,});

  StakeHolderDetails.fromJson(dynamic json) {
    stakeholderMasterId = json['stakeholder_master_id'];
    stakeholderNameEn = json['stakeholder_name_en'];
    stakeholderNameRg = json['stakeholder_name_rg'];
    lookupDetHierIdDistrict = json['lookup_det_hier_id_district'];
    lookupDetHierDescEn = json['lookup_det_hier_desc_en'];
    lookupDetHierDescRg = json['lookup_det_hier_desc_rg'];
  }
  int? stakeholderMasterId;
  String? stakeholderNameEn;
  String? stakeholderNameRg;
  int? lookupDetHierIdDistrict;
  String? lookupDetHierDescEn;
  String? lookupDetHierDescRg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['stakeholder_master_id'] = stakeholderMasterId;
    map['stakeholder_name_en'] = stakeholderNameEn;
    map['stakeholder_name_rg'] = stakeholderNameRg;
    map['lookup_det_hier_id_district'] = lookupDetHierIdDistrict;
    map['lookup_det_hier_desc_en'] = lookupDetHierDescEn;
    map['lookup_det_hier_desc_rg'] = lookupDetHierDescRg;
    return map;
  }

}