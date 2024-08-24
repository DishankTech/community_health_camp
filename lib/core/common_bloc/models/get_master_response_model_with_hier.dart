class GetUserMasterWithHierResponse {
  int? statusCode;
  String? message;
  String? path;
  String? dateTime;
  List<Details>? details;

  GetUserMasterWithHierResponse(
      {this.statusCode, this.message, this.path, this.dateTime, this.details});

  GetUserMasterWithHierResponse.fromJson(Map<String, dynamic> json) {
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
  int? lookupDetId;
  String? lookupDetValue;
  List<LookupDetHierarchical>? lookupDetHierarchical;

  Details({this.lookupDetId, this.lookupDetValue, this.lookupDetHierarchical});

  Details.fromJson(Map<String, dynamic> json) {
    lookupDetId = json['lookup_det_id'];
    lookupDetValue = json['lookup_det_value'];
    if (json['lookup_det_hierarchical'] != null) {
      lookupDetHierarchical = <LookupDetHierarchical>[];
      json['lookup_det_hierarchical'].forEach((v) {
        lookupDetHierarchical!.add(new LookupDetHierarchical.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lookup_det_id'] = lookupDetId;
    data['lookup_det_value'] = lookupDetValue;
    if (lookupDetHierarchical != null) {
      data['lookup_det_hierarchical'] =
          lookupDetHierarchical!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LookupDetHierarchical {
  int? lookupDetHierId;
  String? lookupDetHierValue;
  String? lookupDetHierDescEn;
  String? lookupDetHierDescRg;
  int? lookupDetHierParentId;
  int? status;

  LookupDetHierarchical(
      {this.lookupDetHierId,
      this.lookupDetHierValue,
      this.lookupDetHierDescEn,
      this.lookupDetHierDescRg,
      this.lookupDetHierParentId,
      this.status});

  LookupDetHierarchical.fromJson(Map<String, dynamic> json) {
    lookupDetHierId = json['lookup_det_hier_id'];
    lookupDetHierValue = json['lookup_det_hier_value'];
    lookupDetHierDescEn = json['lookup_det_hier_desc_en'];
    lookupDetHierDescRg = json['lookup_det_hier_desc_rg'];
    lookupDetHierParentId = json['lookup_det_hier_parent_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lookup_det_hier_id'] = lookupDetHierId;
    data['lookup_det_hier_value'] = lookupDetHierValue;
    data['lookup_det_hier_desc_en'] = lookupDetHierDescEn;
    data['lookup_det_hier_desc_rg'] = lookupDetHierDescRg;
    data['lookup_det_hier_parent_id'] = lookupDetHierParentId;
    data['status'] = status;
    return data;
  }
}
