import 'dart:convert';

import 'package:community_health_app/core/utilities/api_urls.dart';
import 'package:community_health_app/core/utilities/cust_toast.dart';
import 'package:community_health_app/screens/doctor_desk/doctor_desk_patients_screen/doctor_desk_patients_screen.dart';
import 'package:community_health_app/screens/doctor_desk/model/add_treatment_details/add_treatment_details_model.dart';
import 'package:community_health_app/screens/doctor_desk/model/disease/disease_model.dart';
import 'package:community_health_app/screens/doctor_desk/model/doctor_desk_data.dart';
import 'package:community_health_app/screens/doctor_desk/model/doctor_desk_details/doc_desk_data.dart';
import 'package:community_health_app/screens/doctor_desk/model/doctor_desk_details/doc_desk_details_list_model.dart';
import 'package:community_health_app/screens/doctor_desk/model/referral/referral_lookup_det.dart';
import 'package:community_health_app/screens/doctor_desk/model/referral/referral_model.dart';
import 'package:community_health_app/screens/doctor_desk/model/refred_to/refer_to_details.dart';
import 'package:community_health_app/screens/doctor_desk/model/refred_to/refer_to_model.dart';
import 'package:community_health_app/screens/doctor_desk/model/search/search__doc_desk_data_model.dart';
import 'package:community_health_app/screens/location_master/model/country/lookup_det_hierarchical.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import '../camp_creation/model/user_list_model/user_list_model.dart';
import '../location_master/model/country/country_model.dart';
import 'model/doctor_desk_list_model.dart';

class DoctorDeskController extends GetxController {
  bool isLoading = false;
  bool hasInternet = true;

  DoctorDeskListModel? doctorDeskModel;
  DocDeskDetailsListModel? doctorDetailsDeskListModel;

  // CountryModel? stakeHolderModel;
  ReferToModel? referToModel;
  CountryModel? stakeHolderTypeModel;

  TextEditingController userController = TextEditingController();
  TextEditingController patientId = TextEditingController();
  TextEditingController stakeHolderController = TextEditingController();
  TextEditingController stakeHolderTypeController = TextEditingController();
  TextEditingController diseasesTypeController = TextEditingController();
  TextEditingController referralService = TextEditingController();
  int? selectedUserId;
  List<ReferToDetails> selectedStakeH = [];
  LookupDetHierarchical? selectedStakeHType;
  LookupDetHierarchical? selectedDiseases;
  List<ReferralLookupDet> selectedReferralSer =[];
  String? selectedStakeHVal;
  String? selectedStakeHTypeVal;
  String? selectedDiseasesVal;
  String? selectedReferralSerVal;
  TextEditingController symptomController = TextEditingController();
  TextEditingController provisionalDiaController = TextEditingController();
  TextEditingController investigationController = TextEditingController();
  TextEditingController treatmentGivenController = TextEditingController();
  AddTreatmentDetailsModel addTreatmentDetailsModel =
      AddTreatmentDetailsModel();
  UserListModel? userList;
  DiseaseModel? diseaseLookupDetHierarchical;
  ReferralModel? referralModel;
  static const pageSize = 10;
  late PagingController<int, DoctorDeskData> pagingController;
  late PagingController<int, DocDeskData> docPagingController;
  List<DoctorDeskData> doctorDesk = [];
  List<DocDeskData> doctorDetailsDesk = [];

  int? campId;

  String? campName;
  String? campLocation;
  String? campDate;
  String? totalPatientCount;

  TextEditingController searchController = TextEditingController();

  bool isSearch = false;

  SearchDocDeskDataModel? searchedDataModel;

  fetchPage(int pageKey) async {
    try {
      List<DoctorDeskData> newItems = await doctorDeskList(pageKey, pageSize);
      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        int nextPageKey = pageKey + 1;
        // int nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  doctorDeskList(pageKey, pageSize) async {
    doctorDesk.clear();

    isLoading = true;

    // Make the API call here

    var url = (ApiConstants.baseUrl + ApiConstants.doctorDeskPatientList);
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

    // doctorDesk.clear();
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      doctorDeskModel = DoctorDeskListModel.fromJson(data);
      final details = doctorDeskModel?.details;
      if (details != null) {
        totalPatientCount = details.totalCount.toString() ?? "0";
        doctorDesk.addAll(doctorDeskModel!.details?.data ?? []);
        if (doctorDesk.isNotEmpty) {
          campId = doctorDesk[0].campCreateRequestId;
          // campName = doctorDesk[0].stakeholderNameEn;
          // campLocation = doctorDesk[0].locationName;
          if (doctorDesk[0].campDate != null) {
            campDate = doctorDesk[0].campDate;
          }
        }
      }
      isLoading = false;
      update();
      return doctorDesk;
    } else {
      isLoading = false;
      update();
      return [];
    }
  }

