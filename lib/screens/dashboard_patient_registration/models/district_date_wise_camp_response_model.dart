class DistrictDateWiseCampResponseModel {
  int? statusCode;
  String? message;
  String? path;
  String? dateTime;
  List<Details>? details;

  DistrictDateWiseCampResponseModel(
      {this.statusCode, this.message, this.path, this.dateTime, this.details});

  DistrictDateWiseCampResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? lookupDetHierId;
  String? lookupDetHierDescEn;
  int? districtWiseCamp;

  Details(
      {this.lookupDetHierId, this.lookupDetHierDescEn, this.districtWiseCamp});

  Details.fromJson(Map<String, dynamic> json) {
    lookupDetHierId = json['lookup_det_hier_id'];
    lookupDetHierDescEn = json['lookup_det_hier_desc_en'];
    districtWiseCamp = json['district_wise_camp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lookup_det_hier_id'] = this.lookupDetHierId;
    data['lookup_det_hier_desc_en'] = this.lookupDetHierDescEn;
    data['district_wise_camp'] = this.districtWiseCamp;
    return data;
  }
}
