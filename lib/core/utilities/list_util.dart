import 'package:community_health_app/screens/doctor_desk/model/disease/disease_lookup_det.dart';
import 'package:community_health_app/screens/doctor_desk/model/refred_to/refer_to_details.dart';

abstract class ListUtil {
  static addIfReferToNotExist(List<ReferToDetails> selectedStakeH, p0) {
    if (!selectedStakeH.any((e) =>
    e.stakeholderMasterId == p0.stakeholderMasterId)) {
      selectedStakeH.add(p0);
    }
  }

  static addIfDiseaseNotExist(List<DiseaseLookupDet> selectedStakeH, p0) {
    if (!selectedStakeH.any((e) => e.lookupDetId == p0.lookupDetId)) {
      selectedStakeH.add(p0);
    }
  }
}