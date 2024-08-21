class GetStateListResponseModel {
  int? code;
  String? status;
  List<Data>? data;

  GetStateListResponseModel({this.code, this.status, this.data});

  GetStateListResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? stateID;
  String? stateName;
  String? status;
  Null? createdBy;
  Null? updatedBy;
  Null? createdDate;
  Null? updatedDate;
  Null? deletedBy;
  Null? unitId;

  Data(
      {this.stateID,
      this.stateName,
      this.status,
      this.createdBy,
      this.updatedBy,
      this.createdDate,
      this.updatedDate,
      this.deletedBy,
      this.unitId});

  Data.fromJson(Map<String, dynamic> json) {
    stateID = json['state_ID'];
    stateName = json['stateName'];
    status = json['status'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    deletedBy = json['deletedBy'];
    unitId = json['unitId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_ID'] = this.stateID;
    data['stateName'] = this.stateName;
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    data['deletedBy'] = this.deletedBy;
    data['unitId'] = this.unitId;
    return data;
  }
}
