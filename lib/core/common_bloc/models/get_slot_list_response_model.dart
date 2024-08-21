class GetSlotListResponseModel {
  int? code;
  String? status;
  List<Data>? data;

  GetSlotListResponseModel({this.code, this.status, this.data});

  GetSlotListResponseModel.fromJson(Map<String, dynamic> json) {
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
  Null? unitId;
  Null? unitName;
  int? slotId;
  Null? lookupDetId;
  String? slotFromTime;
  String? slotToTime;
  Null? effectiveFromDate;
  Null? effectiveToDate;
  Null? status;
  Null? createdDate;
  Null? createdBy;
  Null? updatedDate;
  Null? updatedBy;
  Null? macId;
  Null? ipAddress;
  Null? deviceFrom;

  Null? effFromDate;
  Null? effToDate;
  Null? lookupDetDescEn;
  Null? list;
  Null? districtName;

  Data(
      {this.unitId,
      this.unitName,
      this.slotId,
      this.lookupDetId,
      this.slotFromTime,
      this.slotToTime,
      this.effectiveFromDate,
      this.effectiveToDate,
      this.status,
      this.createdDate,
      this.createdBy,
      this.updatedDate,
      this.updatedBy,
      this.macId,
      this.ipAddress,
      this.deviceFrom,
      this.effFromDate,
      this.effToDate,
      this.lookupDetDescEn,
      this.list,
      this.districtName});

  Data.fromJson(Map<String, dynamic> json) {
    unitId = json['unitId'];
    unitName = json['unitName'];
    slotId = json['slotId'];
    lookupDetId = json['lookupDetId'];
    slotFromTime = json['slot_From_Time'];
    slotToTime = json['slot_To_Time'];
    effectiveFromDate = json['effectiveFromDate'];
    effectiveToDate = json['effectiveToDate'];
    status = json['status'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    updatedDate = json['updatedDate'];
    updatedBy = json['updatedBy'];
    macId = json['macId'];
    ipAddress = json['ipAddress'];
    deviceFrom = json['deviceFrom'];
    effFromDate = json['eff_From_date'];
    effToDate = json['eff_To_Date'];
    lookupDetDescEn = json['lookupDetDescEn'];
    list = json['list'];
    districtName = json['districtName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unitId'] = unitId;
    data['unitName'] = unitName;
    data['slotId'] = slotId;
    data['lookupDetId'] = lookupDetId;
    data['slotFromTime'] = slotFromTime;
    data['slotToTime'] = slotToTime;
    data['effectiveFromDate'] = effectiveFromDate;
    data['effectiveToDate'] = effectiveToDate;
    data['status'] = status;
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['updatedDate'] = updatedDate;
    data['updatedBy'] = updatedBy;
    data['macId'] = macId;
    data['ipAddress'] = ipAddress;
    data['deviceFrom'] = deviceFrom;
    data['slot_From_Time'] = slotFromTime;
    data['slot_To_Time'] = slotToTime;
    data['eff_From_date'] = effFromDate;
    data['eff_To_Date'] = effToDate;
    data['lookupDetDescEn'] = lookupDetDescEn;
    data['list'] = list;
    data['districtName'] = districtName;
    return data;
  }
}
