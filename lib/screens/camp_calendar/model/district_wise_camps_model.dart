/*
class DistrictWiseCampsModel {

  String campId;
  String campName;
  String campLocation;
  String noOfPatientRegisteredforCamp;

  DistrictWiseCampsModel(
      { required this.campId, required this.campName, required this.campLocation, required this.noOfPatientRegisteredforCamp});
}
*/

// To parse this JSON data, do
//
//     final districtWiseCampsModel = districtWiseCampsModelFromJson(jsonString);

import 'dart:convert';

DistrictWiseCampsModel districtWiseCampsModelFromJson(String str) => DistrictWiseCampsModel.fromJson(json.decode(str));

String districtWiseCampsModelToJson(DistrictWiseCampsModel data) => json.encode(data.toJson());

class DistrictWiseCampsModel {
  int statusCode;
  String message;
  String path;
  DateTime dateTime;
  List<DistrictCampDetails> details;

  DistrictWiseCampsModel({
    required this.statusCode,
    required this.message,
    required this.path,
    required this.dateTime,
    required this.details,
  });

  factory DistrictWiseCampsModel.fromJson(Map<String, dynamic> json) => DistrictWiseCampsModel(
    statusCode: json["status_code"],
    message: json["message"],
    path: json["path"],
    dateTime: DateTime.parse(json["dateTime"]),
    details: List<DistrictCampDetails>.from(json["details"].map((x) => DistrictCampDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "path": path,
    "dateTime": dateTime.toIso8601String(),
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
  };
}

class DistrictCampDetails {
  int campCreateRequestId;
  String stakeholderNameEn;
  String stakeholderNameRg;
  String locationName;

  DistrictCampDetails({
    required this.campCreateRequestId,
    required this.stakeholderNameEn,
    required this.stakeholderNameRg,
    required this.locationName,
  });

  factory DistrictCampDetails.fromJson(Map<String, dynamic> json) => DistrictCampDetails(
    campCreateRequestId: json["camp_create_request_id"],
    stakeholderNameEn: json["stakeholder_name_en"],
    stakeholderNameRg: json["stakeholder_name_rg"],
    locationName: json["location_name"],
  );

  Map<String, dynamic> toJson() => {
    "camp_create_request_id": campCreateRequestId,
    "stakeholder_name_en": stakeholderNameEn,
    "stakeholder_name_rg": stakeholderNameRg,
    "location_name": locationName,
  };
}
