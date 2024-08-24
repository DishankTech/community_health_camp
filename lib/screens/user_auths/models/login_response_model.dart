class LoginResponseModel {
  int? statusCode;
  String? path;
  String? dateTime;
  List<Details>? details;

  LoginResponseModel({this.statusCode, this.path, this.dateTime, this.details});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    path = json['path'];
    dateTime = json['dateTime'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status_code'] = statusCode;
    data['path'] = path;
    data['dateTime'] = dateTime;
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String? accessToken;
  String? tokenType;
  User? user;
  List<Menu>? menu;

  Details({this.accessToken, this.tokenType, this.user, this.menu});

  Details.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['menu'] != null) {
      menu = <Menu>[];
      json['menu'].forEach((v) {
        menu!.add(Menu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (menu != null) {
      data['menu'] = menu!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? userId;
  String? fullName;
  String? emailId;
  String? firstLoginPassReset;

  User({this.userId, this.fullName, this.emailId, this.firstLoginPassReset});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fullName = json['fullName'];
    emailId = json['emailId'];
    firstLoginPassReset = json['first_login_pass_reset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['fullName'] = fullName;
    data['emailId'] = emailId;
    data['first_login_pass_reset'] = firstLoginPassReset;
    return data;
  }
}

class Menu {
  ParentList? parentList;
  List<ChildList>? childList;

  Menu({this.parentList, this.childList});

  Menu.fromJson(Map<String, dynamic> json) {
    parentList = json['parent_list'] != null
        ? ParentList.fromJson(json['parent_list'])
        : null;
    if (json['child_list'] != null) {
      childList = <ChildList>[];
      json['child_list'].forEach((v) {
        childList!.add(ChildList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (parentList != null) {
      data['parent_list'] = parentList!.toJson();
    }
    if (childList != null) {
      data['child_list'] = childList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ParentList {
  int? menuId;
  String? menuFeatureName;
  String? menuController;
  String? menuControllerMobile;

  ParentList(
      {this.menuId,
      this.menuFeatureName,
      this.menuController,
      this.menuControllerMobile});

  ParentList.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    menuFeatureName = json['menu_feature_name'];
    menuController = json['menu_controller'];
    menuControllerMobile = json['menu_controller_mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menu_id'] = menuId;
    data['menu_feature_name'] = menuFeatureName;
    data['menu_controller'] = menuController;
    data['menu_controller_mobile'] = menuControllerMobile;
    return data;
  }
}

class ChildList {
  int? menuId;
  int? menuParentId;
  String? menuFeatureName;
  String? menuController;
  String? menuControllerMobile;

  ChildList(
      {this.menuId,
      this.menuParentId,
      this.menuFeatureName,
      this.menuController,
      this.menuControllerMobile});

  ChildList.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    menuParentId = json['menu_parent_id'];
    menuFeatureName = json['menu_feature_name'];
    menuController = json['menu_controller'];
    menuControllerMobile = json['menu_controller_mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menu_id'] = menuId;
    data['menu_parent_id'] = menuParentId;
    data['menu_feature_name'] = menuFeatureName;
    data['menu_controller'] = menuController;
    data['menu_controller_mobile'] = menuControllerMobile;
    return data;
  }
}
