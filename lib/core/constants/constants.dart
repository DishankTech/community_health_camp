import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFF27A0C);
const kPrimaryDarkColor = Color(0xFF429EBD);
Color kPrimaryLightColor = kPrimaryColor.withOpacity(0.5);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF27A9E3), Color(0xFF07B259)],
);
LinearGradient kGradientHomeMenu = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF27A9E3).withOpacity(0.1),
    Color(0xFF07B259).withOpacity(0.1)
  ],
);
const kScaffoldColor = Color(0xFFFFFFFF);
const kSecondaryColor = Color(0xFF979797);
const kSecondaryVarientColor = Color(0xFFFFFFFF);
const kTextOutlineColor = Color(0xFFC7C4C4);
const kTextColor = Color(0xFF484848);
const kListTitleTextColor = Color(0xFF3D3D3D);
const kTextBlackColor = Color(0xFF000000);
const kBlackColor = Color(0xFF000000);
const kTextOpacityColor = Color(0xB3E4E4E4);
const kTextDarkBlueColor = Color(0xFF2C3F6E);
const kWhiteColor = Color(0xFFFFFFFF);
const offWhite = Color(0xFFB1B1B1);
const kHintColor = Color(0xFF2856FB);
//profile
const kActiveBtnColor = Color(0xFF700033);
const kInActiveBtnColor = Color(0xFF970045);
const kActiveBtnBorderColor = Color(0xFFED006C);
const googleButtonColor = Color(0xFFDF4B38);
const appleButtonColor = Color(0xFF232323);
const segmentButtonBorderColor = Color(0xFFB1B1B1);
const kAnimationDuration = Duration(milliseconds: 200);
const kWhatsappColor = Color(0xFF25D366);
const kTelegramColor = Color(0xFF0088cc);
const kFBColor = Color(0xFF1877F2);
const kInstaColor = Color(0xFFcd486b);
const kTextFieldBorder = Color(0xFFE1E1E1);
const kRegistrationBgColor = Color(0xFFF8F8F8);
const kLabelTextColor = Color(0xFF515151);
const kContainerBack = Color(0xFFF5F5F5);

// final headingStyle = TextStyle(
//   fontSize: getProportionateScreenWidth(28),
//   fontWeight: FontWeight.bold,
//   color: Colors.black,
//   height: 1.5,
// );

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

/* Server Config */

const bool isAuthEnable = false;
const bool isBeta = false;
// /* Beta */
// const String kDomain = "http://192.168.1.15:8080/";9226036149
// const String kBaseUrl = 'http://192.168.1.15:8080/api/v1/';

const String kEaseWireBaseURL = "https://wire.easebuzz.in/api/v1/";
const String kVerifyVPA = "beneficiaries/vpa/verify/";
const String kVerifyBankAccountNumber = "beneficiaries/bank_account/verify/";

/// Live Key-7E7B47ADD7 Salt- 0FE4DB7159 */

// const String kDomain = "http://156.67.208.123:8080/";
// const String kBaseUrl = 'http://156.67.208.123:8080/shareshiksha/api/v1/';

const String kMarketTipController = 'market-tips-controller/';
const String kInsertMarketTip = 'insertTip';
const String kGetAllTips = 'getAllTips';

const String kMerchantKey = "20D5N6Q9W3";
const String kSalt = "EA3WLPIQZ9";

const String EASE_BUZZ_WIRE_API_KEY = "7E7B47ADD7";
const String EASE_BUZZ_WIRE_API_SALT = "0FE4DB7159";

// 3 Bank 7 Admin 5 TDS

// ignore: constant_identifier_names
enum VideoType { COURSE, RECORDINGS }

const String kIPOListingController = 'ipo-listing-controller/';
const String kUploadIPO = 'insertIPO';
const String kGetAllIPO = 'getAllIPOs';
const String kDeleteIPO = 'deleteIPO';

const String kAuth = 'auth/';
const String kRegisterUser = 'auth/register';
const String kLogin = 'auth/authenticate';
const String kDeleteUser = 'deleteUser';
const String kUserController = 'user-controller/';
const String kGetUserDetails = 'getUserDetailsById';
const String kUpdateUserWithProfile = 'updateUserWithProfile';
const String kForgotPassword = 'auth/forgotPassword';
const String kUpdateUserDeviceToken = 'updateUserDeviceToken';

