import 'dart:convert';

import 'package:community_health_app/core/common_widgets/app_button.dart';
import 'package:community_health_app/core/common_widgets/app_round_textfield.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/network_constant.dart';
import '../../core/utilities/data_provider.dart';
import '../../core/utilities/size_config.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController _newpasswordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final String passwordPattern =
      r'^(?=.*[A-Za-z])(?=.*[\d@!#$_])[A-Za-z\d@!#$_]{8,}$'; //special character not necessary

  bool _obscureText_new = true;
  bool _obscureText_confirm = true;
  bool _isLoading = false;
  String errorMessage = "";

  @override
  void initState() {
    _newpasswordController.text = '';
    _confirmpasswordController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                "assets/bgimg.png",
                fit: BoxFit.cover,
              )),
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Text(
                      "Reset Password ",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      child: Text(
                        "Set the password to your account so you can login and access all the features",
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: AppRoundTextField(
                        label: Text('New password'),
                        hint: "Enter new password",
                        obscureText: _obscureText_new,
                        controller: _newpasswordController,
                        suffix: IconButton(
                          icon: Icon(
                            _obscureText_new
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText_new =
                                  !_obscureText_new; // Toggle password visibility
                            });
                          },
                        ),
                        validators: (value) {
                          if (value == null || value.isEmpty) {
                            return 'New Password is required';
                          }
                          final regex = RegExp(passwordPattern);
                          if (!regex.hasMatch(value)) {
                            return 'The password must be at least 8 characters long, contain at least one alphabet, one number or one special character (@, !, #, \$, _).';
                          }
                          return null; // Validation passed
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: AppRoundTextField(
                        controller: _confirmpasswordController,
                        obscureText: _obscureText_confirm,
                        label: Text("Confirm Password"),
                        hint: "Enter Confirm Password",
                        errorText: errorMessage,
                        validators: (value) {
                          if (value == null || value.isEmpty) {
                            return errorMessage =
                                'Confirm Password is required';
                          }
                          final regex = RegExp(passwordPattern);
                          if (!regex.hasMatch(value)) {
                            return errorMessage =
                                'The password must be at least 8 characters long, \ncontain at least one alphabet, one number or one special character (@, !, #, \$, _).';
                          }
                          return null; // Validation passed
                        },
                        suffix: IconButton(
                          icon: Icon(
                            _obscureText_confirm
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText_confirm =
                                  !_obscureText_confirm; // Toggle password visibility
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppButton(
                          mWidth: SizeConfig.screenWidth * 0.4,
                          title: 'Submit',
                          icon: Icon(
                            Icons.arrow_right_alt_rounded,
                            color: Colors.white,
                          ),
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              if (_newpasswordController.text.toString() ==
                                  _confirmpasswordController.text.toString()) {
                                /*  ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Validation Successfull',),backgroundColor: Colors.green,),
                                      );*/

                                resetPasswordApiCall();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Passwords does not match'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        AppButton(
                          title: 'Cancel',
                          mWidth: SizeConfig.screenWidth * 0.4,
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.loginScreen);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> resetPasswordApiCall() async {
    setState(() {
      _isLoading = true; // Show loader
    });

    int? userId = DataProvider().getUserCredentials();
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(kBaseUrl + userResetPassword));
    request.body = json.encode({
      "user_id": userId,
      "password": _confirmpasswordController.text.toString().trim()
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    http.Response finalResponse = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;

        // Hide loader
      });

      var responseBody = json.decode(finalResponse.body);
      // Get the status code as a string
      String statusCode = responseBody['status_code'].toString();
      if (statusCode == "200") {
        DataProvider().storeUserData(finalResponse.body);

        // LoginResponseModel loginResponseModel =
        //     LoginResponseModel.fromJson(responseBody);
        // List<Detail>? detailsList = loginResponseModel.details;
        // print(detailsList);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Password Updated',
            ),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context)
            .pushNamedAndRemoveUntil(AppRoutes.loginScreen, (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Login Failed',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }

      //navigate to dashboard page
    } else {
      setState(() {
        _isLoading = false; // Hide loader
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Something went wrong',
          ),
          backgroundColor: Colors.red,
        ),
      );
      print(response.reasonPhrase);
    }
  }
}
