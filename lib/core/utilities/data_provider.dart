import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class DataProvider {
  static late SharedPreferences _prefs;
  // DataProvider() {
  //   _prefs = SharedPreferences.getInstance();
  // }

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> storeUserData(String data) async {
    await _prefs.setBool("isLoggedIn", true);
    await _prefs.setString("userData", data);
    print("data stored");
  }

  Future<void> storeUserCredential(String data) async {
    await _prefs.setString("userCredentials", data);
    print("data stored ${data}");
  }

  String? getUserCredentials() {
    String? data = _prefs.getString("userCredentials");
    print('getUserCredentials');
    print(data);
    return data;
  }

  String? getUserData() {
    print('user Data');
    print(_prefs.getString("userData"));
    if (_prefs.getString("userData") != null) {
      return _prefs.getString("userData")!;
    } else {
      return null;
    }
  }

  // LoginResponseModel? getParsedUserData() {
  //   print('user Data');
  //   print(_prefs.getString("userData"));
  //   if (_prefs.getString("userData") != null) {
  //     return LoginResponseModel.fromJson(
  //         jsonDecode(_prefs.getString("userData")!));
  //   } else {
  //     return null;
  //   }
  // }

  bool isLoggedIn() {
    return _prefs.getBool("isLoggedIn") ?? false;
  }

  void clearUserData() async {
    try {
      print("clear data ");
      await _prefs.clear();
      print("data cleared");
      // await _prefs.setBool("isLoggedIn", false);
      // await _prefs.setString("userData", "");
    } catch (e) {
      print(e);
    }
  }

  // String getToken() {
  //   print(getUserData()!.token);
  //   return getUserData()!.token;
  // }

  // String getUserReferralCode() {
  //   print(getUserData()!.data![0].referral!);
  //   return getUserData()!.data![0].referral!;
  // }

  void navigateToSignIn(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(builder: (BuildContext context) => Container()),
      ModalRoute.withName('/'),
    );
  }

  Map<String, dynamic> getRelationData() {
    var res = {
      "code": 0,
      "status": "Success",
      "data": [
        {
          "lookupDetId": 423,
          "lookupDetValue": "HUS",
          "lookupDetDescEn": "HUSBAND",
          "lookupDetDescRg": null,
          "lookupDetParentId": null,
          "lookupDetParentLevel": null,
          "lookupDetParentName": "",
          "lookupDetList": null,
          "ulbId": null
        },
        {
          "lookupDetId": 18,
          "lookupDetValue": "SELF",
          "lookupDetDescEn": "SELF",
          "lookupDetDescRg": null,
          "lookupDetParentId": null,
          "lookupDetParentLevel": null,
          "lookupDetParentName": "",
          "lookupDetList": null,
          "ulbId": null
        },
        {
          "lookupDetId": 12,
          "lookupDetValue": "SON",
          "lookupDetDescEn": "SON",
          "lookupDetDescRg": null,
          "lookupDetParentId": null,
          "lookupDetParentLevel": null,
          "lookupDetParentName": "",
          "lookupDetList": null,
          "ulbId": null
        },
        {
          "lookupDetId": 19,
          "lookupDetValue": "DAO",
          "lookupDetDescEn": "DAUGHTER",
          "lookupDetDescRg": null,
          "lookupDetParentId": null,
          "lookupDetParentLevel": null,
          "lookupDetParentName": "",
          "lookupDetList": null,
          "ulbId": null
        },
        {
          "lookupDetId": 13,
          "lookupDetValue": "FAO",
          "lookupDetDescEn": "FATHER",
          "lookupDetDescRg": null,
          "lookupDetParentId": null,
          "lookupDetParentLevel": null,
          "lookupDetParentName": "",
          "lookupDetList": null,
          "ulbId": null
        },
        {
          "lookupDetId": 14,
          "lookupDetValue": "UNC",
          "lookupDetDescEn": "UNCLE",
          "lookupDetDescRg": null,
          "lookupDetParentId": null,
          "lookupDetParentLevel": null,
          "lookupDetParentName": "",
          "lookupDetList": null,
          "ulbId": null
        },
        {
          "lookupDetId": 15,
          "lookupDetValue": "AUN",
          "lookupDetDescEn": "AUNTY",
          "lookupDetDescRg": null,
          "lookupDetParentId": null,
          "lookupDetParentLevel": null,
          "lookupDetParentName": "",
          "lookupDetList": null,
          "ulbId": null
        },
        {
          "lookupDetId": 16,
          "lookupDetValue": "FRN",
          "lookupDetDescEn": "FRIEND",
          "lookupDetDescRg": null,
          "lookupDetParentId": null,
          "lookupDetParentLevel": null,
          "lookupDetParentName": "",
          "lookupDetList": null,
          "ulbId": null
        },
        {
          "lookupDetId": 17,
          "lookupDetValue": "OTH",
          "lookupDetDescEn": "OTHER",
          "lookupDetDescRg": null,
          "lookupDetParentId": null,
          "lookupDetParentLevel": null,
          "lookupDetParentName": "",
          "lookupDetList": null,
          "ulbId": null
        },
        {
          "lookupDetId": 443,
          "lookupDetValue": "WIO",
          "lookupDetDescEn": "WIFE",
          "lookupDetDescRg": null,
          "lookupDetParentId": null,
          "lookupDetParentLevel": null,
          "lookupDetParentName": "",
          "lookupDetList": null,
          "ulbId": null
        }
      ]
    };

    return res;
  }

  // int? getUserId() {
  //   // print(getUserData()!.data![0].id);
  //   return getUserData()!.data![0].id;
  // }
}
