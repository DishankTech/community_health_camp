class MasterDistrictOnDivisionResponseModel {
  int? statusCode;
  String? message;
  String? path;
  String? dateTime;
  List<Details>? details;

  MasterDistrictOnDivisionResponseModel(
      {this.statusCode, this.message, this.path, this.dateTime, this.details});

  MasterDistrictOnDivisionResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? divisionId;
  int? lookupDetIdDiv;
  int? lookupDetHierIdDist;
  String? districtDescEn;
  String? districtDescRg;
  String? divisionDescEn;
  String? divisionDescRg;
  int? status;

  Details(
      {this.divisionId,
      this.lookupDetIdDiv,
      this.lookupDetHierIdDist,
      this.districtDescEn,
      this.districtDescRg,
      this.divisionDescEn,
      this.divisionDescRg,
      this.status});

  Details.fromJson(Map<String, dynamic> json) {
    divisionId = json['division_id'];
    lookupDetIdDiv = json['lookup_det_id_div'];
    lookupDetHierIdDist = json['lookup_det_hier_id_dist'];
    districtDescEn = json['district_desc_en'];
    districtDescRg = json['district_desc_rg'];
    divisionDescEn = json['division_desc_en'];
    divisionDescRg = json['division_desc_rg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['division_id'] = this.divisionId;
    data['lookup_det_id_div'] = this.lookupDetIdDiv;
    data['lookup_det_hier_id_dist'] = this.lookupDetHierIdDist;
    data['district_desc_en'] = this.districtDescEn;
    data['district_desc_rg'] = this.districtDescRg;
    data['division_desc_en'] = this.divisionDescEn;
    data['division_desc_rg'] = this.divisionDescRg;
    data['status'] = this.status;
    return data;
  }
}
