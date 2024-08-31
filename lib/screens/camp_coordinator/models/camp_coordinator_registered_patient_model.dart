class CampCoordRegisteredPatientModel {
  String name;
  String mobile;
  // List<Map<String, dynamic>> ttCampDashboardRefPatientsDet_List = [];

  CampCoordRegisteredPatientModel({ required this.name,required this.mobile});

  // Convert a CampCoordRegisteredPatientModel object to a Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mobile': mobile,
      // 'ttCampDashboardRefPatientsDetList':ttCampDashboardRefPatientsDetList,
      // 'referredTo': referredTo,
      // 'referredToId': referredToId,
    };
  }

  // Create a CampCoordRegisteredPatientModel object from a Map
  factory CampCoordRegisteredPatientModel.fromJson(Map<String, dynamic> json) {
    return CampCoordRegisteredPatientModel(
      name: json['name'],
      mobile: json['mobile'],
      // referredTo: json['referredTo'],
      // referredToId: json['referredToId'],
    );
  }



}
