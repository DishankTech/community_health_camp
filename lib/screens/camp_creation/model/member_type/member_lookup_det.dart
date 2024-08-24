class MemberLookupDet {
  MemberLookupDet({
      this.lookupDetId, 
      this.lookupDetValue, 
      this.lookupDetDescEn, 
      this.lookupDetDescRg, 
      this.lookupDetOthers, 
      this.status,});

  MemberLookupDet.fromJson(dynamic json) {
    lookupDetId = json['lookup_det_id'];
    lookupDetValue = json['lookup_det_value'];
    lookupDetDescEn = json['lookup_det_desc_en'];
    lookupDetDescRg = json['lookup_det_desc_rg'];
    lookupDetOthers = json['lookup_det_others'];
    status = json['status'];
  }
  int? lookupDetId;
  String? lookupDetValue;
  String? lookupDetDescEn;
  String? lookupDetDescRg;
  dynamic lookupDetOthers;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lookup_det_id'] = lookupDetId;
    map['lookup_det_value'] = lookupDetValue;
    map['lookup_det_desc_en'] = lookupDetDescEn;
    map['lookup_det_desc_rg'] = lookupDetDescRg;
    map['lookup_det_others'] = lookupDetOthers;
    map['status'] = status;
    return map;
  }

}