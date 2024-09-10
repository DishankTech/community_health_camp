

class LocationListModel {
  LocationListModel({
      this.statusCode, 
      this.message, 
      this.path, 
      this.dateTime, 
      this.details,});

  LocationListModel.fromJson(dynamic json) {
    statusCode = json['status_code'];
    message = json['message'];
    path = json['path'];
    dateTime = json['dateTime'];
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details?.add(LocationDetails.fromJson(v));
      });
    }
  }
  int? statusCode;
  String? message;
  String? path;
  String? dateTime;
  List<LocationDetails>? details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status_code'] = statusCode;
    map['message'] = message;
    map['path'] = path;
    map['dateTime'] = dateTime;
    if (details != null) {
      map['details'] = details?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


class LocationDetails {
  LocationDetails({
    this.userId,
    this.locationMasterId,
    this.locationName,
    this.lookupDetHierIdDistrict,
    this.lookupDetHierIdTaluka,
    this.lookupDetHierIdCity,
    this.campCreateRequestId,
    this.propCampDate,});

  LocationDetails.fromJson(dynamic json) {
    userId = json['user_id'];
    locationMasterId = json['location_master_id'];
    locationName = json['location_name'];
    lookupDetHierIdDistrict = json['lookup_det_hier_id_district'];
    lookupDetHierIdTaluka = json['lookup_det_hier_id_taluka'];
    lookupDetHierIdCity = json['lookup_det_hier_id_city'];
    campCreateRequestId = json['camp_create_request_id'];
    propCampDate = json['prop_camp_date'];
  }
  int? userId;
  int? locationMasterId;
  String? locationName;
  int? lookupDetHierIdDistrict;
  int? lookupDetHierIdTaluka;
  int? lookupDetHierIdCity;
  int? campCreateRequestId;
  String? propCampDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['location_master_id'] = locationMasterId;
    map['location_name'] = locationName;
    map['lookup_det_hier_id_district'] = lookupDetHierIdDistrict;
    map['lookup_det_hier_id_taluka'] = lookupDetHierIdTaluka;
    map['lookup_det_hier_id_city'] = lookupDetHierIdCity;
    map['camp_create_request_id'] = campCreateRequestId;
    map['prop_camp_date'] = propCampDate;
    return map;
  }

}