import 'dart:convert';
import 'dart:io';

import 'package:community_health_app/core/utilities/api_urls.dart';
import 'package:community_health_app/core/utilities/cust_toast.dart';
import 'package:community_health_app/core/utilities/network_call.dart';
import 'package:community_health_app/screens/location_master/location_master_list.dart';
import 'package:community_health_app/screens/location_master/model/add_location_mast_resp/add_location_master_resp.dart';
import 'package:community_health_app/screens/location_master/model/country/country_model.dart';
import 'package:community_health_app/screens/location_master/model/country/lookup_det_hierarchical.dart';
import 'package:community_health_app/screens/location_master/model/location_details/location_details_model.dart';
import 'package:community_health_app/screens/location_master/model/location_master_list/location_list_data.dart';
import 'package:community_health_app/screens/location_master/model/location_master_list/location_master_list.dart';
import 'package:community_health_app/screens/location_master/model/search/search_data_model.dart';
import 'package:community_health_app/screens/location_master/model/sub_location_model/sub_location_details.dart';
import 'package:community_health_app/screens/location_master/model/sub_location_model/sub_location_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/io_client.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../model/division/division_model.dart';

class LocationMasterController extends GetxController {
  TextEditingController countryController = TextEditingController();
  String? selectedCountryVal;
  LookupDetHierarchical? selectedCountry;
  SubLocationDetails? selectedState;
  String? selectedStateVal;
  String? selectedDistVal;
  SubLocationDetails? selectedDist;
  String? selectedTalukaVal;
  SubLocationDetails? selectedTaluka;
  String? selectedCityVal;
  SubLocationDetails? selectedCity;

  bool hasInternet = true;
  bool isSearch = false;
  bool isLoading = false;

  TextEditingController stateController = TextEditingController();

  TextEditingController distController = TextEditingController();

  TextEditingController talukaController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController locationName = TextEditingController();

  TextEditingController address2 = TextEditingController();

  TextEditingController address1 = TextEditingController();

  TextEditingController emailId = TextEditingController();

  TextEditingController contactPerson = TextEditingController();
  TextEditingController searchController = TextEditingController();

  TextEditingController contactNo = TextEditingController();
  IOClient ioClient = IOClient(ByPassCert().httpClient);

  String? status;

  DivisionModel? divisinModel;

  CountryModel? countryModel;

  SubLocationModel? stateModel;
  LocationDetailsModel? locationDetailsModel;
  SearchDataModel? searchedDataModel;
  SubLocationModel? distModel;
  SubLocationModel? talukaModel;
  SubLocationModel? cityModel;

  AddLocationMasterResp? addlocationMasterResp;

  List<LocationListData> locations = [];

  LocationMasterListModel? locationListModel;

  static const pageSize = 10;
  late PagingController<int, LocationListData> pagingController;

  fetchPage(int pageKey) async {
    try {
      List<LocationListData> newItems = await fetchLocation(pageKey, pageSize);
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

  fetchLocation(pageKey, pageSize) async {
    isLoading = true;



    var url = (ApiConstants.baseUrl + ApiConstants.locationList);
    // var requestBody = {"page": currentPage, "per_page": 4};
    var requestBody = {
      "total_pages": 0,
      "page": pageKey,
      "total_count": 0,
      "per_page": pageSize,
      "data": ""
    };

    var response = await ioClient.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(requestBody),
    );
    locations.clear();
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      locationListModel = LocationMasterListModel.fromJson(data);

      if (locationListModel?.details != null) {
        locations.addAll(locationListModel!.details!.data ?? []);
      }

      isLoading = false;
      update();
      return locations;
    }
  }

  getLocationDetails(id) async {


    isLoading = true;
    final uri = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.getLocationDetails}/$id');

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
      locationDetailsModel = LocationDetailsModel.fromJson(data);
      locationName.text = locationDetailsModel?.details?.locationName ?? "";
      contactNo.text = locationDetailsModel?.details?.contactNumber ?? "";
      contactPerson.text =
          locationDetailsModel?.details?.contactPersonName ?? "";
      emailId.text = locationDetailsModel?.details?.emailId ?? "";
      address1.text = locationDetailsModel?.details?.address1 ?? "";
      address2.text = locationDetailsModel?.details?.address2 ?? "";

      await getCountry(true);
      if (locationDetailsModel?.details?.lookupDetHierIdCountry != null) {
        await getState(
            locationDetailsModel?.details?.lookupDetHierIdCountry, true);
      }
      if (locationDetailsModel?.details?.lookupDetHierIdState != null) {
        await getDist(
            locationDetailsModel?.details?.lookupDetHierIdState, true);
      }

      if (locationDetailsModel?.details?.lookupDetHierIdDistrict != null) {
        await getTaluka(
            locationDetailsModel?.details?.lookupDetHierIdDistrict, true);
      }
      if (locationDetailsModel?.details?.lookupDetHierIdTaluka != null) {
        await getCity(
            locationDetailsModel?.details?.lookupDetHierIdTaluka, true);
      }
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

  getSearchedData(searchText) async {
    isLoading = true;
    final uri = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.getSearchedData}/$searchText');

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
      searchedDataModel = SearchDataModel.fromJson(data);

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

