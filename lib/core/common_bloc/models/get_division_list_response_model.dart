class GetDivisionListResponseModel {
  int? code;
  String? status;
  List<Data>? data;

  GetDivisionListResponseModel({this.code, this.status, this.data});

  GetDivisionListResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? divId;
  String? divName;
  Null? stateId;
  Null? unitId;
  Null? status;
  Null? createdBy;
  Null? createdDate;
  Null? deletedBy;
  Null? updatedBy;
  Null? updatedDate;
  Null? stateName;

  Data(
      {this.divId,
      this.divName,
      this.stateId,
      this.unitId,
      this.status,
      this.createdBy,
      this.createdDate,
      this.deletedBy,
      this.updatedBy,
      this.updatedDate,
      this.stateName});

  Data.fromJson(Map<String, dynamic> json) {
    divId = json['divId'];
    divName = json['divName'];
    stateId = json['stateId'];
    unitId = json['unitId'];
    status = json['status'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    deletedBy = json['deletedBy'];
    updatedBy = json['updatedBy'];
    updatedDate = json['updatedDate'];
    stateName = json['stateName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['divId'] = this.divId;
    data['divName'] = this.divName;
    data['stateId'] = this.stateId;
    data['unitId'] = this.unitId;
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['deletedBy'] = this.deletedBy;
    data['updatedBy'] = this.updatedBy;
    data['updatedDate'] = this.updatedDate;
    data['stateName'] = this.stateName;
    return data;
  }
}
