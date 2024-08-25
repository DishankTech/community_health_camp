class StakeholderNameResponseModel {
  int? statusCode;
  String? message;
  String? path;
  String? dateTime;
  List<StakeholderNameDetails>? details;

  StakeholderNameResponseModel(
      {this.statusCode, this.message, this.path, this.dateTime, this.details});

  StakeholderNameResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    path = json['path'];
    dateTime = json['dateTime'];
    if (json['details'] != null) {
      details = <StakeholderNameDetails>[];
      json['details'].forEach((v) {
        details!.add(new StakeholderNameDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

class StakeholderNameDetails {
  int? stakeholderMasterId;
  String? stakeholderNameEn;
  String? stakeholderNameRg;
  int? lookupDetHierIdDistrict;
  String? lookupDetHierDescEn;
  String? lookupDetHierDescRg;

  StakeholderNameDetails(
      {this.stakeholderMasterId,
      this.stakeholderNameEn,
      this.stakeholderNameRg,
      this.lookupDetHierIdDistrict,
      this.lookupDetHierDescEn,
      this.lookupDetHierDescRg});

  StakeholderNameDetails.fromJson(Map<String, dynamic> json) {
    stakeholderMasterId = json['stakeholder_master_id'];
    stakeholderNameEn = json['stakeholder_name_en'];
    stakeholderNameRg = json['stakeholder_name_rg'];
    lookupDetHierIdDistrict = json['lookup_det_hier_id_district'];
    lookupDetHierDescEn = json['lookup_det_hier_desc_en'];
    lookupDetHierDescRg = json['lookup_det_hier_desc_rg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stakeholder_master_id'] = stakeholderMasterId;
    data['stakeholder_name_en'] = stakeholderNameEn;
    data['stakeholder_name_rg'] = stakeholderNameRg;
    data['lookup_det_hier_id_district'] = lookupDetHierIdDistrict;
    data['lookup_det_hier_desc_en'] = lookupDetHierDescEn;
    data['lookup_det_hier_desc_rg'] = lookupDetHierDescRg;
    return data;
  }
}
