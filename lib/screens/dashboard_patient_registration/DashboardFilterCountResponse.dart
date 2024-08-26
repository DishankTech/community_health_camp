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
        ? new DashboardFilterCountDetails.fromJson(json['details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['path'] = this.path;
    data['dateTime'] = this.dateTime;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_treated_patients'] = this.totalTreatedPatients;
    data['total_patients'] = this.totalPatients;
    data['total_referred_patients'] = this.totalReferredPatients;
    data['total_camp_conduct'] = this.totalCampConduct;
    return data;
  }
}
