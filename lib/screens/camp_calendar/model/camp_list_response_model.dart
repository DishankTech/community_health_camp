// To parse this JSON data, do
//
//     final campDetailsResponseModel = campDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

CampDetailsResponseModel campDetailsResponseModelFromJson(String str) =>
    CampDetailsResponseModel.fromJson(json.decode(str));

String campDetailsResponseModelToJson(CampDetailsResponseModel data) =>
    json.encode(data.toJson());

class CampDetailsResponseModel {
  int statusCode;
  String message;
  String path;
  DateTime dateTime;
  CampDetails details;

  CampDetailsResponseModel({
    required this.statusCode,
    required this.message,
    required this.path,
    required this.dateTime,
    required this.details,
  });

  factory CampDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      CampDetailsResponseModel(
        statusCode: json["status_code"],
        message: json["message"],
        path: json["path"],
        dateTime: DateTime.parse(json["dateTime"]),
        details: CampDetails.fromJson(json["details"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "path": path,
        "dateTime": dateTime.toIso8601String(),
        "details": details.toJson(),
      };
}

class CampDetails {
  int totalPages;
  int page;
  int totalCount;
  int perPage;
  List<Datum> data;

  CampDetails({
    required this.totalPages,
    required this.page,
    required this.totalCount,
    required this.perPage,
    required this.data,
  });

  factory CampDetails.fromJson(Map<String, dynamic> json) => CampDetails(
        totalPages: json["total_pages"],
        page: json["page"],
        totalCount: json["total_count"],
        perPage: json["per_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_pages": totalPages,
        "page": page,
        "total_count": totalCount,
        "per_page": perPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int campCreateRequestId;
  int? stakeholderMasterId;
  int? locationMasterId;
  DateTime propCampDate;
  int? orgId;
  int status;

  Datum({
    required this.campCreateRequestId,
    required this.stakeholderMasterId,
    required this.locationMasterId,
    required this.propCampDate,
    required this.orgId,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        campCreateRequestId: json["camp_create_request_id"],
        stakeholderMasterId: json["stakeholder_master_id"],
        locationMasterId: json["location_master_id"],
        propCampDate: DateTime.parse(json["prop_camp_date"]),
        orgId: json["org_id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "camp_create_request_id": campCreateRequestId,
        "stakeholder_master_id": stakeholderMasterId,
        "location_master_id": locationMasterId,
        "prop_camp_date": propCampDate.toIso8601String(),
        "org_id": orgId,
        "status": status,
      };
}
