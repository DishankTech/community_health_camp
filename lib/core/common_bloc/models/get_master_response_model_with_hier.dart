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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    data['path'] = this.path;
    data['dateTime'] = this.dateTime;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lookup_det_id'] = this.lookupDetId;
    data['lookup_det_value'] = this.lookupDetValue;
    if (this.lookupDetHierarchical != null) {
      data['lookup_det_hierarchical'] =
          this.lookupDetHierarchical!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LookupDetHierarchical {
  int? lookupDetHierId;
  String? lookupDetHierValue;
  String? lookupDetHierDescEn;
  String? lookupDetHierDescRg;
  Null? lookupDetHierParentId;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lookup_det_hier_id'] = this.lookupDetHierId;
    data['lookup_det_hier_value'] = this.lookupDetHierValue;
    data['lookup_det_hier_desc_en'] = this.lookupDetHierDescEn;
    data['lookup_det_hier_desc_rg'] = this.lookupDetHierDescRg;
    data['lookup_det_hier_parent_id'] = this.lookupDetHierParentId;
    data['status'] = this.status;
    return data;
  }
}
