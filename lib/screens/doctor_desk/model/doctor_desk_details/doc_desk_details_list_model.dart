import 'doc_desk_details.dart';

class DocDeskDetailsListModel {
  DocDeskDetailsListModel({
      this.statusCode, 
      this.message, 
      this.path, 
      this.dateTime, 
      this.details,});

  DocDeskDetailsListModel.fromJson(dynamic json) {
    statusCode = json['status_code'];
    message = json['message'];
    path = json['path'];
    dateTime = json['dateTime'];
    details = json['details'] != null ? DocDeskDetails.fromJson(json['details']) : null;
  }
  int? statusCode;
  String? message;
  String? path;
  String? dateTime;
  DocDeskDetails? details;

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