import 'member_lookup_det.dart';

class MemberDetails {
  MemberDetails({
      this.lookupId, 
      this.lookupCode, 
      this.lookupDet,});

  MemberDetails.fromJson(dynamic json) {
    lookupId = json['lookup_id'];
    lookupCode = json['lookup_code'];
    if (json['lookup_det'] != null) {
      lookupDet = [];
      json['lookup_det'].forEach((v) {
        lookupDet?.add(MemberLookupDet.fromJson(v));
      });
    }
  }
  int? lookupId;
  String? lookupCode;
  List<MemberLookupDet>? lookupDet;

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