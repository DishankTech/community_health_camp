class GetMaritalStatusResponseModel {
  int? code;
  String? status;
  List<Data>? data;

  GetMaritalStatusResponseModel({this.code, this.status, this.data});

  GetMaritalStatusResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? lookupDetId;
  String? lookupDetValue;
  String? lookupDetDescEn;
  String? lookupDetDescRg;
  int? lookupDetParentId;
  int? lookupDetParentLevel;
  String? lookupDetParentName;
  Null? lookupDetList;
  int? ulbId;

  Data(
      {this.lookupDetId,
      this.lookupDetValue,
      this.lookupDetDescEn,
      this.lookupDetDescRg,
      this.lookupDetParentId,
      this.lookupDetParentLevel,
      this.lookupDetParentName,
      this.lookupDetList,
      this.ulbId});

  Data.fromJson(Map<String, dynamic> json) {
    lookupDetId = json['lookupDetId'];
    lookupDetValue = json['lookupDetValue'];
    lookupDetDescEn = json['lookupDetDescEn'];
    lookupDetDescRg = json['lookupDetDescRg'];
    lookupDetParentId = json['lookupDetParentId'];
    lookupDetParentLevel = json['lookupDetParentLevel'];
    lookupDetParentName = json['lookupDetParentName'];
    lookupDetList = json['lookupDetList'];
    ulbId = json['ulbId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lookupDetId'] = lookupDetId;
    data['lookupDetValue'] = lookupDetValue;
    data['lookupDetDescEn'] = lookupDetDescEn;
    data['lookupDetDescRg'] = lookupDetDescRg;
    data['lookupDetParentId'] = lookupDetParentId;
    data['lookupDetParentLevel'] = lookupDetParentLevel;
    data['lookupDetParentName'] = lookupDetParentName;
    data['lookupDetList'] = lookupDetList;
    data['ulbId'] = ulbId;
    return data;
  }
}