  updateLocationMaster(locationMasterid) async {
    isLoading = true;
    final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.updateLocation);

    final Map<String, dynamic> body = {
      "location_master_id": locationMasterid,
      "location_name": locationName.text,
      "contact_number": contactNo.text,
      "contact_person_name": contactPerson.text,
      "email_id": emailId.text,
      "address1": address1.text,
      "address2": address2.text,
      "lookup_det_hier_id_country": selectedCountry?.lookupDetHierId,
      "lookup_det_hier_id_state": selectedState?.lookupDetHierId,
      "lookup_det_hier_id_district": selectedDist?.lookupDetHierId,
      "lookup_det_hier_id_taluka": selectedTaluka?.lookupDetHierId,
      "lookup_det_hier_id_city": selectedCity?.lookupDetHierId,
      "lookup_det_id_division": null,
      "org_id": 1,
      "status": 1
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
      final data = json.decode(response.body);
      addlocationMasterResp = AddLocationMasterResp.fromJson(data);

      if (addlocationMasterResp!.statusCode == 200) {
        isLoading = false;
        CustomMessage.toast("Save Successfully");
        // Get.back();
        // await fetchPage(1);
        Get.to(const LocationMasterList());
      } else {
        isLoading = false;
        CustomMessage.toast("Save Failed");
        Get.back();
      }

      update();
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

  saveLocationMaster() async {
    isLoading = true;
    final uri =
        Uri.parse(ApiConstants.baseUrl + ApiConstants.saveLocationMaster);

    final Map<String, dynamic> body = {
      "location_name": locationName.text,
      "contact_number": contactNo.text,
      "contact_person_name": contactPerson.text,
      "email_id": emailId.text,
      "address1": address1.text,
      "address2": address2.text,
      "lookup_det_hier_id_country": selectedCountry?.lookupDetHierId,
      "lookup_det_hier_id_state": selectedState?.lookupDetHierId,
      "lookup_det_hier_id_district": selectedDist?.lookupDetHierId,
      "lookup_det_hier_id_taluka": selectedTaluka?.lookupDetHierId,
      "lookup_det_hier_id_city": selectedCity?.lookupDetHierId,
      "lookup_det_id_division": null,
      "org_id": selectedCity?.orgId,
      "status": 1
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
      final data = json.decode(response.body);
      addlocationMasterResp = AddLocationMasterResp.fromJson(data);

      if (addlocationMasterResp!.statusCode == 200) {
        isLoading = false;
        CustomMessage.toast("Save Successfully");
        Get.to(const LocationMasterList());
        // await fetchPage(1);
      } else {
        isLoading = false;
        CustomMessage.toast("Save Failed");
        Get.back();
      }

      update();
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

  getCountry(bool? isView) async {
    isLoading = true;
    final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.getAllAddress);
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
      countryModel = CountryModel.fromJson(data);
      debugPrint(countryModel?.details?.first.lookupDetValue ?? "");
      if (isView == true) {
        countryController.text = countryModel?.details?.first
                .lookupDetHierarchical?.first.lookupDetHierDescEn ??
            '';
        selectedCountry =
            countryModel?.details?.first.lookupDetHierarchical?.first;

        selectedCountryVal = countryModel?.details?.first.lookupDetHierarchical
                ?.first.lookupDetHierDescEn ??
            '';
      }
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

  getState(id, bool? isView) async {
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
      stateModel = SubLocationModel.fromJson(data);

      if (isView == true) {
        stateController.text =
            stateModel?.details?.first.lookupDetHierDescEn ?? "";
        selectedState = stateModel?.details?.first;
        selectedStateVal = stateModel?.details?.first.lookupDetHierDescEn ?? "";
      }
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

      // distController.text = distModel?.details?.first.lookupDetHierDescEn ?? "";
      if (isView == true) {
        SubLocationDetails? dist = distModel?.details?.firstWhere((e) =>
            e.lookupDetHierId ==
            locationDetailsModel?.details?.lookupDetHierIdDistrict);
        distController.text = dist?.lookupDetHierDescEn ?? "";
        selectedDist = dist;
        selectedDistVal = dist?.lookupDetHierDescEn ?? "";
      }
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

  getTaluka(id, bool? isView) async {
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
      talukaModel = SubLocationModel.fromJson(data);

      if (isView == true && talukaModel!.details!.isNotEmpty) {
        SubLocationDetails? tal = talukaModel?.details?.firstWhere((e) =>
            e.lookupDetHierId ==
            locationDetailsModel?.details?.lookupDetHierIdTaluka);

        talukaController.text = tal?.lookupDetHierDescEn ?? "";
        selectedTaluka = tal;
        selectedTalukaVal = tal?.lookupDetHierDescEn ?? "";
      }
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

  getCity(id, bool? isView) async {
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
      cityModel = SubLocationModel.fromJson(data);

      if (isView == true && cityModel!.details!.isNotEmpty) {
        SubLocationDetails? city = cityModel?.details?.firstWhere((e) =>
            e.lookupDetHierId ==
            locationDetailsModel?.details?.lookupDetHierIdCity);

        cityController.text = city?.lookupDetHierDescEn ?? "";
        selectedCity = city;
        selectedCityVal = city?.lookupDetHierDescEn ?? '';
      } else {
        cityController.text = "";
      }
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
