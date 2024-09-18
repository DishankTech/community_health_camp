import 'dart:convert';

import 'package:community_health_app/core/utilities/api_urls.dart';
import 'package:community_health_app/core/utilities/cust_toast.dart';
import 'package:community_health_app/core/utilities/network_call.dart';
import 'package:community_health_app/screens/camp_creation/model/location/location_name_details.dart';
import 'package:community_health_app/screens/camp_creation/model/member_type/member_lookup_det.dart';
import 'package:community_health_app/screens/camp_creation/model/member_type/member_type_model.dart';
import 'package:community_health_app/screens/camp_creation/model/save_camp_req/save_camp_req_model.dart';
import 'package:community_health_app/screens/camp_creation/model/stakeholder_name/stake_holder_name_model.dart';
import 'package:community_health_app/screens/camp_creation/model/stakeholder_name/stakeholder_details.dart';
import 'package:community_health_app/screens/camp_creation/model/user_list_model/user_details.dart';
import 'package:community_health_app/screens/camp_creation/model/user_list_model/user_list_model.dart';
import 'package:community_health_app/screens/dashboard/dashboard.dart';
import 'package:community_health_app/screens/location_master/model/country/lookup_det_hierarchical.dart';
import 'package:community_health_app/screens/location_master/model/sub_location_model/sub_location_details.dart';
import 'package:community_health_app/screens/patient_registration/models/location_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import '../location_master/model/country/country_model.dart';
import '../location_master/model/sub_location_model/sub_location_model.dart';
import 'model/location/location_name_model.dart';
import 'model/save_camp_req/tt_camp_create_det_list.dart';

class CampCreationController extends GetxController {
  List<TtCampCreateDetails> campCreationCardList = [];

  TextEditingController locationNameController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();

  TextEditingController userNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  UserDetails? selectedUser;
  TextEditingController distNameController = TextEditingController();
  TextEditingController talukaController = TextEditingController();

  TextEditingController designationType = TextEditingController();

  TextEditingController stakeHolderController = TextEditingController();

  TextEditingController countryCodeController = TextEditingController();
  TextEditingController stakeholderSubTypeId = TextEditingController();
  IOClient ioClient = IOClient(ByPassCert().httpClient);

  // Map<String, dynamic>? selectedCountryCode;

  // TextEditingController mobileController = TextEditingController();
  // TextEditingController memberTypeController = TextEditingController();
  TextEditingController stakHolderUserCreation = TextEditingController();
  TextEditingController loginNameUserCreation = TextEditingController();
  String? errorMobile;
  String? errorLocation;
  String? errorDistrict;
  String? errorTaluka;
  String? errorStakeHolder;
  String? errorDate;
  String? errorDesignation;
  String? errorFullName;
  String? errorCountryCode;
  String? errorUserName;
  String? errorCampId;
  bool isLoading = false;

  String? status;

  LocationNameModel? locationNameModel;
  LocationListModel? locationModel;

  bool hasInternet = true;

  String? selectedLocationVal;

  LocationNameDetails? selectedLocation;
  LocationDetails? selectedLocationN;

  SubLocationModel? distModel;

  SubLocationDetails? selectedDist;

  String? selectedDistVal;

  CountryModel? stakeHolderModel;
  StakeHolderNameModel? stakeHolderNameModel;

  String? selectedStakeHVal;

  LookupDetHierarchical? selectedStakeH;
  StakeHolderDetails? selectedStakeHName;
  LookupDetHierarchical? selectedStakeHolder;

  MemberTypeModel? memberTypeModel;

  UserListModel? userList;
  SaveCampReqModel saveCampReqModel = SaveCampReqModel();

  List<MemberLookupDet?> memberTypeList = [];

  String? campNumber;
  String? username;
  String? campId;

  int? userId;

  saveCampCreation() async {
    isLoading = true;

    final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.saveCampCreation);

