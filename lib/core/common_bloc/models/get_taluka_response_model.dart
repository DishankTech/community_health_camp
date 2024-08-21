class GetTalukaListResponseModel {
  int? code;
  String? status;
  List<Data>? data;

  GetTalukaListResponseModel({this.code, this.status, this.data});

  GetTalukaListResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? talukaID;
  int? districtID;
  int? divID;
  Null? createdBy;
  Null? updatedBy;
  Null? createdDate;
  Null? updatedDate;
  Null? deletedBy;
  Null? unitId;
  String? talukaName;
  String? status;
  int? stateID;
  Null? districtName;
  Null? stateName;
  Null? cityName;
  Null? divisionName;
  int? cityId;

  Data(
      {this.talukaID,
      this.districtID,
      this.divID,
      this.createdBy,
      this.updatedBy,
      this.createdDate,
      this.updatedDate,
      this.deletedBy,
      this.unitId,
      this.talukaName,
      this.status,
      this.stateID,
      this.districtName,
      this.stateName,
      this.cityName,
      this.divisionName,
      this.cityId});

  Data.fromJson(Map<String, dynamic> json) {
    talukaID = json['taluka_ID'];
    districtID = json['district_ID'];
    divID = json['div_ID'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    deletedBy = json['deletedBy'];
    unitId = json['unitId'];
    talukaName = json['talukaName'];
    status = json['status'];
    stateID = json['state_ID'];
    districtName = json['districtName'];
    stateName = json['stateName'];
    cityName = json['cityName'];
    divisionName = json['divisionName'];
    cityId = json['city_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taluka_ID'] = this.talukaID;
    data['district_ID'] = this.districtID;
    data['div_ID'] = this.divID;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    data['deletedBy'] = this.deletedBy;
    data['unitId'] = this.unitId;
    data['talukaName'] = this.talukaName;
    data['status'] = this.status;
    data['state_ID'] = this.stateID;
    data['districtName'] = this.districtName;
    data['stateName'] = this.stateName;
    data['cityName'] = this.cityName;
    data['divisionName'] = this.divisionName;
    data['city_id'] = this.cityId;
    return data;
  }
}
