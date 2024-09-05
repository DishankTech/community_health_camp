class DiseasesTypeModel {
  DiseasesTypeModel({
      this.patientDiseaseTypesId, 
      this.patientId, 
      this.lookupDetIdDiseaseTypes, 
      this.orgId, 
      this.status, 
      this.isInactive,});

  DiseasesTypeModel.fromJson(dynamic json) {
    patientDiseaseTypesId = json['patient_disease_types_id'];
    patientId = json['patient_id'];
    lookupDetIdDiseaseTypes = json['lookup_det_id_disease_types'];
    orgId = json['org_id'];
    status = json['status'];
    isInactive = json['is_inactive'];
  }
  dynamic patientDiseaseTypesId;
  dynamic patientId;
  int? lookupDetIdDiseaseTypes;
  int? orgId;
  int? status;
  dynamic isInactive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patient_disease_types_id'] = patientDiseaseTypesId;
    map['patient_id'] = patientId;
    map['lookup_det_id_disease_types'] = lookupDetIdDiseaseTypes;
    map['org_id'] = orgId;
    map['status'] = status;
    map['is_inactive'] = isInactive;
    return map;
  }

}