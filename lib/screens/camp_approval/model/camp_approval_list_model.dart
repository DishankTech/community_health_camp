import 'camp_approval_details.dart';

class CampApprovalListModel {
  CampApprovalListModel({
      this.statusCode, 
      this.message, 
      this.path, 
      this.dateTime, 
      this.details,});

  CampApprovalListModel.fromJson(dynamic json) {
    statusCode = json['status_code'];
    message = json['message'];
    path = json['path'];
    dateTime = json['dateTime'];
    details = json['details'] != null ? CampApprovalDetails.fromJson(json['details']) : null;
  }
  int? statusCode;
  String? message;
  String? path;
  String? dateTime;
  CampApprovalDetails? details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = statusCode;
    map['message'] = message;
    map['path'] = path;
    map['dateTime'] = dateTime;
    if (details != null) {
      map['details'] = details?.toJson();
    }
    return map;
  }

}