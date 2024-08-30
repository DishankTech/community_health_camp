class GetUserMasterResponse {
  int? statusCode;
  String? message;
  String? path;
  String? dateTime;
  Details? details;

  GetUserMasterResponse(
      {this.statusCode, this.message, this.path, this.dateTime, this.details});

  GetUserMasterResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    path = json['path'];
    dateTime = json['dateTime'];
    details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  List<UserMasterData>? data;

  Details(
      {this.totalPages, this.page, this.totalCount, this.perPage, this.data});

  Details.fromJson(Map<String, dynamic> json) {
    totalPages = json['total_pages'];
    page = json['page'];
    totalCount = json['total_count'];
    perPage = json['per_page'];
    if (json['data'] != null) {
      data = <UserMasterData>[];
      json['data'].forEach((v) {
        data!.add(UserMasterData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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

class UserMasterData {
  int? userId;
  int? stakeholderMasterId;
  String? fullName;
  String? loginName;
  String? mobileNumber;
  String? emailId;
  String? firstLoginPassReset;
  int? status;
  int? orgId;
  int? lookupDetHierIdStakeholderType1;
  int? lookupDetIdMembertype;
  String? stakeHolderType1En;
  String? stakeHolderType1Rg;
  String? memberTypeEn;
  String? memberTypeRg;
  String? stakeholderNameEn;
  String? stakeholderNameRg;

  UserMasterData(
      {this.userId,
      this.stakeholderMasterId,
      this.fullName,
      this.loginName,
      this.mobileNumber,
      this.emailId,
      this.firstLoginPassReset,
      this.status,
      this.orgId,
      this.lookupDetHierIdStakeholderType1,
      this.lookupDetIdMembertype,
      this.stakeHolderType1En,
      this.stakeHolderType1Rg,
      this.memberTypeEn,
      this.memberTypeRg,
      this.stakeholderNameEn,
      this.stakeholderNameRg});

  UserMasterData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    stakeholderMasterId = json['stakeholder_master_id'];
    fullName = json['full_name'];
    loginName = json['login_name'];
    mobileNumber = json['mobile_number'];
    emailId = json['email_id'];
    firstLoginPassReset = json['first_login_pass_reset'];
    status = json['status'];
    orgId = json['org_id'];
    lookupDetHierIdStakeholderType1 =
        json['lookup_det_hier_id_stakeholder_type1'];
    lookupDetIdMembertype = json['lookup_det_id_membertype'];
    stakeHolderType1En = json['stake_holder_type1_en'];
    stakeHolderType1Rg = json['stake_holder_type1_rg'];
    memberTypeEn = json['member_type_en'];
    memberTypeRg = json['member_type_rg'];
    stakeholderNameEn = json['stakeholder_name_en'];
    stakeholderNameRg = json['stakeholder_name_rg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['stakeholder_master_id'] = this.stakeholderMasterId;
    data['full_name'] = this.fullName;
    data['login_name'] = this.loginName;
    data['mobile_number'] = this.mobileNumber;
    data['email_id'] = this.emailId;
    data['first_login_pass_reset'] = this.firstLoginPassReset;
    data['status'] = this.status;
    data['org_id'] = this.orgId;
    data['lookup_det_hier_id_stakeholder_type1'] =
        this.lookupDetHierIdStakeholderType1;
    data['lookup_det_id_membertype'] = this.lookupDetIdMembertype;
    data['stake_holder_type1_en'] = this.stakeHolderType1En;
    data['stake_holder_type1_rg'] = this.stakeHolderType1Rg;
    data['member_type_en'] = this.memberTypeEn;
    data['member_type_rg'] = this.memberTypeRg;
    data['stakeholder_name_en'] = this.stakeholderNameEn;
    data['stakeholder_name_rg'] = this.stakeholderNameRg;
    return data;
  }
}