const String kBankDetailsController = 'user-bank-details-controller/';
const String kMasterController = 'master-controller/';
const String kStateController = 'state-controller/';
const String kBrokerController = 'broker-controller/';
const String kBannerController = 'banner-controller/';
const String kGetAllBrokers = 'getAllBrokers';
const String kGetAllBanners = 'getBanners';
const String kVideoController = 'video-controller/';
const String kQuizController = 'quiz-controller/';
const String kEPocketController = 'epocket-transaction-controller/';
const String kGetAllVideos = 'video-controller/getAllVideosWithCategory';
const String kGetBrokersVideos = 'getBrokerVideosWithCategoryByBrokerId';
const String kGetAllLiveEvents = 'live-controller/getAllLiveEvents';
const String kGetAllEbooks = 'ebook-controller/getAllEbook';
// const String kGetNews = 'https://newsapi.org/v2/';
const String kGetNews =
    'https://zylalabs.com/api/1839/india+market+news+api/1504/fetch+india+market+news';
const String kNewsOrgAPIKey = '3e851af9f13549a8a73522b0f74561ea';
const String kTopHeadlines = 'top-headlines';
const String kCashfreeBase = 'https://sandbox.cashfree.com/pg/orders';
const String kCashfreeAppID = 'TEST3555565733f01d928bf7605422655553';
const String kIsMobileExist = 'isMobileExists';
const String kSendOTP = 'http://164.52.195.161/API/SendMsg.aspx?';
const String kSendEmailOTP = 'https://eapi.instaalerts.zone/email';
const String kCashfreeSecretKey =
    'TESTeabe26e1c99e353c69eab7acb1ac9866b4201955';

//Subscriptions
const String kSubscriptionController = "subscription-controller/";
const String kGetAllSubscription = "getAllSubscription";
const String kUserReferral = "referral-controller/";
const String kGetAllReferredUsers = "getAllReferredUser";
const String kGetAllAffilatedUserByReferralCode =
    "getAllAffilatedUserByReferralCode";
const String kAddReferredUserToThePosition = "addReferredUserToThePosition";
const String kCreateUserSubscription = "createUserSubscription";
const String kGetUserSubscription = "getUserSubscription";
const String kCreateUserTrial = "createUserTrial";
const String kCreateUserSubscriptionWithoutTransaction =
    "createUserSubscriptionWithoutTransaction";
const String kIsCouponUsed = "isCouponUsed";

//Document Verification
const String kDocumentVerification = "document-verification-controller/";
const String kSendAadhaarOTP = "sendAadhaarOTP";
const String kVerifyAadhaarOTP = "verifyAadhaarOTP";
const String kVerifyPAN = "verifyPAN";

const String kPaymentGatewayController = "payment-gateway-controller/";
const String kInitPayment = "initPayment";
const String kUpdatePGTransaction = "updatePGTransaction";
const String kGetAllTransactionsByUserId = "getAllTransactionsByUserId";

//Quiz
const String kGetQuizForVideo = "getQuizForVideo";

//EPocket
const String kWithdrawalRequest = "withdrawalRequest";
const String kSaveBankDetails = "saveUserBankDetails";
const String kGetBankDetails = "getUserBankDetails";

const String kGetDistrictOnState = "getDistrictOnState";
const String kGetAllState = "getAllStates";

const String kUpdateController = "update-controller/";
const String kCheckUpdate = "checkAppUpdate";

const String kStoryController = "success_story-controller/";
const String kGetAllStories = "getAllStories";

const String kAlgoController = "algo-controller/";
const String kInsertAlgoRequest = "insertAlogUserRequest";
const String kGetAlgoRequest = "getUserRequest";

const String kFreeContentController = "free-content-access-controller/";
const String kInsertFreeContentStatus = "insertFreeContentAccess";
const String kGetUserFreeContentAccessStatus = "getUserFreeContentAccessStatus";
const String kUserReferralIncomeController = "user-referral-income-controller/";
const String kGetUserRewards = "getUserRewards";

const String kMarketingImageController = "marketing-images-controller/";
const String kGetAllMarketingImages = "getAllMarketingImages";

/// API's */
const String kGoogleMapAutocomplete =
    "https://maps.googleapis.com/maps/api/place/autocomplete/json";
