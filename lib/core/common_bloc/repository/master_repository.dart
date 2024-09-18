import 'dart:convert';

import 'package:community_health_app/core/utilities/api_urls.dart';
import 'package:community_health_app/core/utilities/network_call.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class MasterDataRepository {
  IOClient ioClient = IOClient(ByPassCert().httpClient);

  Future<http.Response> getPrefix() async {

    return await ioClient
        .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kGetPrefix}'));
  }

  Future<http.Response> getUnitNameList() async {
    return await ioClient.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kGetUnitNameList}'));
  }

  Future<http.Response> getViralLoadStatus() async {
    return await ioClient.get(Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.kGetViralLoadStatus}'));
  }

  Future<http.Response> getStakeHolderById(int payload) async {
    return await ioClient.post(
      Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.kGetStakeholdrBId}/$payload'),
    );
  }

  Future<http.Response> update(Map payload) async {
    var headers = {'Content-Type': 'application/json'};
    return await ioClient.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kupdateStake}'),
        body: jsonEncode(payload),
        headers: headers);
  }

  Future<http.Response> getIDProofList() async {
    return await ioClient.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kGetIDProofList}'));
  }

  Future<http.Response> getSchemeAdoted() async {
    return await ioClient.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kGetSchemeAdoted}'));
  }

  Future<http.Response> getSlotList(int unitId) async {
    var header = {'Content-Type': 'application/json'};
    return await ioClient.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kGetSlotList}'),
        body: jsonEncode({'unitId': 61}),
        headers: header);
  }

  Future<http.Response> getMaritalStatus() async {
    return await ioClient.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kGetMaritalStatus}'));
  }

  Future<http.Response> getRelation() async {
    return await ioClient
        .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kGetRelation}'));
  }

  Future<http.Response> getDivisionList() async {
    return await ioClient
        .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kGetDivision}'));
  }

  Future<http.Response> getDistrictList() async {
    return await ioClient
        .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kGetDistrict}'));
  }

  Future<http.Response> getStateList() async {
    return await ioClient
        .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kGetState}'));
  }

  Future<http.Response> getTalukaList() async {
    return await ioClient
        .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kGetTaluka}'));
  }

  Future<http.Response> getTownList() async {
    return await ioClient
        .get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kGetTown}'));
  }

  Future<http.Response> getBloodGroup() async {
    return await ioClient.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kGetBloodGroup}'));
  }

  Future<http.Response> getDialysisModeList() async {
    return await ioClient.get(Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.kGetDialysisModeList}'));
  }

  Future<http.Response> getRefferedBy() async {
    return await ioClient.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kGetRefferedBy}'));
  }

  Future<http.Response> GetAddressByPincode(int pincode) async {
    return await ioClient.get(Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.kGetAddressByPincode}?pincode=$pincode'));
  }

  Future<http.Response> getMaster(Map payload) async {
    return await ioClient.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kGetMastersDetCode}'),
        body: jsonEncode(payload),
        headers: {'Content-Type': "application/json"});
  }

  Future<http.Response> getMasterLookupDetId(int payload) async {
    return await ioClient.post(
      Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.kGetMastersLookupDetId}$payload'),
    );
  }

  Future<http.Response> getMasterDesignationType(Map payload) async {
    print(payload);
    return await ioClient.post(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.kGetMasters}'),
        body: jsonEncode(payload),
        headers: {'Content-Type': "application/json", 'Accept': '*/*'});
  }

  Future<http.Response> getCampListDropdown(int payload) async {
    print(payload);
    return await ioClient.post(
      Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.kGetCampListDropdown}$payload'),
    );
  }

  Future<http.Response> getDistrictOnDivision(int payload) async {
    print(payload);

    return await ioClient.post(
      Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.kGetDistrictOnDivision}$payload'),
    );
  }
}
