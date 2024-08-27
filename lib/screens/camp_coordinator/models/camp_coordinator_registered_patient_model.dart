class CampCoordRegisteredPatientModel {
  String name;
  String mobile;
  String referredTo;
  String? referredToId;
  // String? campDashboardId;

  CampCoordRegisteredPatientModel({ required this.name,required this.mobile, required this.referredTo,required this.referredToId});

  // Convert a CampCoordRegisteredPatientModel object to a Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mobile': mobile,
      'referredTo': referredTo,
      'referredToId': referredToId,
    };
  }

  // Create a CampCoordRegisteredPatientModel object from a Map
  factory CampCoordRegisteredPatientModel.fromJson(Map<String, dynamic> json) {
    return CampCoordRegisteredPatientModel(
      name: json['name'],
      mobile: json['mobile'],
      referredTo: json['referredTo'],
      referredToId: json['referredToId'],
    );
  }



}
