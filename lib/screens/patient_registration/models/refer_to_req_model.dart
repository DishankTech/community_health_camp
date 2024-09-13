import 'package:community_health_app/screens/doctor_desk/model/refred_to/refer_to_details.dart';

class ReferToReqModel {
  ReferToReqModel({
    this.patientReferId,
    this.patientId,
    this.stakeholderMasterId,
    this.lookupDetIdRefDepartment,
    this.lookupDetHierIdStakeholderSubType2,
    this.stakeholderSubTypeTitle,
    this.referToTitle,
    this.referToDeptTitle,
    this.orgId,
    this.status,
    this.isInactive,
  });

  ReferToReqModel.fromJson(dynamic json) {
    patientReferId = json['patient_refer_id'];
    patientId = json['patient_id'];
    stakeholderMasterId = json['stakeholder_master_id'];
    lookupDetIdRefDepartment = json['lookup_det_id_ref_department'];
    lookupDetHierIdStakeholderSubType2 =
        json['lookup_det_hier_id_stakeholder_sub_type2'];
    orgId = json['org_id'];
    status = json['status'];
    isInactive = json['is_inactive'];
  }

  dynamic patientReferId;
  dynamic patientId;
  dynamic stakeholderMasterId;
  dynamic lookupDetIdRefDepartment;
  dynamic lookupDetHierIdStakeholderSubType2;
  String? stakeholderSubTypeTitle;
  String? referToTitle;
  List<ReferToDetails> selectedStakeH = [];
  List<ReferToDetails> stakeHolderMasterList = [];
  String? referToDeptTitle;
  int? orgId;
  int? status;
  dynamic isInactive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['patient_refer_id'] = patientReferId;
    map['patient_id'] = patientId;
    map['stakeholder_master_id'] = stakeholderMasterId;
    map['lookup_det_id_ref_department'] = lookupDetIdRefDepartment;
    map['lookup_det_hier_id_stakeholder_sub_type2'] =
        lookupDetHierIdStakeholderSubType2;
    map['org_id'] = orgId;
    map['status'] = status;
    map['is_inactive'] = isInactive;
    return map;
  }
}
