class ApiConstants {

  static String baseUrl = "http://210.89.42.117:8085/api";

  static const String getDivision = "/common/lookup/lookupCode";
  static const String getAllAddress = "/common/lookup/lookupDetCode";
  static const String getAllSubLocation = "/common/lookup/lookupDetHier/parent-id";
  static const String getLocationDetails = "/administrator/masters/get-location-master-by-id";
  static const String getSearchedData = "/administrator/masters/location-master-search-details";
  static const String getSearchedDataDocDesk = "/administrator/masters/patient-master-search-details";
  static const String getSearchedCampApprovalData = "/administrator/camp/camp-creation-master-search-details";

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
  static const String doctorDeskPatientList = "/administrator/masters/all-patient-master-pagination";
  static const String addTreatmentDetails = "/administrator/camp/add/doctor-desk-details";
  static const String campCreationList = "/administrator/camp/all-camp-details-pagination";
  static const String campCreationDetails = "/administrator/camp/camp-request-details";
  static const String getStakeholderName = "/administrator/masters/dropdown/stake-holder-list-by-district";
  static const String generateCampNumber = "/administrator/camp/generate-camp-number";
  static const String referTo = "/administrator/masters/dropdown/stake-holder-by-sub-type-list";

}
