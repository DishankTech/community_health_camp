class TtCampCreateDetails {
  TtCampCreateDetails({
      this.campCreateRequestDetId, 
      this.campCreateRequestId, 
      this.lookupDetIdType, 
      this.userId, 
      this.userName, 
      this.userLogin, 
      this.userMobileNumber, 
      this.status = 1,
      this.isInactive,});

  TtCampCreateDetails.fromJson(dynamic json) {
    campCreateRequestDetId = json['camp_create_request_det_id'];
    campCreateRequestId = json['camp_create_request_id'];
    lookupDetIdType = json['lookup_det_id_type'];
    userId = json['user_id'];
    userName = json['user_name'];
    userLogin = json['user_login'];
    userMobileNumber = json['user_mobile_number'];
    status = json['status'];
    isInactive = json['is_inactive'];
  }
  dynamic campCreateRequestDetId;
  dynamic campCreateRequestId;
  int? lookupDetIdType;
  String? memberType;
  int? userId;
  String? userName;
  String? userLogin;
  String? userMobileNumber;
  int? status;
  dynamic isInactive;
  String? selectedCountry;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['camp_create_request_det_id'] = campCreateRequestDetId;
    map['camp_create_request_id'] = campCreateRequestId;
    map['lookup_det_id_type'] = lookupDetIdType;
    map['user_id'] = userId;
    map['user_name'] = userName;
    map['user_login'] = userLogin;
    map['user_mobile_number'] = userMobileNumber;
    map['status'] = status;
    map['is_inactive'] = isInactive;
    return map;
  }

}