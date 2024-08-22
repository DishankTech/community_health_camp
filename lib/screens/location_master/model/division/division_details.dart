import 'lookup_det.dart';

class Details {
  Details({
      this.lookupId, 
      this.lookupCode, 
      this.lookupDet,});

  Details.fromJson(dynamic json) {
    lookupId = json['lookup_id'];
    lookupCode = json['lookup_code'];
    if (json['lookup_det'] != null) {
      lookupDet = [];
      json['lookup_det'].forEach((v) {
        lookupDet?.add(LookupDet.fromJson(v));
      });
    }
  }
  int? lookupId;
  String? lookupCode;
  List<LookupDet>? lookupDet;

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