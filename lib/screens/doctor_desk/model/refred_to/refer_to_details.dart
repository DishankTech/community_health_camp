class ReferToDetails {
  ReferToDetails({
      this.stakeholderMasterId, 
      this.stakeholderNameEn, 
      this.stakeholderNameRg, 
      this.lookupDetHierIdDistrict, 
      this.lookupDetHierDescEn, 
      this.lookupDetHierDescRg, 
      this.talukaEn, 
      this.talukaRg,});

  ReferToDetails.fromJson(dynamic json) {
    stakeholderMasterId = json['stakeholder_master_id'];
    stakeholderNameEn = json['stakeholder_name_en'];
    stakeholderNameRg = json['stakeholder_name_rg'];
    lookupDetHierIdDistrict = json['lookup_det_hier_id_district'];
    lookupDetHierDescEn = json['lookup_det_hier_desc_en'];
    lookupDetHierDescRg = json['lookup_det_hier_desc_rg'];
    talukaEn = json['taluka_en'];
    talukaRg = json['taluka_rg'];
  }
  int? stakeholderMasterId;
  String? stakeholderNameEn;
  String? stakeholderNameRg;
  int? lookupDetHierIdDistrict;
  String? lookupDetHierDescEn;
  String? lookupDetHierDescRg;
  dynamic talukaEn;
  dynamic talukaRg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['stakeholder_master_id'] = stakeholderMasterId;
    map['stakeholder_name_en'] = stakeholderNameEn;
    map['stakeholder_name_rg'] = stakeholderNameRg;
    map['lookup_det_hier_id_district'] = lookupDetHierIdDistrict;
    map['lookup_det_hier_desc_en'] = lookupDetHierDescEn;
    map['lookup_det_hier_desc_rg'] = lookupDetHierDescRg;
    map['taluka_en'] = talukaEn;
    map['taluka_rg'] = talukaRg;
    return map;
  }

}