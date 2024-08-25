
import 'package:community_health_app/screens/camp_approval/model/save_camp_approval_req/ttdistirct_camp_approval.dart';
import 'package:community_health_app/screens/camp_approval/model/save_camp_approval_req/ttdistirct_camp_approval_det_list.dart';

class SaveCampApprovalReqModel {
  SaveCampApprovalReqModel({
      this.ttDistirctCampApproval, 
      this.ttDistirctCampApprovalDetList,});

  SaveCampApprovalReqModel.fromJson(dynamic json) {
    ttDistirctCampApproval = json['tt_distirct_camp_approval'] != null ? TtDistirctCampApproval.fromJson(json['tt_distirct_camp_approval']) : null;
    if (json['tt_distirct_camp_approval_det_list'] != null) {
      ttDistirctCampApprovalDetList = [];
      json['tt_distirct_camp_approval_det_list'].forEach((v) {
        ttDistirctCampApprovalDetList?.add(TtDistirctCampApprovalDetList.fromJson(v));
      });
    }
  }
  TtDistirctCampApproval? ttDistirctCampApproval;
  List<TtDistirctCampApprovalDetList>? ttDistirctCampApprovalDetList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (ttDistirctCampApproval != null) {
      map['tt_distirct_camp_approval'] = ttDistirctCampApproval?.toJson();
    }
    if (ttDistirctCampApprovalDetList != null) {
      map['tt_distirct_camp_approval_det_list'] = ttDistirctCampApprovalDetList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}