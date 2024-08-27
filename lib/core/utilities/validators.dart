import 'dart:convert';

import 'package:community_health_app/screens/user_master/bloc/user_master_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class Validators {
  bool isValidEmail(String email) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return null;
    }
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (!emailValid) {
      return "Please enter valid email";
    }

    return null;
  }

  static bool isValidMobileNo(String str) {
    final bool mobileValid = RegExp(r"^(0/91)?[6-9][0-9]{9}").hasMatch(str);
    return mobileValid;
  }

  static isPANValid(String pan) {
    return RegExp(r"[A-Z]{5}[0-9]{4}[A-Z]{1}").hasMatch(pan);
  }

  static String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    }
    if (!isValidMobileNo(value)) {
      return 'Please enter a valid 10-digit Indian mobile number';
    }
    return null; // Validation passed
  }

  static String? validateStakeholderType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Stakeholder Type';
    }

    return null;
  }

  static String? validateStakeholderSubType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Stakeholder Sub Type';
    }

    return null;
  }

  static String? validateDesignationType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Designation/Member Type';
    }

    return null;
  }

  static String? validateStakeholderName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select stakeholder name';
    }

    return null;
  }

  static String? validateSectorType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select Sector Type';
    }

    return null;
  }

  static String? validateFullname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Full Name';
    }

    return null;
  }

  static String? validateLoginName(
      String? value, FormzSubmissionStatus status, String response) {
    if (value == null || value.isEmpty) {
      return 'Please enter Login Name';
    }

    if (status.isSuccess && response.isNotEmpty) {
      var res = jsonDecode(response);
      if (res['details'] == 1) {
        return 'Login Name not available';
      }
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }

    if (value.length < 3) {
      return 'Password must be at least 3 characters long';
    }
    String pattern =
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=])[A-Za-z\d@#$%^&+=]{8,}$';
    RegExp regExp = RegExp(pattern);
    bool isValid = regExp.hasMatch(value);
    if (!isValid) {
      return "Password must include mentioned rules ";
    }
    return null;
  }

  static String? validateConfirmPassword(
      String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please enter password';
    }

    if (confirmPassword != password) {
      return 'Confirm Password does not match with Password';
    }

    return null;
  }
}
