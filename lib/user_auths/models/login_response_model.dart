// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  int? statusCode;
  String? path;
  DateTime? dateTime;
  List<Detail>? details;

  LoginResponseModel({
    this.statusCode,
    this.path,
    this.dateTime,
    this.details,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    statusCode: json["status_code"],
    path: json["path"],
    dateTime: json["dateTime"] == null ? null : DateTime.parse(json["dateTime"]),
    details: json["details"] == null ? [] : List<Detail>.from(json["details"]!.map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "path": path,
    "dateTime": dateTime?.toIso8601String(),
    "details": details == null ? [] : List<dynamic>.from(details!.map((x) => x.toJson())),
  };
}

class Detail {
  String? accessToken;
  String? tokenType;
  User? user;
  List<Menu>? menu;

  Detail({
    this.accessToken,
    this.tokenType,
    this.user,
    this.menu,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    menu: json["menu"] == null ? [] : List<Menu>.from(json["menu"]!.map((x) => Menu.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "token_type": tokenType,
    "user": user?.toJson(),
    "menu": menu == null ? [] : List<dynamic>.from(menu!.map((x) => x.toJson())),
  };
}

class Menu {
  ParentListElement? parentList;
  List<ParentListElement>? childList;

  Menu({
    this.parentList,
    this.childList,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    parentList: json["parent_list"] == null ? null : ParentListElement.fromJson(json["parent_list"]),
    childList: json["child_list"] == null ? [] : List<ParentListElement>.from(json["child_list"]!.map((x) => ParentListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "parent_list": parentList?.toJson(),
    "child_list": childList == null ? [] : List<dynamic>.from(childList!.map((x) => x.toJson())),
  };
}

class ParentListElement {
  int? menuId;
  int? menuParentId;
  String? menuFeatureName;
  String? menuController;
  String? menuControllerMobile;

  ParentListElement({
    this.menuId,
    this.menuParentId,
    this.menuFeatureName,
    this.menuController,
    this.menuControllerMobile,
  });

  factory ParentListElement.fromJson(Map<String, dynamic> json) => ParentListElement(
    menuId: json["menu_id"],
    menuParentId: json["menu_parent_id"],
    menuFeatureName: json["menu_feature_name"],
    menuController: json["menu_controller"],
    menuControllerMobile: json["menu_controller_mobile"],
  );

  Map<String, dynamic> toJson() => {
    "menu_id": menuId,
    "menu_parent_id": menuParentId,
    "menu_feature_name": menuFeatureName,
    "menu_controller": menuController,
    "menu_controller_mobile": menuControllerMobile,
  };
}

class User {
  int? userId;
  String? fullName;
  String? emailId;
  String? firstLoginPassReset;

  User({
    this.userId,
    this.fullName,
    this.emailId,
    this.firstLoginPassReset,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["user_id"],
    fullName: json["fullName"],
    emailId: json["emailId"],
    firstLoginPassReset: json["first_login_pass_reset"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "fullName": fullName,
    "emailId": emailId,
    "first_login_pass_reset": firstLoginPassReset,
  };
}
