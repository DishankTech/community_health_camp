class GetUnitListResponseModel {
  int? code;
  String? status;
  List<Data>? data;

  GetUnitListResponseModel({this.code, this.status, this.data});

  GetUnitListResponseModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = code;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? unitId;
  String? unitName;
  Null? unitCode;
  Null? stateId;
  Null? stateName;
  Null? districtId;
  String? districtName;
  Null? typeId;
  Null? typeName;
  Null? hospitalId;
  Null? hospitalName;
  Null? yearId;
  Null? year;
  Null? createdBy;
  Null? updatedBy;
  Null? deletedBy;
  String? deleted;
  Null? createdDate;
  Null? updatedDate;
  Null? deletedDate;
  String? activeFlag;
  Null? divisionName;
  Null? divisionId;
  Null? talukaName;
  Null? talukaId;
  Null? longitude;
  Null? latitude;
  Null? unitAddress;
  Null? zipCode;
  Null? unitEmail;
  Null? contactNo;
  Null? filePath;
  Null? idHospital;
  Null? slotListN;

  Data(
      {this.unitId,
      this.unitName,
      this.unitCode,
      this.stateId,
      this.stateName,
      this.districtId,
      this.districtName,
      this.typeId,
      this.typeName,
      this.hospitalId,
      this.hospitalName,
      this.yearId,
      this.year,
      this.createdBy,
      this.updatedBy,
      this.deletedBy,
      this.deleted,
      this.createdDate,
      this.updatedDate,
      this.deletedDate,
      this.activeFlag,
      this.divisionName,
      this.divisionId,
      this.talukaName,
      this.talukaId,
      this.longitude,
      this.latitude,
      this.unitAddress,
      this.zipCode,
      this.unitEmail,
      this.contactNo,
      this.filePath,
      this.idHospital,
      this.slotListN});

  Data.fromJson(Map<String, dynamic> json) {
    unitId = json['unitId'];
    unitName = json['unitName'];
    unitCode = json['unitCode'];
    stateId = json['stateId'];
    stateName = json['stateName'];
    districtId = json['districtId'];
    districtName = json['districtName'];
    typeId = json['typeId'];
    typeName = json['typeName'];
    hospitalId = json['hospitalId'];
    hospitalName = json['hospitalName'];
    yearId = json['yearId'];
    year = json['year'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    deletedBy = json['deletedBy'];
    deleted = json['deleted'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    deletedDate = json['deletedDate'];
    activeFlag = json['activeFlag'];
    divisionName = json['divisionName'];
    divisionId = json['divisionId'];
    talukaName = json['talukaName'];
    talukaId = json['talukaId'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    unitAddress = json['unitAddress'];
    zipCode = json['zipCode'];
    unitEmail = json['unitEmail'];
    contactNo = json['contactNo'];
    filePath = json['filePath'];
    idHospital = json['idHospital'];
    slotListN = json['slotListN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['unitId'] = unitId;
    data['unitName'] = unitName;
    data['unitCode'] = unitCode;
    data['stateId'] = stateId;
    data['stateName'] = stateName;
    data['districtId'] = districtId;
    data['districtName'] = districtName;
    data['typeId'] = typeId;
    data['typeName'] = typeName;
    data['hospitalId'] = hospitalId;
    data['hospitalName'] = hospitalName;
    data['yearId'] = yearId;
    data['year'] = year;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['deletedBy'] = deletedBy;
    data['deleted'] = deleted;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['deletedDate'] = deletedDate;
    data['activeFlag'] = activeFlag;
    data['divisionName'] = divisionName;
    data['divisionId'] = divisionId;
    data['talukaName'] = talukaName;
    data['talukaId'] = talukaId;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['unitAddress'] = unitAddress;
    data['zipCode'] = zipCode;
    data['unitEmail'] = unitEmail;
    data['contactNo'] = contactNo;
    data['filePath'] = filePath;
    data['idHospital'] = idHospital;
    data['slotListN'] = slotListN;
    return data;
  }
}
