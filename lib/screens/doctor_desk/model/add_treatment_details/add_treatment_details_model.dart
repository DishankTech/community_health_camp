import 'package:community_health_app/screens/doctor_desk/model/add_treatment_details/doctor_desk_disease_list.dart';
import 'package:community_health_app/screens/doctor_desk/model/add_treatment_details/doctor_desk_ref_service_list.dart';

import 'tt_patient_doctor_desk.dart';
import 'tt_patient_doctor_desk_ref.dart';

class AddTreatmentDetailsModel {
  AddTreatmentDetailsModel({
      this.ttPatientDoctorDesk, 
      this.ttPatientDoctorDeskRef, 
      this.doctorDeskRefServiceList, 
      this.doctorDeskDiseaseList,});

  AddTreatmentDetailsModel.fromJson(dynamic json) {
    ttPatientDoctorDesk = json['tt_patient_doctor_desk'] != null ? TtPatientDoctorDesk.fromJson(json['tt_patient_doctor_desk']) : null;
    if (json['tt_patient_doctor_desk_ref'] != null) {
      ttPatientDoctorDeskRef = [];
      json['tt_patient_doctor_desk_ref'].forEach((v) {
        ttPatientDoctorDeskRef?.add(TtPatientDoctorDeskRef.fromJson(v));
      });
    }
    if (json['doctor_desk_ref_service_list'] != null) {
      doctorDeskRefServiceList = [];
      json['doctor_desk_ref_service_list'].forEach((v) {
        doctorDeskRefServiceList?.add(DoctorDeskRefServiceList.fromJson(v));
      });
    }
    if (json['doctor_desk_disease_list'] != null) {
      doctorDeskDiseaseList = [];
      json['doctor_desk_disease_list'].forEach((v) {
        doctorDeskDiseaseList?.add(DoctorDeskDiseaseList.fromJson(v));
      });
    }
  }
  TtPatientDoctorDesk? ttPatientDoctorDesk;
  List<TtPatientDoctorDeskRef>? ttPatientDoctorDeskRef;
  List<DoctorDeskRefServiceList>? doctorDeskRefServiceList;
  List<DoctorDeskDiseaseList>? doctorDeskDiseaseList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (ttPatientDoctorDesk != null) {
      map['tt_patient_doctor_desk'] = ttPatientDoctorDesk?.toJson();
    }
    if (ttPatientDoctorDeskRef != null) {
      map['tt_patient_doctor_desk_ref'] = ttPatientDoctorDeskRef?.map((v) => v.toJson()).toList();
    }
    if (doctorDeskRefServiceList != null) {
      map['doctor_desk_ref_service_list'] = doctorDeskRefServiceList?.map((v) => v.toJson()).toList();
    }
    if (doctorDeskDiseaseList != null) {
      map['doctor_desk_disease_list'] = doctorDeskDiseaseList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}