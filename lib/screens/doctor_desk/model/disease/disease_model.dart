import 'disease_details.dart';

class DiseaseModel {
  DiseaseModel({
      this.statusCode, 
      this.message, 
      this.path, 
      this.dateTime, 
      this.details,});

  DiseaseModel.fromJson(dynamic json) {
    statusCode = json['status_code'];
    message = json['message'];
    path = json['path'];
    dateTime = json['dateTime'];
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details?.add(DiseaseDetails.fromJson(v));
      });
    }
  }
  int? statusCode;
  String? message;
  String? path;
  String? dateTime;
  List<DiseaseDetails>? details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = statusCode;
    map['message'] = message;
    map['path'] = path;
    map['dateTime'] = dateTime;
    if (details != null) {
      map['details'] = details?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}