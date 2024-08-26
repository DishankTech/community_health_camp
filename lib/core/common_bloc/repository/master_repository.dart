import 'dart:convert';

import 'package:community_health_app/core/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:community_health_app/core/common_bloc/bloc/master_data_bloc.dart';
import 'package:community_health_app/core/constants/network_constant.dart';

class MasterDataRepository {
  Future<http.Response> getPrefix() async {
    return await http.get(Uri.parse('$kBaseUrl$kGetPrefix'));
  }

  Future<http.Response> getUnitNameList() async {
    return await http.get(Uri.parse('$kBaseUrl$kGetUnitNameList'));
  }

  Future<http.Response> getViralLoadStatus() async {
    return await http.get(Uri.parse('$kBaseUrl$kGetViralLoadStatus'));
  }

  Future<http.Response> getIDProofList() async {
    return await http.get(Uri.parse('$kBaseUrl$kGetIDProofList'));
  }

  Future<http.Response> getSchemeAdoted() async {
    return await http.get(Uri.parse('$kBaseUrl$kGetSchemeAdoted'));
  }

  Future<http.Response> getSlotList(int unitId) async {
    var header = {'Content-Type': 'application/json'};
    return await http.post(Uri.parse('$kBaseUrl$kGetSlotList'),
        body: jsonEncode({'unitId': 61}), headers: header);
  }

  Future<http.Response> getMaritalStatus() async {
    return await http.get(Uri.parse('$kBaseUrl$kGetMaritalStatus'));
  }

  Future<http.Response> getRelation() async {
    return await http.get(Uri.parse('$kBaseUrl$kGetRelation'));
  }

  Future<http.Response> getDivisionList() async {
    return await http.get(Uri.parse('$kBaseUrl$kGetDivision'));
  }

  Future<http.Response> getDistrictList() async {
    return await http.get(Uri.parse('$kBaseUrl$kGetDistrict'));
  }

  Future<http.Response> getStateList() async {
    return await http.get(Uri.parse('$kBaseUrl$kGetState'));
  }

  Future<http.Response> getTalukaList() async {
    return await http.get(Uri.parse('$kBaseUrl$kGetTaluka'));
  }

  Future<http.Response> getTownList() async {
    return await http.get(Uri.parse('$kBaseUrl$kGetTown'));
  }

  Future<http.Response> getBloodGroup() async {
    return await http.get(Uri.parse('$kBaseUrl$kGetBloodGroup'));
  }

  Future<http.Response> getDialysisModeList() async {
    return await http.get(Uri.parse('$kBaseUrl$kGetDialysisModeList'));
  }

  Future<http.Response> getRefferedBy() async {
    return await http.get(Uri.parse('$kBaseUrl$kGetRefferedBy'));
  }

  Future<http.Response> GetAddressByPincode(int pincode) async {
    return await http
        .get(Uri.parse('$kBaseUrl1$kGetAddressByPincode?pincode=$pincode'));
  }

  Future<http.Response> getMaster(Map payload) async {
    return await http.post(Uri.parse('$kBaseUrl$kGetMastersDetCode'),
        body: jsonEncode(payload),
        headers: {'Content-Type': "application/json"});
  }

  Future<http.Response> getMasterLookupDetId(int payload) async {
    return await http.post(
      Uri.parse('$kBaseUrl$kGetMastersLookupDetId$payload'),
    );
  }

  Future<http.Response> getMasterDesignationType(Map payload) async {
    print(payload);
    return await http.post(Uri.parse('$kBaseUrl$kGetMasters'),
        body: jsonEncode(payload),
        headers: {'Content-Type': "application/json", 'Accept': '*/*'});
  }

  Future<http.Response> getCampListDropdown(int payload) async {
    print(payload);
    return await http.post(
      Uri.parse('$kBaseUrl$kGetCampListDropdown$payload'),
    );
  }

  Future<http.Response> getDistrictOnDivision(int payload) async {
    print(payload);
    return await http.post(
      Uri.parse(
          'http://210.89.42.117:8085/api/common/get/district-by-division/$payload'),
    );
  }
}