    String jsonbody = json.encode(saveCampReqModel);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // debugPrint(body.toString());

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      isLoading = false;
      return true;
      // update();
    } else if (response.statusCode == 401) {
      isLoading = false;
      Get.off(const DashboardScreen());

      status = "Something went wrong";
    } else {
      isLoading = false;
      CustomMessage.toast("Save Failed");
      Get.off(const DashboardScreen());

      throw Exception('Failed search');
    }
    update();
  }

  userCreation(loginName, fullName, mobileNo, memberTypeId) async {
    isLoading = true;
    final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.userCreation);

    var body = {
      "user_id": null,
      "stakeholder_master_id": selectedStakeHName?.stakeholderMasterId,
      // "stakeholder_master_id": selectedStakeHolder?.lookupDetHierId,
      "full_name": fullName,
      "login_name": loginName,
      "passwords": "Pass@123",
      "mobile_number": mobileNo,
      "email_id": "",
      "first_login_pass_reset": "Y",
      "status": 1,
      "org_id": 1,
      "lookup_det_hier_id_stakeholder_type1": null,
      "lookup_det_id_membertype": memberTypeId.toString()
    };

    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // debugPrint(body.toString());

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      if (data['status_code'] == 200) {
        userId = data['uniquerId'];
        isLoading = false;
        // CustomMessage.toast("Save Successfully");
        // Get.back();

        // await getUserList();

        update();
      }
    } else if (response.statusCode == 401) {
      isLoading = false;
      CustomMessage.toast("Save Failed");
      Get.back();

      status = "Something went wrong";
    } else {
      isLoading = false;
      CustomMessage.toast("Save Failed");
      Get.back();

      throw Exception('Failed search');
    }
    update();
  }

  getLocationName() async {
    isLoading = true;
    final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.getLocationName);
    final Map<String, dynamic> body = {
      "lookup_det_code_list1": [
        {"lookup_det_code": "CRY"}
      ]
    };

    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    debugPrint(body.toString());

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      final data = json.decode(response.body);
      // if (data['status'] == 'Success') {
      isLoading = false;
      locationNameModel = LocationNameModel.fromJson(data);

      update();
    } else if (response.statusCode == 401) {
      isLoading = false;

      status = "Something went wrong";
    } else {
      isLoading = false;

      throw Exception('Failed search');
    }
    update();
  }




  getLocation(id) async {
    isLoading = true;
    final uri =
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getLocationList}/$id');

    // final Map<String, dynamic> body = {
    //   "lookup_det_code_list1": [
    //     {"lookup_det_code": "CRY"}
    //   ]
    // };
    //
    // String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // debugPrint(body.toString());

    final response = await ioClient.post(uri, headers: headers, body: null);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      final data = json.decode(response.body);
      // if (data['status'] == 'Success') {
      isLoading = false;
      locationModel = LocationListModel.fromJson(data);

      update();
    } else if (response.statusCode == 401) {
      isLoading = false;

      status = "Something went wrong";
    } else {
      isLoading = false;

      throw Exception('Failed search');
    }
    update();
  }

  getUserCode() async {
    isLoading = true;
    final uri =
        Uri.parse(ApiConstants.baseUrl + ApiConstants.generateCampNumber);

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.post(uri, headers: headers, body: null);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      final data = json.decode(response.body);
      // if (data['status'] == 'Success') {
      isLoading = false;
      campNumber = data['details'];
      campId = campNumber;
      username = "C${campNumber!}";
      update();
    } else if (response.statusCode == 401) {
      isLoading = false;

      status = "Something went wrong";
    } else {
      isLoading = false;

      throw Exception('Failed search');
    }
    update();
  }

  getMemberType() async {
    isLoading = true;
    final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.getDivision);
    final Map<String, dynamic> body = {
      "lookup_code_list1": [
        {"lookup_code": "MTY"}
      ]
    };

    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    debugPrint(body.toString());
    memberTypeList.clear();
    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      final data = json.decode(response.body);
      // if (data['status'] == 'Success') {
      isLoading = false;
      memberTypeModel = MemberTypeModel.fromJson(data);

      memberTypeList.add(memberTypeModel?.details!.first.lookupDet
          ?.firstWhere((e) => e.lookupDetDescEn == "Co-ordinators"));

      update();
    } else if (response.statusCode == 401) {
      isLoading = false;

      status = "Something went wrong";
    } else {
      isLoading = false;

      throw Exception('Failed search');
    }
    update();
  }

  getDist(id, bool? isView) async {
    isLoading = true;
    final uri = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.getAllSubLocation}/$id');

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.post(uri, headers: headers, body: null);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      final data = json.decode(response.body);
      // if (data['status'] == 'Success') {
      isLoading = false;
      distModel = SubLocationModel.fromJson(data);

      distNameController.text =
          distModel?.details?.first.lookupDetHierDescEn ?? "";

      update();
    } else if (response.statusCode == 401) {
      isLoading = false;

      status = "Something went wrong";
    } else {
      isLoading = false;

      throw Exception('Failed search');
    }
    update();
  }

  getUserList() async {
    isLoading = true;
    final uri = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.useList}');

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response = await ioClient.post(uri, headers: headers, body: null);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      final data = json.decode(response.body);
      // if (data['status'] == 'Success') {
      isLoading = false;
      userList = UserListModel.fromJson(data);

      update();
    } else if (response.statusCode == 401) {
      isLoading = false;

      status = "Something went wrong";
    } else {
      isLoading = false;

      throw Exception('Failed search');
    }
    update();
  }

  getStakHoldeName(id) async {
    isLoading = true;
    final uri = Uri.parse(
        "${ApiConstants.baseUrl}${ApiConstants.getStakeholderName}/$id");
    final Map<String, dynamic> body = {
      "lookup_det_code_list1": [
        {"lookup_det_code": "STY"}
      ]
    };

    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    debugPrint(body.toString());

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      final data = json.decode(response.body);
      // if (data['status'] == 'Success') {
      isLoading = false;
      stakeHolderNameModel = StakeHolderNameModel.fromJson(data);

      update();
    } else if (response.statusCode == 401) {
      isLoading = false;

      status = "Something went wrong";
    } else {
      isLoading = false;

      throw Exception('Failed search');
    }
    update();
  }

  getStakHolder() async {
    isLoading = true;
    final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.getAllAddress);
    final Map<String, dynamic> body = {
      "lookup_det_code_list1": [
        {"lookup_det_code": "STY"}
      ]
    };

    String jsonbody = json.encode(body);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    debugPrint(body.toString());

    final response = await ioClient.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      final data = json.decode(response.body);
      // if (data['status'] == 'Success') {
      isLoading = false;
      stakeHolderModel = CountryModel.fromJson(data);

      update();
    } else if (response.statusCode == 401) {
      isLoading = false;

      status = "Something went wrong";
    } else {
      isLoading = false;

      throw Exception('Failed search');
    }
    update();
  }
}
