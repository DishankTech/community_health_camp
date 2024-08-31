import 'disease_lookup_det.dart';

class DiseaseDetails {
  DiseaseDetails({
      this.lookupId, 
      this.lookupCode, 
      this.lookupDet,});

  DiseaseDetails.fromJson(dynamic json) {
    lookupId = json['lookup_id'];
    lookupCode = json['lookup_code'];
    if (json['lookup_det'] != null) {
      lookupDet = [];
      json['lookup_det'].forEach((v) {
        lookupDet?.add(DiseaseLookupDet.fromJson(v));
      });
    }
  }
  int? lookupId;
  String? lookupCode;
  List<DiseaseLookupDet>? lookupDet;

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