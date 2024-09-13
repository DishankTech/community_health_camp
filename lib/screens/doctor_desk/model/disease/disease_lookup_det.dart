class DiseaseLookupDet {
  DiseaseLookupDet({
    this.lookupDetId,
    this.patientId,
    this.patientDiseasetypesId,
    this.lookupDetValue,
    this.lookupDetDescEn,
    this.lookupDetDescRg,
    this.lookupDetOthers,
    this.status,
    required this.existing
  });

  DiseaseLookupDet.fromJson(dynamic json) {
    lookupDetId = json['lookup_det_id'];
    patientId = json['patient_id'];
    patientDiseasetypesId = json['patient_disease_types_id'];
    lookupDetValue = json['lookup_det_value'];
    lookupDetDescEn = json['lookup_det_desc_en'];
    lookupDetDescRg = json['lookup_det_desc_rg'];
    lookupDetOthers = json['lookup_det_others'];
    status = json['status'];
  }

  int? lookupDetId;
  int? patientId;
  int? patientDiseasetypesId;
  String? lookupDetValue;
  String? lookupDetDescEn;
  String? lookupDetDescRg;
  dynamic lookupDetOthers;
  int? status;
  bool existing = false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lookup_det_id'] = lookupDetId;
    map['patient_id'] = patientId;
    map['patient_disease_types_id'] = patientDiseasetypesId;
    map['lookup_det_value'] = lookupDetValue;
    map['lookup_det_desc_en'] = lookupDetDescEn;
    map['lookup_det_desc_rg'] = lookupDetDescRg;
    map['lookup_det_others'] = lookupDetOthers;
    map['status'] = status;
    return map;
  }
}
