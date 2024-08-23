class MasterResponseModel {
  int? statusCode;
  String? message;
  String? path;
  String? dateTime;
  List<Details>? details;

  MasterResponseModel(
      {this.statusCode, this.message, this.path, this.dateTime, this.details});

  MasterResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    path = json['path'];
    dateTime = json['dateTime'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['message'] = message;
    data['path'] = path;
    data['dateTime'] = dateTime;
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  int? lookupId;
  String? lookupCode;
  List<LookupDet>? lookupDet;

  Details({this.lookupId, this.lookupCode, this.lookupDet});

  Details.fromJson(Map<String, dynamic> json) {
    lookupId = json['lookup_id'];
    lookupCode = json['lookup_code'];
    if (json['lookup_det'] != null) {
      lookupDet = <LookupDet>[];
      json['lookup_det'].forEach((v) {
        lookupDet!.add(new LookupDet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lookup_id'] = lookupId;
    data['lookup_code'] = lookupCode;
    if (lookupDet != null) {
      data['lookup_det'] = lookupDet!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LookupDet {
  int? lookupDetId;
  String? lookupDetValue;
  String? lookupDetDescEn;
  String? lookupDetDescRg;
  Null? lookupDetOthers;
  int? status;

  LookupDet(
      {this.lookupDetId,
      this.lookupDetValue,
      this.lookupDetDescEn,
      this.lookupDetDescRg,
      this.lookupDetOthers,
      this.status});

  LookupDet.fromJson(Map<String, dynamic> json) {
    lookupDetId = json['lookup_det_id'];
    lookupDetValue = json['lookup_det_value'];
    lookupDetDescEn = json['lookup_det_desc_en'];
    lookupDetDescRg = json['lookup_det_desc_rg'];
    lookupDetOthers = json['lookup_det_others'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lookup_det_id'] = lookupDetId;
    data['lookup_det_value'] = lookupDetValue;
    data['lookup_det_desc_en'] = lookupDetDescEn;
    data['lookup_det_desc_rg'] = lookupDetDescRg;
    data['lookup_det_others'] = lookupDetOthers;
    data['status'] = status;
    return data;
  }
}
