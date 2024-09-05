import 'package:community_health_app/screens/patient_registration/models/tt_patient_disease_list.dart';
import 'package:community_health_app/screens/patient_registration/models/tt_patient_ref_list.dart';

import 'tt_patient_details_model.dart';

class Details {
  Details({
      this.ttPatientDetails, 
      this.ttPatientRefList, 
      this.ttPatientDiseaseList,});

  Details.fromJson(dynamic json) {
    ttPatientDetails = json['tt_patient_details'] != null ? TtPatientDetails.fromJson(json['tt_patient_details']) : null;
    if (json['tt_patient_ref_list'] != null) {
      ttPatientRefList = [];
      json['tt_patient_ref_list'].forEach((v) {
        ttPatientRefList?.add(TtPatientRefList.fromJson(v));
      });
    }
    if (json['tt_patient_disease_list'] != null) {
      ttPatientDiseaseList = [];
      json['tt_patient_disease_list'].forEach((v) {
        ttPatientDiseaseList?.add(TtPatientDiseaseList.fromJson(v));
      });
    }
  }
  TtPatientDetails? ttPatientDetails;
  List<TtPatientRefList>? ttPatientRefList;
  List<TtPatientDiseaseList>? ttPatientDiseaseList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (ttPatientDetails != null) {
      map['tt_patient_details'] = ttPatientDetails?.toJson();
    }
    if (ttPatientRefList != null) {
      map['tt_patient_ref_list'] = ttPatientRefList?.map((v) => v.toJson()).toList();
    }
    if (ttPatientDiseaseList != null) {
      map['tt_patient_disease_list'] = ttPatientDiseaseList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}