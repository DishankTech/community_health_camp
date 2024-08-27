class MasterLookupDetHierResponseModel {
  int? statusCode;
  String? message;
  String? path;
  String? dateTime;
  List<LookupDetHierDetails>? details;

  MasterLookupDetHierResponseModel(
      {this.statusCode, this.message, this.path, this.dateTime, this.details});

  MasterLookupDetHierResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    path = json['path'];
    dateTime = json['dateTime'];
    if (json['details'] != null) {
      details = <LookupDetHierDetails>[];
      json['details'].forEach((v) {
        details!.add(new LookupDetHierDetails.fromJson(v));
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

class LookupDetHierDetails {
  int? lookupDetHierId;
  int? lookupDetId;
  int? orgId;
  String? lookupDetHierValue;
  String? lookupDetHierDescEn;
  String? lookupDetHierDescRg;
  int? lookupDetHierParentId;
  int? status;
  int? lookupDetHierOrderBy;

  LookupDetHierDetails(
      {this.lookupDetHierId,
      this.lookupDetId,
      this.orgId,
      this.lookupDetHierValue,
      this.lookupDetHierDescEn,
      this.lookupDetHierDescRg,
      this.lookupDetHierParentId,
      this.status,
      this.lookupDetHierOrderBy});

  LookupDetHierDetails.fromJson(Map<String, dynamic> json) {
    lookupDetHierId = json['lookup_det_hier_id'];
    lookupDetId = json['lookup_det_id'];
    orgId = json['org_id'];
    lookupDetHierValue = json['lookup_det_hier_value'];
    lookupDetHierDescEn = json['lookup_det_hier_desc_en'];
    lookupDetHierDescRg = json['lookup_det_hier_desc_rg'];
    lookupDetHierParentId = json['lookup_det_hier_parent_id'];
    status = json['status'];
    lookupDetHierOrderBy = json['lookup_det_hier_order_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lookup_det_hier_id'] = lookupDetHierId;
    data['lookup_det_id'] = lookupDetId;
    data['org_id'] = orgId;
    data['lookup_det_hier_value'] = lookupDetHierValue;
    data['lookup_det_hier_desc_en'] = lookupDetHierDescEn;
    data['lookup_det_hier_desc_rg'] = lookupDetHierDescRg;
    data['lookup_det_hier_parent_id'] = lookupDetHierParentId;
    data['status'] = status;
    data['lookup_det_hier_order_by'] = lookupDetHierOrderBy;
    return data;
  }
}
