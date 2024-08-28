// To parse this JSON data, do
//
//     final campsReferredPatientsRespModel = campsReferredPatientsRespModelFromJson(jsonString);

import 'dart:convert';

CampsReferredPatientsRespModel campsReferredPatientsRespModelFromJson(String str) => CampsReferredPatientsRespModel.fromJson(json.decode(str));

String campsReferredPatientsRespModelToJson(CampsReferredPatientsRespModel data) => json.encode(data.toJson());

class CampsReferredPatientsRespModel {
  int statusCode;
  String message;
  String path;
  DateTime dateTime;
  List<ReferredPatientList> details;

  CampsReferredPatientsRespModel({
    required this.statusCode,
    required this.message,
    required this.path,
    required this.dateTime,
    required this.details,
  });

  factory CampsReferredPatientsRespModel.fromJson(Map<String, dynamic> json) => CampsReferredPatientsRespModel(
    statusCode: json["status_code"],
    message: json["message"],
    path: json["path"],
    dateTime: DateTime.parse(json["dateTime"]),
    details: List<ReferredPatientList>.from(json["details"].map((x) => ReferredPatientList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "path": path,
    "dateTime": dateTime.toIso8601String(),
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
  };
}

class ReferredPatientList {
  String patientName;
  String contactNumber;
  dynamic age;
  dynamic genderEn;
  dynamic genderRg;
  dynamic stakeholderSubTypeEn;
  dynamic stakeholderSubTypeRg;
  String stakeholderNamesEn;
  String stakeholderNamesRg;

  ReferredPatientList({
    required this.patientName,
    required this.contactNumber,
    required this.age,
    required this.genderEn,
    required this.genderRg,
    required this.stakeholderSubTypeEn,
    required this.stakeholderSubTypeRg,
    required this.stakeholderNamesEn,
    required this.stakeholderNamesRg,
  });

  factory ReferredPatientList.fromJson(Map<String, dynamic> json) => ReferredPatientList(
    patientName: json["patient_name"],
    contactNumber: json["contact_number"],
    age: json["age"],
    genderEn: json["gender_en"],
    genderRg: json["gender_rg"],
    stakeholderSubTypeEn: json["stakeholder_sub_type_en"],
    stakeholderSubTypeRg: json["stakeholder_sub_type_rg"],
    stakeholderNamesEn: json["stakeholder_names_en"],
    stakeholderNamesRg: json["stakeholder_names_rg"],
  );

  Map<String, dynamic> toJson() => {
    "patient_name": patientName,
    "contact_number": contactNumber,
    "age": age,
    "gender_en": genderEn,
    "gender_rg": genderRg,
    "stakeholder_sub_type_en": stakeholderSubTypeEn,
    "stakeholder_sub_type_rg": stakeholderSubTypeRg,
    "stakeholder_names_en": stakeholderNamesEn,
    "stakeholder_names_rg": stakeholderNamesRg,
  };
}
