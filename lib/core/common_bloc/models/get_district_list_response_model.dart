class GetDistrictListResponseModel {
  int? code;
  String? status;
  List<Data>? data;

  GetDistrictListResponseModel({this.code, this.status, this.data});

  GetDistrictListResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? districtID;
  int? stateID;
  Null? createdBy;
  Null? updatedBy;
  Null? createdDate;
  Null? updatedDate;
  Null? deletedBy;
  Null? unitId;
  String? districtName;
  String? status;
  Null? divID;
  Null? stateName;
  Null? divisionName;

  Data(
      {this.districtID,
      this.stateID,
      this.createdBy,
      this.updatedBy,
      this.createdDate,
      this.updatedDate,
      this.deletedBy,
      this.unitId,
      this.districtName,
      this.status,
      this.divID,
      this.stateName,
      this.divisionName});

  Data.fromJson(Map<String, dynamic> json) {
    districtID = json['district_ID'];
    stateID = json['state_ID'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    deletedBy = json['deletedBy'];
    unitId = json['unitId'];
    districtName = json['districtName'];
    status = json['status'];
    divID = json['divID'];
    stateName = json['stateName'];
    divisionName = json['divisionName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district_ID'] = this.districtID;
    data['state_ID'] = this.stateID;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    data['deletedBy'] = this.deletedBy;
    data['unitId'] = this.unitId;
    data['districtName'] = this.districtName;
    data['status'] = this.status;
    data['divID'] = this.divID;
    data['stateName'] = this.stateName;
    data['divisionName'] = this.divisionName;
    return data;
  }
}
