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
  List<StakeholderMasterData>? data;

  Details(
      {this.totalPages, this.page, this.totalCount, this.perPage, this.data});

  Details.fromJson(Map<String, dynamic> json) {
    totalPages = json['total_pages'];
    page = json['page'];
    totalCount = json['total_count'];
    perPage = json['per_page'];
    if (json['data'] != null) {
      data = <StakeholderMasterData>[];
      json['data'].forEach((v) {
        data!.add(new StakeholderMasterData.fromJson(v));
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

class StakeholderMasterData {
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

  StakeholderMasterData(
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

  StakeholderMasterData.fromJson(Map<String, dynamic> json) {
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
    data['stakeholder_master_id'] = this.stakeholderMasterId;
    data['lookup_det_hier_id_stakeholder_type1'] =
        this.lookupDetHierIdStakeholderType1;
    data['stakeholder_name_en'] = this.stakeholderNameEn;
    data['contact_number'] = this.contactNumber;
    data['contact_person_name'] = this.contactPersonName;
    data['email_id'] = this.emailId;
    data['lookup_det_hier_id_country'] = this.lookupDetHierIdCountry;
    data['lookup_det_hier_id_state'] = this.lookupDetHierIdState;
    data['lookup_det_hier_id_district'] = this.lookupDetHierIdDistrict;
    data['lookup_det_hier_id_taluka'] = this.lookupDetHierIdTaluka;
    data['lookup_det_hier_id_city'] = this.lookupDetHierIdCity;
    data['lookup_det_id_division'] = this.lookupDetIdDivision;
    data['pin_code'] = this.pinCode;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['number_of_bed'] = this.numberOfBed;
    data['lookup_det_hier_id_stakeholder_sub_type2'] =
        this.lookupDetHierIdStakeholderSubType2;
    data['stakeholder_name_rg'] = this.stakeholderNameRg;
    data['country_desc_en'] = this.countryDescEn;
    data['country_desc_rg'] = this.countryDescRg;
    data['state_desc_en'] = this.stateDescEn;
    data['state_desc_rg'] = this.stateDescRg;
    data['district_desc_en'] = this.districtDescEn;
    data['district_desc_rg'] = this.districtDescRg;
    data['taluka_desc_en'] = this.talukaDescEn;
    data['taluka_desc_rg'] = this.talukaDescRg;
    data['city_desc_en'] = this.cityDescEn;
    data['city_desc_rg'] = this.cityDescRg;
    data['stakeholder_type1_en'] = this.stakeholderType1En;
    data['stakeholder_type1_rg'] = this.stakeholderType1Rg;
    data['stakeholder_sub_type2_en'] = this.stakeholderSubType2En;
    data['stakeholder_sub_type2_rg'] = this.stakeholderSubType2Rg;
    data['status'] = this.status;
    return data;
  }
}
