class ApiConstants {

  static String baseUrl = "http://210.89.42.117:8085/api";

  static const String getDivision = "/common/lookup/lookupCode";
  static const String getAllAddress = "/common/lookup/lookupDetCode";
  static const String getAllSubLocation = "/common/lookup/lookupDetHier/parent-id";
  static const String getLocationDetails = "/administrator/masters/get-location-master-by-id";
  static const String saveLocationMaster = "/administrator/masters/add/location-master";
  static const String locationList = "/administrator/masters/all-location-master-pagination";
  static const String updateLocation = "/administrator/masters/update/location-master";
  static const String getLocationName = "/administrator/masters/dropdown/location-list";
  static const String useList = "/profile/account/dropdown/user-list";
  static const String saveCampCreation = "/administrator/camp/add/camp-details";
  static const String userCreation = "/profile/account/new/";
  static const String campApprovalList = "/administrator/camp/all-camp-approval-details-pagination";
  static const String campApprovalDetails = "/administrator/camp/camp-approval-district-details";
  static const String saveCampApprovalDetails = "/administrator/camp/add/camp-district-approval-details";
  static const String doctorDeskList = "/administrator/camp/all-doctor-desk-details-pagination";
  static const String addTreatmentDetails = "/administrator/camp/add/doctor-desk-details";

}
