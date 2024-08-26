import 'tt_patient_doctor_desk.dart';
import 'tt_patient_doctor_deskRef.dart';

class AddTreatmentDetailsModel {
  AddTreatmentDetailsModel({
      this.ttPatientDoctorDesk, 
      this.ttPatientDoctorDeskRef,});

  AddTreatmentDetailsModel.fromJson(dynamic json) {
    ttPatientDoctorDesk = json['tt_patient_doctor_desk'] != null ? TtPatientDoctorDesk.fromJson(json['tt_patient_doctor_desk']) : null;
    if (json['tt_patient_doctor_desk_ref'] != null) {
      ttPatientDoctorDeskRef = [];
      json['tt_patient_doctor_desk_ref'].forEach((v) {
        ttPatientDoctorDeskRef?.add(TtPatientDoctorDeskRef.fromJson(v));
      });
    }
  }
  TtPatientDoctorDesk? ttPatientDoctorDesk;
  List<TtPatientDoctorDeskRef>? ttPatientDoctorDeskRef;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (ttPatientDoctorDesk != null) {
      map['tt_patient_doctor_desk'] = ttPatientDoctorDesk?.toJson();
    }
    if (ttPatientDoctorDeskRef != null) {
      map['tt_patient_doctor_desk_ref'] = ttPatientDoctorDeskRef?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}