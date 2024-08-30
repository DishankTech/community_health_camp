import 'referral_lookup_det.dart';

class ReferralDetails {
  ReferralDetails({
      this.lookupId, 
      this.lookupCode, 
      this.lookupDet,});

  ReferralDetails.fromJson(dynamic json) {
    lookupId = json['lookup_id'];
    lookupCode = json['lookup_code'];
    if (json['lookup_det'] != null) {
      lookupDet = [];
      json['lookup_det'].forEach((v) {
        lookupDet?.add(ReferralLookupDet.fromJson(v));
      });
    }
  }
  int? lookupId;
  String? lookupCode;
  List<ReferralLookupDet>? lookupDet;

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