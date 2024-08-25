import 'dart:convert';

import 'package:community_health_app/core/utilities/api_urls.dart';
import 'package:community_health_app/core/utilities/cust_toast.dart';
import 'package:community_health_app/screens/doctor_desk/model/add_treatment_details/add_treatment_details_model.dart';
import 'package:community_health_app/screens/doctor_desk/model/doctor_desk_data.dart';
import 'package:community_health_app/screens/location_master/model/country/lookup_det_hierarchical.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:http/http.dart' as http;

import '../camp_creation/model/user_list_model/user_list_model.dart';
import '../location_master/model/country/country_model.dart';
import 'model/doctor_desk_list_model.dart';


class DoctorDeskController extends GetxController {
  bool isLoading = false;
  bool hasInternet = true;
  static const pageSize = 10;

  late PagingController<int, DoctorDeskData> pagingController;

  DoctorDeskListModel? doctorDeskModel;
  List<DoctorDeskData>? doctorDesk = [];

  CountryModel? stakeHolderModel;

  TextEditingController userController = TextEditingController();
  int? selectedUserId;
  // LookupDetHierarchical? selectedStakeH;

  TextEditingController symptomController = TextEditingController();
  TextEditingController provisionalDiaController = TextEditingController();
  AddTreatmentDetailsModel addTreatmentDetailsModel = AddTreatmentDetailsModel();

  UserListModel? userList;

  addTreatmentDetails() async {
    isLoading = true;
    final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.addTreatmentDetails);

    String jsonbody = json.encode(addTreatmentDetailsModel);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);
    // debugPrint(body.toString());

    final response = await http.post(uri, headers: headers, body: jsonbody);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // addlocationMasterResp = AddLocationMasterResp.fromJson(data);

      // if (addlocationMasterResp!.statusCode == 200) {
      isLoading = false;
      CustomMessage.toast("Save Successfully");
      Get.back();


      update();
    } else if (response.statusCode == 401) {
      isLoading = false;
      CustomMessage.toast("Save Failed");
      Get.back();


    } else {
      isLoading = false;
      CustomMessage.toast("Save Failed");
      Get.back();

      throw Exception('Failed search');
    }
    update();
  }


  fetchPage(int pageKey) async {
    try {
      List<DoctorDeskData> newItems = await fetchCampApproval(pageKey, pageSize);
      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        int nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  fetchCampApproval(pageKey, pageSize) async {
    isLoading = true;

    // Make the API call here

    var url = (ApiConstants.baseUrl + ApiConstants.doctorDeskList);
    // var requestBody = {"page": currentPage, "per_page": 4};
    var requestBody = {
      "total_pages": 1,
      "page": pageKey,
      "total_count": 0,
      "per_page": pageSize,
      "data": ""
    };

    var response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      doctorDeskModel = DoctorDeskListModel.fromJson(data);
      if (doctorDeskModel?.details != null) {
        doctorDesk?.addAll(doctorDeskModel!.details?.data ?? []);
      }
      isLoading = false;
      update();
      return doctorDesk;
    }
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

    final response = await http.post(uri, headers: headers, body: jsonbody);
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

    final response = await http.post(uri, headers: headers, body: null);
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

    } else {
      isLoading = false;

      throw Exception('Failed search');
    }
    update();
  }


}
