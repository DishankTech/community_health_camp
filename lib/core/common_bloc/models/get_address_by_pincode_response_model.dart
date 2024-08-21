class PincodeToAddressResponseModel {
  int? talukaID;
  int? districtID;
  int? divID;
  int? createdBy;
  Null? updatedBy;
  Null? createdDate;
  Null? updatedDate;
  Null? deletedBy;
  Null? unitId;
  String? talukaName;
  String? status;
  int? stateID;
  String? districtName;
  String? stateName;
  String? cityName;
  String? divisionName;
  int? cityId;

  PincodeToAddressResponseModel(
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

  PincodeToAddressResponseModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['taluka_ID'] = talukaID;
    data['district_ID'] = districtID;
    data['div_ID'] = divID;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['deletedBy'] = deletedBy;
    data['unitId'] = unitId;
    data['talukaName'] = talukaName;
    data['status'] = status;
    data['state_ID'] = stateID;
    data['districtName'] = districtName;
    data['stateName'] = stateName;
    data['cityName'] = cityName;
    data['divisionName'] = divisionName;
    data['city_id'] = cityId;
    return data;
  }
}
