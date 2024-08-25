class RegisteredPatientResponseModel {
  int? statusCode;
  String? message;
  String? path;
  String? dateTime;
  PatientDetails? details;

  RegisteredPatientResponseModel(
      {this.statusCode, this.message, this.path, this.dateTime, this.details});

  RegisteredPatientResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    path = json['path'];
    dateTime = json['dateTime'];
    details = json['details'] != null
        ? new PatientDetails.fromJson(json['details'])
        : null;
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

class PatientDetails {
  int? totalPages;
  int? page;
  int? totalCount;
  int? perPage;
  List<PatientData>? data;

  PatientDetails(
      {this.totalPages, this.page, this.totalCount, this.perPage, this.data});

  PatientDetails.fromJson(Map<String, dynamic> json) {
    totalPages = json['total_pages'];
    page = json['page'];
    totalCount = json['total_count'];
    perPage = json['per_page'];
    if (json['data'] != null) {
      data = <PatientData>[];
      json['data'].forEach((v) {
        data!.add(new PatientData.fromJson(v));
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

class PatientData {
  int? patientId;
  int? campCreateRequestId;
  String? campDate;
  int? userIdRegisterBy;
  String? patientName;
  int? age;
  int? lookupDetIdGender;
  String? contactNumber;
  String? addharCard;
  String? abhaCard;
  int? lookupDetHierIdCountry;
  int? lookupDetHierIdState;
  int? lookupDetHierIdDistrict;
  int? lookupDetHierIdTaluka;
  int? lookupDetHierIdCity;
  int? lookupDetIdDivision;
  String? pinCode;
  int? orgId;
  int? status;

  PatientData(
      {this.patientId,
      this.campCreateRequestId,
      this.campDate,
      this.userIdRegisterBy,
      this.patientName,
      this.age,
      this.lookupDetIdGender,
      this.contactNumber,
      this.addharCard,
      this.abhaCard,
      this.lookupDetHierIdCountry,
      this.lookupDetHierIdState,
      this.lookupDetHierIdDistrict,
      this.lookupDetHierIdTaluka,
      this.lookupDetHierIdCity,
      this.lookupDetIdDivision,
      this.pinCode,
      this.orgId,
      this.status});

  PatientData.fromJson(Map<String, dynamic> json) {
    patientId = json['patient_id'];
    campCreateRequestId = json['camp_create_request_id'];
    campDate = json['camp_date'];
    userIdRegisterBy = json['user_id_register_by'];
    patientName = json['patient_name'];
    age = json['age'];
    lookupDetIdGender = json['lookup_det_id_gender'];
    contactNumber = json['contact_number'];
    addharCard = json['addhar_card'];
    abhaCard = json['abha_card'];
    lookupDetHierIdCountry = json['lookup_det_hier_id_country'];
    lookupDetHierIdState = json['lookup_det_hier_id_state'];
    lookupDetHierIdDistrict = json['lookup_det_hier_id_district'];
    lookupDetHierIdTaluka = json['lookup_det_hier_id_taluka'];
    lookupDetHierIdCity = json['lookup_det_hier_id_city'];
    lookupDetIdDivision = json['lookup_det_id_division'];
    pinCode = json['pin_code'];
    orgId = json['org_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['patient_id'] = patientId;
    data['camp_create_request_id'] = campCreateRequestId;
    data['camp_date'] = campDate;
    data['user_id_register_by'] = userIdRegisterBy;
    data['patient_name'] = patientName;
    data['age'] = age;
    data['lookup_det_id_gender'] = lookupDetIdGender;
    data['contact_number'] = contactNumber;
    data['addhar_card'] = addharCard;
    data['abha_card'] = abhaCard;
    data['lookup_det_hier_id_country'] = lookupDetHierIdCountry;
    data['lookup_det_hier_id_state'] = lookupDetHierIdState;
    data['lookup_det_hier_id_district'] = lookupDetHierIdDistrict;
    data['lookup_det_hier_id_taluka'] = lookupDetHierIdTaluka;
    data['lookup_det_hier_id_city'] = lookupDetHierIdCity;
    data['lookup_det_id_division'] = lookupDetIdDivision;
    data['pin_code'] = pinCode;
    data['org_id'] = orgId;
    data['status'] = status;
    return data;
  }
}
