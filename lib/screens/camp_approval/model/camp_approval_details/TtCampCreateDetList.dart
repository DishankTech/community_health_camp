class TtCampCreateDetList {
  TtCampCreateDetList({
      this.campCreateRequestDetId, 
      this.campCreateRequestId, 
      this.userId, 
      this.userMobileNumber, 
      this.userLogin, 
      this.stakeholderNameEn,
      this.lookupDetDescEn,
      this.status,});

  TtCampCreateDetList.fromJson(dynamic json) {
    campCreateRequestDetId = json['camp_create_request_det_id'];
    campCreateRequestId = json['camp_create_request_id'];
    userId = json['user_id'];
    userMobileNumber = json['user_mobile_number'];
    userLogin = json['user_login'];
    stakeholderNameEn = json['stakeholder_name_en'];
    lookupDetDescEn = json['lookup_det_desc_en'];
    status = json['status'];
  }
  int? campCreateRequestDetId;
  int? campCreateRequestId;
  int? userId;
  String? userMobileNumber;
  String? userLogin;
  String? stakeholderNameEn;
  String? lookupDetDescEn;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['camp_create_request_det_id'] = campCreateRequestDetId;
    map['camp_create_request_id'] = campCreateRequestId;
    map['user_id'] = userId;
    map['user_mobile_number'] = userMobileNumber;
    map['user_login'] = userLogin;
    map['stakeholder_name_en'] = stakeholderNameEn;
    map['lookup_det_desc_en'] = lookupDetDescEn;
    map['status'] = status;
    return map;
  }

}