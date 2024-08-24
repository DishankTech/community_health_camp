class UserDetails {
  UserDetails({
      this.userId, 
      this.fullName, 
      this.loginName, 
      this.mobileNumber,});

  UserDetails.fromJson(dynamic json) {
    userId = json['user_id'];
    fullName = json['full_name'];
    loginName = json['login_name'];
    mobileNumber = json['mobile_number'];
  }
  int? userId;
  String? fullName;
  String? loginName;
  String? mobileNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['full_name'] = fullName;
    map['login_name'] = loginName;
    map['mobile_number'] = mobileNumber;
    return map;
  }

}