class StakeholderResponseModel {
  int? statusCode;
  String? message;
  String? path;
  String? dateTime;
  Details? details;

  StakeholderResponseModel(
      {this.statusCode, this.message, this.path, this.dateTime, this.details});

  StakeholderResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    path = json['path'];
    dateTime = json['dateTime'];
    details =
        json['details'] != null ? new Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = statusCode;
    data['message'] = message;
    data['path'] = path;
    data['dateTime'] = dateTime;
    if (details != null) {
      data['details'] = details!.toJson();
    }
    return data;
  }
}

class Details {
  int? totalPages;
  int? page;
  int? totalCount;
  int? perPage;
  List<Data>? data;

  Details(
      {this.totalPages, this.page, this.totalCount, this.perPage, this.data});

  Details.fromJson(Map<String, dynamic> json) {
    totalPages = json['total_pages'];
    page = json['page'];
    totalCount = json['total_count'];
    perPage = json['per_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_pages'] = totalPages;
    data['page'] = page;
    data['total_count'] = totalCount;
    data['per_page'] = perPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? stakeholderMasterId;
  int? lookupDetHierIdStakeholderType1;
  String? stakeholderNameEn;
  String? contactNumber;
  String? contactPersonName;
  String? emailId;
  int? lookupDetHierIdCountry;
  int? lookupDetHierIdState;
  int? lookupDetHierIdDistrict;
  int? lookupDetHierIdTaluka;
  int? lookupDetHierIdCity;
  int? lookupDetIdDivision;
  String? pinCode;
  String? address1;
  String? address2;
  int? numberOfBed;
  int? lookupDetHierIdStakeholderSubType2;
  String? stakeholderNameRg;
  String? countryDescEn;
  String? countryDescRg;
  String? stateDescEn;
  String? stateDescRg;
  String? districtDescEn;
  String? districtDescRg;
  String? talukaDescEn;
  String? talukaDescRg;
  String? cityDescEn;
  String? cityDescRg;
  String? stakeholderType1En;
  String? stakeholderType1Rg;
  String? stakeholderSubType2En;
  String? stakeholderSubType2Rg;
  int? status;

  Data(
      {this.stakeholderMasterId,
      this.lookupDetHierIdStakeholderType1,
      this.stakeholderNameEn,
      this.contactNumber,
      this.contactPersonName,
      this.emailId,
      this.lookupDetHierIdCountry,
      this.lookupDetHierIdState,
      this.lookupDetHierIdDistrict,
      this.lookupDetHierIdTaluka,
      this.lookupDetHierIdCity,
      this.lookupDetIdDivision,
      this.pinCode,
      this.address1,
      this.address2,
      this.numberOfBed,
      this.lookupDetHierIdStakeholderSubType2,
      this.stakeholderNameRg,
      this.countryDescEn,
      this.countryDescRg,
      this.stateDescEn,
      this.stateDescRg,
      this.districtDescEn,
      this.districtDescRg,
      this.talukaDescEn,
      this.talukaDescRg,
      this.cityDescEn,
      this.cityDescRg,
      this.stakeholderType1En,
      this.stakeholderType1Rg,
      this.stakeholderSubType2En,
      this.stakeholderSubType2Rg,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    stakeholderMasterId = json['stakeholder_master_id'];
    lookupDetHierIdStakeholderType1 =
        json['lookup_det_hier_id_stakeholder_type1'];
    stakeholderNameEn = json['stakeholder_name_en'];
    contactNumber = json['contact_number'];
    contactPersonName = json['contact_person_name'];
    emailId = json['email_id'];
    lookupDetHierIdCountry = json['lookup_det_hier_id_country'];
    lookupDetHierIdState = json['lookup_det_hier_id_state'];
    lookupDetHierIdDistrict = json['lookup_det_hier_id_district'];
    lookupDetHierIdTaluka = json['lookup_det_hier_id_taluka'];
    lookupDetHierIdCity = json['lookup_det_hier_id_city'];
    lookupDetIdDivision = json['lookup_det_id_division'];
    pinCode = json['pin_code'];
    address1 = json['address1'];
    address2 = json['address2'];
    numberOfBed = json['number_of_bed'];
    lookupDetHierIdStakeholderSubType2 =
        json['lookup_det_hier_id_stakeholder_sub_type2'];
    stakeholderNameRg = json['stakeholder_name_rg'];
    countryDescEn = json['country_desc_en'];
    countryDescRg = json['country_desc_rg'];
    stateDescEn = json['state_desc_en'];
    stateDescRg = json['state_desc_rg'];
    districtDescEn = json['district_desc_en'];
    districtDescRg = json['district_desc_rg'];
    talukaDescEn = json['taluka_desc_en'];
    talukaDescRg = json['taluka_desc_rg'];
    cityDescEn = json['city_desc_en'];
    cityDescRg = json['city_desc_rg'];
    stakeholderType1En = json['stakeholder_type1_en'];
    stakeholderType1Rg = json['stakeholder_type1_rg'];
    stakeholderSubType2En = json['stakeholder_sub_type2_en'];
    stakeholderSubType2Rg = json['stakeholder_sub_type2_rg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stakeholder_master_id'] = stakeholderMasterId;
    data['lookup_det_hier_id_stakeholder_type1'] =
        lookupDetHierIdStakeholderType1;
    data['stakeholder_name_en'] = stakeholderNameEn;
    data['contact_number'] = contactNumber;
    data['contact_person_name'] = contactPersonName;
    data['email_id'] = emailId;
    data['lookup_det_hier_id_country'] = lookupDetHierIdCountry;
    data['lookup_det_hier_id_state'] = lookupDetHierIdState;
    data['lookup_det_hier_id_district'] = lookupDetHierIdDistrict;
    data['lookup_det_hier_id_taluka'] = lookupDetHierIdTaluka;
    data['lookup_det_hier_id_city'] = lookupDetHierIdCity;
    data['lookup_det_id_division'] = lookupDetIdDivision;
    data['pin_code'] = pinCode;
    data['address1'] = address1;
    data['address2'] = address2;
    data['number_of_bed'] = numberOfBed;
    data['lookup_det_hier_id_stakeholder_sub_type2'] =
        lookupDetHierIdStakeholderSubType2;
    data['stakeholder_name_rg'] = stakeholderNameRg;
    data['country_desc_en'] = countryDescEn;
    data['country_desc_rg'] = countryDescRg;
    data['state_desc_en'] = stateDescEn;
    data['state_desc_rg'] = stateDescRg;
    data['district_desc_en'] = districtDescEn;
    data['district_desc_rg'] = districtDescRg;
    data['taluka_desc_en'] = talukaDescEn;
    data['taluka_desc_rg'] = talukaDescRg;
    data['city_desc_en'] = cityDescEn;
    data['city_desc_rg'] = cityDescRg;
    data['stakeholder_type1_en'] = stakeholderType1En;
    data['stakeholder_type1_rg'] = stakeholderType1Rg;
    data['stakeholder_sub_type2_en'] = stakeholderSubType2En;
    data['stakeholder_sub_type2_rg'] = stakeholderSubType2Rg;
    data['status'] = status;
    return data;
  }
}
