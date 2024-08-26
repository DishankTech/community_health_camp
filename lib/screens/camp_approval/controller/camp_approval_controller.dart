import 'dart:convert';

import 'package:community_health_app/core/utilities/api_urls.dart';
import 'package:community_health_app/core/utilities/cust_toast.dart';
import 'package:community_health_app/screens/camp_approval/camp_approval.dart';
import 'package:community_health_app/screens/camp_approval/model/camp_approval_details/CampApprovalDetailsModel.dart';
import 'package:community_health_app/screens/camp_approval/model/camp_approval_list/camp_approval_data.dart';
import 'package:community_health_app/screens/camp_approval/model/camp_approval_list/camp_approval_list_model.dart';
import 'package:community_health_app/screens/camp_approval/model/save_camp_approval_req/SaveCampApprovalDetails.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';


class CampApprovalController extends GetxController {
  static const pageSize = 10;

  late PagingController<int, CampApprovalData> pagingController;

  bool isLoading = false;

  CampApprovalListModel? campApprovalData;

  List<CampApprovalData> campApprovalList = [];

  bool hasInternet = true;

  CampApprovalDetailsModel? campApprovalDetailsModel;

  SaveCampApprovalDetails saveCampApprovalReqModel = SaveCampApprovalDetails();

  fetchPage(int pageKey) async {
    try {
      List<CampApprovalData> newItems = await fetchCampApproval(pageKey, pageSize);
      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        // int nextPageKey = pageKey + newItems.length;
        int nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  fetchCampApproval(pageKey, pageSize) async {
    isLoading = true;

    // Make the API call here

    var url = (ApiConstants.baseUrl + ApiConstants.campCreationList);
    // var requestBody = {"page": currentPage, "per_page": 4};
    var requestBody = {
      "total_pages": 0,
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
    campApprovalList.clear();
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      campApprovalData = CampApprovalListModel.fromJson(data);
      if (campApprovalData?.details != null) {
        campApprovalList.addAll(campApprovalData!.details?.data ?? []);
      }
      isLoading = false;
      update();
      return campApprovalList;
    }
  }

  getCampDetails(id) async {
    isLoading = true;
    final uri = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.campCreationDetails}/$id');

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };


    final response = await http.post(uri, headers: headers, body: null);
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      final data = json.decode(response.body);
      // if (data['status'] == 'Success') {
      isLoading = false;
      campApprovalDetailsModel = CampApprovalDetailsModel.fromJson(data);

      update();
    } else if (response.statusCode == 401) {
      isLoading = false;

    } else {
      isLoading = false;

      throw Exception('Failed search');
    }
    update();
  }

  saveCampApprovalDetails() async {
    isLoading = true;
    final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.saveCampApprovalDetails);

    String jsonbody = json.encode(saveCampApprovalReqModel);
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
      Get.to(CampApprovalScreen());

      // } else {
      //   isLoading = false;
      //   CustomMessage.toast("Save Failed");
      //   Get.back();
      // }

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

}
