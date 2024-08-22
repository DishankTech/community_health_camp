import 'lookup_det_hierarchical.dart';

class CountryDetails {
  CountryDetails({
      this.lookupDetId, 
      this.lookupDetValue, 
      this.lookupDetHierarchical,});

  CountryDetails.fromJson(dynamic json) {
    lookupDetId = json['lookup_det_id'];
    lookupDetValue = json['lookup_det_value'];
    if (json['lookup_det_hierarchical'] != null) {
      lookupDetHierarchical = [];
      json['lookup_det_hierarchical'].forEach((v) {
        lookupDetHierarchical?.add(LookupDetHierarchical.fromJson(v));
      });
    }
  }
  int? lookupDetId;
  String? lookupDetValue;
  List<LookupDetHierarchical>? lookupDetHierarchical;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lookup_det_id'] = lookupDetId;
    map['lookup_det_value'] = lookupDetValue;
    if (lookupDetHierarchical != null) {
      map['lookup_det_hierarchical'] = lookupDetHierarchical?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}