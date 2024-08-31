// To parse this JSON data, do
//
//     final campDropdownRespModel = campDropdownRespModelFromJson(jsonString);

import 'dart:convert';

CampDropdownRespModel campDropdownRespModelFromJson(String str) => CampDropdownRespModel.fromJson(json.decode(str));

String campDropdownRespModelToJson(CampDropdownRespModel data) => json.encode(data.toJson());

class CampDropdownRespModel {
  int? statusCode;
  String? message;
  String? path;
  DateTime? dateTime;
  List<ReferredCampDetails>? details;

  CampDropdownRespModel({
    this.statusCode,
    this.message,
    this.path,
    this.dateTime,
    this.details,
  });

  factory CampDropdownRespModel.fromJson(Map<String, dynamic> json) => CampDropdownRespModel(
    statusCode: json["status_code"],
    message: json["message"],
    path: json["path"],
    dateTime: json["dateTime"] == null ? null : DateTime.parse(json["dateTime"]),
    details: json["details"] == null ? [] : List<ReferredCampDetails>.from(json["details"]!.map((x) => ReferredCampDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
    "path": path,
    "dateTime": dateTime?.toIso8601String(),
    "details": details == null ? [] : List<dynamic>.from(details!.map((x) => x.toJson())),
  };
}

class ReferredCampDetails {
  int? campCreateRequestId;
  String? campNumber;
  int? campDashboardId;
  int? referredPatients;

  ReferredCampDetails({
    this.campCreateRequestId,
    this.campNumber,
    this.campDashboardId,
    this.referredPatients,
  });

  factory ReferredCampDetails.fromJson(Map<String, dynamic> json) => ReferredCampDetails(
    campCreateRequestId: json["camp_create_request_id"],
    campNumber: json["camp_number"],
    campDashboardId: json["camp_dashboard_id"],
    referredPatients: json["referred_patients"],
  );

  Map<String, dynamic> toJson() => {
    "camp_create_request_id": campCreateRequestId,
    "camp_number": campNumber,
    "camp_dashboard_id": campDashboardId,
    "referred_patients": referredPatients,
  };
}
