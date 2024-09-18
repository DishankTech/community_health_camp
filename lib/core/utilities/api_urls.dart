class ApiConstants {
  /// dev url
  // static String baseUrl = "http://210.89.42.117:8085/api";

  /// replica url
  // static String baseUrl = "http://210.89.42.117:8084/api";

  ///Prod url
  static String baseUrl = "https://api.communityhealthcamp.in/api";
  // static String baseUrl = "http://103.251.94.7/api";

  static const String getDivision = "/common/lookup/lookupCode";
  static const String getAllAddress = "/common/lookup/lookupDetCode";
  static const String getAllSubLocation =
      "/common/lookup/lookupDetHier/parent-id";
  static const String getLocationDetails =
      "/administrator/masters/get-location-master-by-id";
  static const String getSearchedData =
      "/administrator/masters/location-master-search-details";
  static const String getSearchedDataDocDesk =
      "/administrator/masters/patient-master-search-details";
  static const String getPatientById =
      "/administrator/masters/get-patient-master-by-id";
  static const String getSearchedCampApprovalData =
      "/administrator/camp/camp-creation-master-search-details";

  static const String saveLocationMaster =
      "/administrator/masters/add/location-master";
  static const String locationList =
      "/administrator/masters/all-location-master-pagination";
  static const String updateLocation =
      "/administrator/masters/update/location-master";
  static const String getLocationName =
      "/administrator/masters/dropdown/location-list";
  static const String getLocationList =
      "/profile/account/user-id-wise/dist-taluka-city/location-camp";
  static const String useList = "/profile/account/dropdown/user-list";
  static const String saveCampCreation = "/administrator/camp/add/camp-details";
  static const String userCreation = "/profile/account/new/";
  static const String campApprovalList =
      "/administrator/camp/all-camp-approval-details-pagination";
  static const String campApprovalDetails =
      "/administrator/camp/camp-approval-district-details";
  static const String saveCampApprovalDetails =
      "/administrator/camp/add/camp-district-approval-details";
  static const String doctorDeskList =
      "/administrator/camp/all-doctor-desk-details-pagination";
  static const String doctorDeskPatientList =
      "/administrator/masters/all-patient-master-pagination";
  static const String addTreatmentDetails =
      "/administrator/camp/add/doctor-desk-details";
  static const String campCreationList =
      "/administrator/camp/all-camp-details-pagination";
  static const String campCreationDetails =
      "/administrator/camp/camp-request-details";
  static const String getStakeholderName =
      "/administrator/masters/dropdown/stake-holder-list-by-district";
  static const String generateCampNumber =
      "/administrator/camp/generate-camp-number";
  static const String referTo =
      "/administrator/masters/dropdown/stake-holder-by-sub-type-list";
  static const String updatePatient =
      "/administrator/masters/update/patient-master";




  static const String kGetPrefix = "/getallpatienttitles";
  static const String kGetUnitNameList = "/getUnitNameList";
  static const String kGetViralLoadStatus = "/getHaemodialysisProcedureTypeList";
  static const String kGetIDProofList = "/getLookupDetList";
  static const String kGetSchemeAdoted = "/getPatientTypeList";
  static const String kGetSlotList = "/getSlotList";
  static const String kGetMaritalStatus = "/getMaritalStatus";
  static const String kGetRelation = "/getRelation";
  static const String kGetDivision = "/getDivisionList";
  static const String kGetDistrict = "/getDistrictList";
  static const String kGetState = "/getStateList";
  static const String kGetTaluka = "/getTalukaList";
  static const String kGetTown = "/getTownList";
  static const String kGetBloodGroup = "/getBloodGroup";
  static const String kGetRefferedBy = "/getRefferedBy";
  static const String kGetDialysisModeList = "/getDialysisModeList";
  static const String kGetAddressByPincode = "/dropdown/getdetailsUsingPincode";
  static const String kGetStakeholdrBId =
      "/administrator/masters/get-stake-holder-master-by-id";

  static const String userLogin = "/public/account/login";
  static const String userResetPassword = "/profile/account/update/user-password-reset";
  static const String kCreateUser = "/profile/account/new/";
  static const String kUpdateUser = "/profile/account/update/user-account-details";
  static const String kLoginNameValidation =
      "/profile/account/get/login-name-validation/";
  static const String kGetAllUsers = "/profile/account/all-user-details-pagination";
  static const String kPatientRegistration = "/administrator/masters/add/patient-master";
  static const String kGetAllPatients =
      "/administrator/masters/all-patient-master-pagination";
  static const String kGetMasters = "/common/lookup/lookupCode";
  static const String kGetMastersDetCode = "/common/lookup/lookupDetCode";
  static const String kGetMastersLookupDetId = "/common/lookup/lookupDetHier/parent-id/";
  static const String kGetDistrictOnDivision = "/common/get/district-by-division/";
  static const String kGetCampListDropdown =
      "/administrator/camp/dropdown/camp-date-list/";
  static const String kSearchPatient =
      "/administrator/masters/patient-master-search-details";

// Stakeholder
  static const String kAddStakeholder = "/administrator/masters/add/stake-holder-master";
  static const String kupdateStake = "/administrator/masters/update/stake-holder-master";
  static const String kGetAllStakeholders =
      "/administrator/masters/all-stake-holder-master-pagination";
  static const String kGetStakeholderName =
      "/administrator/masters/dropdown/stake-holder-list/";
//Dashboard
  static const String kGetCount = "/administrator/masters/get/filter/count";
  static const String kGetDateWiseDistrictCount =
      "/administrator/masters/get/district-wise-camp-by-date/count";

  static const String kGetExcelData = "/administrator/masters/download-excel/";
  static const String kDistrictWisePatientCount =
      "/administrator/masters/get/district-wise-patient/count";

}
