class BloodGroupResponseModel {
  int? code;
  String? status;
  List<Data>? data;

  BloodGroupResponseModel({this.code, this.status, this.data});

  BloodGroupResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? bloodGroupId;
  String? bloodGrouptName;
  int? createdBy;
  int? updatedBy;
  int? createdDate;
  int? updatedDate;
  int? deletedDate;
  Null? deletedBy;
  int? unitId;
  String? status;
  String? ipAddress;
  Null? lstBloodGroupMaster;

  Data(
      {this.bloodGroupId,
      this.bloodGrouptName,
      this.createdBy,
      this.updatedBy,
      this.createdDate,
      this.updatedDate,
      this.deletedDate,
      this.deletedBy,
      this.unitId,
      this.status,
      this.ipAddress,
      this.lstBloodGroupMaster});

  Data.fromJson(Map<String, dynamic> json) {
    bloodGroupId = json['bloodGroupId'];
    bloodGrouptName = json['bloodGrouptName'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    deletedDate = json['deletedDate'];
    deletedBy = json['deletedBy'];
    unitId = json['unitId'];
    status = json['status'];
    ipAddress = json['ipAddress'];
    lstBloodGroupMaster = json['lstBloodGroupMaster'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bloodGroupId'] = bloodGroupId;
    data['bloodGrouptName'] = bloodGrouptName;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['deletedDate'] = deletedDate;
    data['deletedBy'] = deletedBy;
    data['unitId'] = unitId;
    data['status'] = status;
    data['ipAddress'] = ipAddress;
    data['lstBloodGroupMaster'] = lstBloodGroupMaster;
    return data;
  }
}
