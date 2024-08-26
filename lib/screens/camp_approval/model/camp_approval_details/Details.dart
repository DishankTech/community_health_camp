import 'package:community_health_app/screens/camp_approval/model/camp_approval_details/TtCampCreateDetList.dart';

import 'TtCampCreate.dart';

class Details {
  Details({
      this.ttCampCreate, 
      this.ttCampCreateDetList,});

  Details.fromJson(dynamic json) {
    ttCampCreate = json['tt_camp_create'] != null ? TtCampCreate.fromJson(json['tt_camp_create']) : null;
    if (json['tt_camp_create_det_list'] != null) {
      ttCampCreateDetList = [];
      json['tt_camp_create_det_list'].forEach((v) {
        ttCampCreateDetList?.add(TtCampCreateDetList.fromJson(v));
      });
    }
  }
  TtCampCreate? ttCampCreate;
  List<TtCampCreateDetList>? ttCampCreateDetList;

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