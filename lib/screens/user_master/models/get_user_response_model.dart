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
      this.lookupDetHierIdStakeholderType1});

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['stakeholder_master_id'] = stakeholderMasterId;
    data['full_name'] = fullName;
    data['login_name'] = loginName;
    data['mobile_number'] = mobileNumber;
    data['email_id'] = emailId;
    data['first_login_pass_reset'] = firstLoginPassReset;
    data['status'] = status;
    data['org_id'] = orgId;
    data['lookup_det_hier_id_stakeholder_type1'] =
        lookupDetHierIdStakeholderType1;
    return data;
  }
}
