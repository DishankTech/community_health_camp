class SectorModel {
  SectorModel({
    this.statusCode,
    this.message,
    this.path,
    this.dateTime,
    this.details,
  });

  SectorModel.fromJson(dynamic json) {
    statusCode = json['status_code'];
    message = json['message'];
    path = json['path'];
    dateTime = json['dateTime'];
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details?.add(SectorDetails.fromJson(v));
      });
    }
  }

  int? statusCode;
  String? message;
  String? path;
  String? dateTime;
  List<SectorDetails>? details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = statusCode;
    map['message'] = message;
    map['path'] = path;
    map['dateTime'] = dateTime;
    if (details != null) {
      map['details'] = details?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class SectorLookupDet {
  SectorLookupDet({
    this.lookupDetId,
    this.lookupDetValue,
    this.lookupDetDescEn,
    this.lookupDetDescRg,
    this.lookupDetOthers,
    this.status,
  });

  SectorLookupDet.fromJson(dynamic json) {
    lookupDetId = json['lookup_det_id'];
    lookupDetValue = json['lookup_det_value'];
    lookupDetDescEn = json['lookup_det_desc_en'];
    lookupDetDescRg = json['lookup_det_desc_rg'];
    lookupDetOthers = json['lookup_det_others'];
    status = json['status'];
  }

  int? lookupDetId;
  String? lookupDetValue;
  String? lookupDetDescEn;
  String? lookupDetDescRg;
  dynamic lookupDetOthers;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lookup_det_id'] = lookupDetId;
    map['lookup_det_value'] = lookupDetValue;
    map['lookup_det_desc_en'] = lookupDetDescEn;
    map['lookup_det_desc_rg'] = lookupDetDescRg;
    map['lookup_det_others'] = lookupDetOthers;
    map['status'] = status;
    return map;
  }
}

class SectorDetails {
  SectorDetails({
    this.lookupId,
    this.lookupCode,
    this.lookupDet,
  });

  SectorDetails.fromJson(dynamic json) {
    lookupId = json['lookup_id'];
    lookupCode = json['lookup_code'];
    if (json['lookup_det'] != null) {
      lookupDet = [];
      json['lookup_det'].forEach((v) {
        lookupDet?.add(SectorLookupDet.fromJson(v));
      });
    }
  }

  int? lookupId;
  String? lookupCode;
  List<SectorLookupDet>? lookupDet;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lookup_id'] = lookupId;
    map['lookup_code'] = lookupCode;
    if (lookupDet != null) {
      map['lookup_det'] = lookupDet?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
