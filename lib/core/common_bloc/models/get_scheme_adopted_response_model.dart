class GetSchemeAdoptedResponseModel {
  int? code;
  String? status;
  List<Data>? data;

  GetSchemeAdoptedResponseModel({this.code, this.status, this.data});

  GetSchemeAdoptedResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
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
  Null? lookupDetDescRg;
  Null? lookupDetParentId;
  Null? lookupDetParentLevel;
  String? lookupDetParentName;
  Null? lookupDetList;
  Null? ulbId;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lookupDetId'] = this.lookupDetId;
    data['lookupDetValue'] = this.lookupDetValue;
    data['lookupDetDescEn'] = this.lookupDetDescEn;
    data['lookupDetDescRg'] = this.lookupDetDescRg;
    data['lookupDetParentId'] = this.lookupDetParentId;
    data['lookupDetParentLevel'] = this.lookupDetParentLevel;
    data['lookupDetParentName'] = this.lookupDetParentName;
    data['lookupDetList'] = this.lookupDetList;
    data['ulbId'] = this.ulbId;
    return data;
  }
}
