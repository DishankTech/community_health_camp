import 'referral_details.dart';

class ReferralModel {
  ReferralModel({
      this.statusCode, 
      this.message, 
      this.path, 
      this.dateTime, 
      this.details,});

  ReferralModel.fromJson(dynamic json) {
    statusCode = json['status_code'];
    message = json['message'];
    path = json['path'];
    dateTime = json['dateTime'];
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details?.add(ReferralDetails.fromJson(v));
      });
    }
  }
  int? statusCode;
  String? message;
  String? path;
  String? dateTime;
  List<ReferralDetails>? details;

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