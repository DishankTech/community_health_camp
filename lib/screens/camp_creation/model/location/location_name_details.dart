class LocationNameDetails {
  LocationNameDetails({
      this.locationMasterId, 
      this.locationName, 
      this.lookupDetHierIdDistrict, 
      this.lookupDetHierDescEn, 
      this.lookupDetHierDescRg,});

  LocationNameDetails.fromJson(dynamic json) {
    locationMasterId = json['location_master_id'];
    locationName = json['location_name'];
    lookupDetHierIdDistrict = json['lookup_det_hier_id_district'];
    lookupDetHierDescEn = json['lookup_det_hier_desc_en'];
    lookupDetHierDescRg = json['lookup_det_hier_desc_rg'];
  }
  int? locationMasterId;
  String? locationName;
  int? lookupDetHierIdDistrict;
  String? lookupDetHierDescEn;
  String? lookupDetHierDescRg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['location_master_id'] = locationMasterId;
    map['location_name'] = locationName;
    map['lookup_det_hier_id_district'] = lookupDetHierIdDistrict;
    map['lookup_det_hier_desc_en'] = lookupDetHierDescEn;
    map['lookup_det_hier_desc_rg'] = lookupDetHierDescRg;
    return map;
  }

}