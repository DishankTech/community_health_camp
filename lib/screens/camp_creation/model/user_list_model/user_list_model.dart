import 'user_details.dart';

class UserListModel {
  UserListModel({
      this.statusCode, 
      this.message, 
      this.path, 
      this.dateTime, 
      this.details,});

  UserListModel.fromJson(dynamic json) {
    statusCode = json['status_code'];
    message = json['message'];
    path = json['path'];
    dateTime = json['dateTime'];
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details?.add(UserDetails.fromJson(v));
      });
    }
  }
  int? statusCode;
  String? message;
  String? path;
  String? dateTime;
  List<UserDetails>? details;

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