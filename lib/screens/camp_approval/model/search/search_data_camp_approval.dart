import 'search_cam_details.dart';

class SearchDataCampApproval {
  SearchDataCampApproval({
      this.statusCode, 
      this.message, 
      this.path, 
      this.dateTime, 
      this.details,});

  SearchDataCampApproval.fromJson(dynamic json) {
    statusCode = json['status_code'];
    message = json['message'];
    path = json['path'];
    dateTime = json['dateTime'];
    details = json['details'] != null ? SearchCampDetails.fromJson(json['details']) : null;
  }
  int? statusCode;
  String? message;
  String? path;
  String? dateTime;
  SearchCampDetails? details;

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