class TtCampDashboardRefStakeHoldersDet {
  int? dashboardRefPatientsDetId;
  int? dashboardRefPatientsId;
  int? lookupDetHierIdStakeholderSubType2;
  int stakeholderMasterId;
  int orgId;
  int status;

  TtCampDashboardRefStakeHoldersDet({
    this.dashboardRefPatientsDetId,
    this.dashboardRefPatientsId,
    this.lookupDetHierIdStakeholderSubType2,
    required this.stakeholderMasterId,
    this.orgId = 1,
    this.status = 1,
  });

  // Factory method to create an instance from JSON
  factory TtCampDashboardRefStakeHoldersDet.fromJson(Map<String, dynamic> json) {
    return TtCampDashboardRefStakeHoldersDet(
      dashboardRefPatientsDetId: json['dashboard_ref_patients_det_id'],
      dashboardRefPatientsId: json['dashboard_ref_patients_id'],
      lookupDetHierIdStakeholderSubType2: json['lookup_det_hier_id_stakeholder_sub_type2'],
      stakeholderMasterId: int.parse(json['stakeholder_master_id'].toString()),
      orgId: json['org_id'] ?? 1,
      status: json['status'] ?? 1,
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'dashboard_ref_patients_det_id': dashboardRefPatientsDetId,
      'dashboard_ref_patients_id': dashboardRefPatientsId,
      'lookup_det_hier_id_stakeholder_sub_type2': lookupDetHierIdStakeholderSubType2,
      'stakeholder_master_id': stakeholderMasterId,
      'org_id': orgId,
      'status': status,
    };
  }
}
