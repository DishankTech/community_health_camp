import 'disease_lookup_det_hierarchical.dart';

class Details {
  Details({
      this.lookupDetId, 
      this.lookupDetValue, 
      this.lookupDetHierarchical,});

  Details.fromJson(dynamic json) {
    lookupDetId = json['lookup_det_id'];
    lookupDetValue = json['lookup_det_value'];
    if (json['lookup_det_hierarchical'] != null) {
      lookupDetHierarchical = [];
      json['lookup_det_hierarchical'].forEach((v) {
        lookupDetHierarchical?.add(DiseaseLookupDetHierarchical.fromJson(v));
      });
    }
  }
  int? lookupDetId;
  String? lookupDetValue;
  List<DiseaseLookupDetHierarchical>? lookupDetHierarchical;

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