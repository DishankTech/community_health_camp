import 'package:community_health_app/screens/camp_creation/model/save_camp_req/tt_camp_create_det_list.dart';

import 'tt_camp_create.dart';

class SaveCampReqModel {
  SaveCampReqModel({
      this.ttCampCreate, 
      this.ttCampCreateDetList,});

  SaveCampReqModel.fromJson(dynamic json) {
    ttCampCreate = json['tt_camp_create'] != null ? TtCampCreate.fromJson(json['tt_camp_create']) : null;
    if (json['tt_camp_create_det_list'] != null) {
      ttCampCreateDetList = [];
      json['tt_camp_create_det_list'].forEach((v) {
        ttCampCreateDetList?.add(TtCampCreateDetails.fromJson(v));
      });
    }
  }
  TtCampCreate? ttCampCreate;
  List<TtCampCreateDetails>? ttCampCreateDetList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (ttCampCreate != null) {
      map['tt_camp_create'] = ttCampCreate?.toJson();
    }
    if (ttCampCreateDetList != null) {
      map['tt_camp_create_det_list'] = ttCampCreateDetList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}