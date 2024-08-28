class DashboardFilterCountResponse {
  int? statusCode;
  String? path;
  String? dateTime;
  DashboardFilterCountDetails? details;

  DashboardFilterCountResponse(
      {this.statusCode, this.path, this.dateTime, this.details});

  DashboardFilterCountResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    path = json['path'];
    dateTime = json['dateTime'];
    details = json['details'] != null
        ? DashboardFilterCountDetails.fromJson(json['details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['path'] = path;
    data['dateTime'] = dateTime;
    if (details != null) {
      data['details'] = details!.toJson();
    }
    return data;
  }
}

class DashboardFilterCountDetails {
  int? totalTreatedPatients;
  int? totalPatients;
  int? totalReferredPatients;
  int? totalCampConduct;

  DashboardFilterCountDetails(
      {this.totalTreatedPatients,
      this.totalPatients,
      this.totalReferredPatients,
      this.totalCampConduct});

  DashboardFilterCountDetails.fromJson(Map<String, dynamic> json) {
    totalTreatedPatients = json['total_treated_patients'];
    totalPatients = json['total_patients'];
    totalReferredPatients = json['total_referred_patients'];
    totalCampConduct = json['total_camp_conduct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_treated_patients'] = totalTreatedPatients;
    data['total_patients'] = totalPatients;
    data['total_referred_patients'] = totalReferredPatients;
    data['total_camp_conduct'] = totalCampConduct;
    return data;
  }
}