  fetchPagedoctorDeskDetailsList(int pageKey) async {
    try {
      List<DocDeskData> newItems =
          await doctorDeskDetailsList(pageKey, pageSize);
      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        docPagingController.appendLastPage(newItems);
      } else {
        int nextPageKey = pageKey + 1;
        // int nextPageKey = pageKey + newItems.length;
        docPagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      docPagingController.error = error;
    }
  }

  getSearchedData(searchText) async {
    isLoading = true;
    final uri = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.getSearchedDataDocDesk}/$searchText');

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
      searchedDataModel = SearchDocDeskDataModel.fromJson(data);

      update();
    } else if (response.statusCode == 401) {
      isLoading = false;
    } else {
      isLoading = false;

      throw Exception('Failed search');
    }
    update();
  }

  doctorDeskDetailsList(pageKey, pageSize) async {
    doctorDetailsDesk.clear();

    isLoading = true;

    // Make the API call here

    var url = (ApiConstants.baseUrl + ApiConstants.doctorDeskList);
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

    // doctorDesk.clear();
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      doctorDetailsDeskListModel = DocDeskDetailsListModel.fromJson(data);
      final details = doctorDetailsDeskListModel?.details;
      if (details != null) {
        // totalPatientCount= details.totalCount.toString() ?? "0";
        doctorDetailsDesk
            .addAll(doctorDetailsDeskListModel!.details?.data ?? []);
        // if (doctorDetailsDesk.isNotEmpty) {
        //   campId = doctorDetailsDesk[0].campCreateRequestId;
        //   // campName = doctorDesk[0].stakeholderNameEn;
        //   // campLocation = doctorDesk[0].locationName;
        //   if (doctorDetailsDesk[0].campDate != null) {
        //     campDate = doctorDetailsDesk[0].campDate;
        //   }
        // }
      }
      isLoading = false;
      update();
      return doctorDetailsDesk;
    } else {
      isLoading = false;
      update();
      return [];
    }
  }

  String convertToDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }

  addTreatmentDetails() async {
    isLoading = true;
    final uri =
        Uri.parse(ApiConstants.baseUrl + ApiConstants.addTreatmentDetails);

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
      Get.to(const DoctorDeskPatientsScreen());

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

  getStakHolder() async {
    isLoading = true;
    final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.getAllAddress);
    final Map<String, dynamic> body = {
      "lookup_det_code_list1": [
        {"lookup_det_code": "SUY"}
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
      // stakeHolderModel = CountryModel.fromJson(data);
      stakeHolderTypeModel = CountryModel.fromJson(data);

      update();
    } else if (response.statusCode == 401) {
      isLoading = false;
    } else {
      isLoading = false;

      throw Exception('Failed search');
    }
    update();
  }

  getReferTo(id) async {
    isLoading = true;
    final uri = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.referTo}/$id");

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
      referToModel = ReferToModel.fromJson(data);

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

  getDisease() async {
    isLoading = true;
    final uri =
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getDivision}');
    final Map<String, dynamic> body = {
      "lookup_code_list1": [
        {
          "lookup_code": "DIS"
        }
      ]
    };
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response =
        await http.post(uri, headers: headers, body: json.encode(body));
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      final data = json.decode(response.body);
      // if (data['status'] == 'Success') {
      isLoading = false;
      diseaseLookupDetHierarchical = DiseaseModel.fromJson(data);

      update();
    } else if (response.statusCode == 401) {
      isLoading = false;
    } else {
      isLoading = false;

      throw Exception('Failed search');
    }
    update();
  }

  getReferral() async {
    isLoading = true;
    final uri = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.getDivision}');
    final Map<String, dynamic> body = {
      "lookup_code_list1": [
        {"lookup_code": "REF"}
      ]
    };
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    debugPrint(uri.path);

    final response =
        await http.post(uri, headers: headers, body: json.encode(body));
    debugPrint(response.statusCode.toString());
    debugPrint("response.body : ${response.body}");

    if (response.statusCode == 200) {
      isLoading = false;

      final data = json.decode(response.body);
      // if (data['status'] == 'Success') {
      isLoading = false;
      referralModel = ReferralModel.fromJson(data);

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
