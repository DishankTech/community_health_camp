class AddLocationMasterResp {
  AddLocationMasterResp({
      this.uniquerId, 
      this.statusCode, 
      this.message, 
      this.path, 
      this.dateTime,});

  AddLocationMasterResp.fromJson(dynamic json) {
    uniquerId = json['uniquerId'];
    statusCode = json['status_code'];
    message = json['message'];
    path = json['path'];
    dateTime = json['dateTime'];
  }
  int? uniquerId;
  int? statusCode;
  String? message;
  String? path;
  String? dateTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uniquerId'] = uniquerId;
    map['status_code'] = statusCode;
    map['message'] = message;
    map['path'] = path;
    map['dateTime'] = dateTime;
    return map;
  }

}