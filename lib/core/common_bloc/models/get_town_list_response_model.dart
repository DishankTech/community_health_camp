class GetTownListResponseModel {
  int? code;
  String? status;
  List<Data>? data;

  GetTownListResponseModel({this.code, this.status, this.data});

  GetTownListResponseModel.fromJson(Map<String, dynamic> json) {
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
  Null? createdBy;
  Null? updatedBy;
  Null? createdDate;
  Null? updatedDate;
  Null? deletedBy;
  Null? unitId;
  String? status;
  int? talukaID;
  int? districtID;
  int? stateID;
  Null? divisionId;
  Null? stateName;
  Null? divisionName;
  Null? districtName;
  Null? talukaName;
  int? cityId;
  String? cityName;
  Null? cityList;

  Data(
      {this.createdBy,
      this.updatedBy,
      this.createdDate,
      this.updatedDate,
      this.deletedBy,
      this.unitId,
      this.status,
      this.talukaID,
      this.districtID,
      this.stateID,
      this.divisionId,
      this.stateName,
      this.divisionName,
      this.districtName,
      this.talukaName,
      this.cityId,
      this.cityName,
      this.cityList});

  Data.fromJson(Map<String, dynamic> json) {
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    deletedBy = json['deletedBy'];
    unitId = json['unitId'];
    status = json['status'];
    talukaID = json['taluka_ID'];
    districtID = json['district_ID'];
    stateID = json['state_ID'];
    divisionId = json['divisionId'];
    stateName = json['stateName'];
    divisionName = json['divisionName'];
    districtName = json['districtName'];
    talukaName = json['talukaName'];
    cityId = json['city_id'];
    cityName = json['city_name'];
    cityList = json['cityList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    data['deletedBy'] = this.deletedBy;
    data['unitId'] = this.unitId;
    data['status'] = this.status;
    data['taluka_ID'] = this.talukaID;
    data['district_ID'] = this.districtID;
    data['state_ID'] = this.stateID;
    data['divisionId'] = this.divisionId;
    data['stateName'] = this.stateName;
    data['divisionName'] = this.divisionName;
    data['districtName'] = this.districtName;
    data['talukaName'] = this.talukaName;
    data['city_id'] = this.cityId;
    data['city_name'] = this.cityName;
    data['cityList'] = this.cityList;
    return data;
  }
}
