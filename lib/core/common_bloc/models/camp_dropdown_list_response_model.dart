class CampDropdownReponseModel {
  int? statusCode;
  String? message;
  String? path;
  String? dateTime;
  List<CampDetails>? details;

  CampDropdownReponseModel(
      {this.statusCode, this.message, this.path, this.dateTime, this.details});

  CampDropdownReponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    path = json['path'];
    dateTime = json['dateTime'];
    if (json['details'] != null) {
      details = <CampDetails>[];
      json['details'].forEach((v) {
        details!.add(new CampDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    data['path'] = this.path;
    data['dateTime'] = this.dateTime;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CampDetails {
  int? campCreateRequestId;
  String? propCampDate;

  CampDetails({this.campCreateRequestId, this.propCampDate});

  CampDetails.fromJson(Map<String, dynamic> json) {
    campCreateRequestId = json['camp_create_request_id'];
    propCampDate = json['prop_camp_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['camp_create_request_id'] = this.campCreateRequestId;
    data['prop_camp_date'] = this.propCampDate;
    return data;
  }
}
