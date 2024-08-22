import 'dart:convert';

// import 'package:community_health_app/SizeConfig.dart';
import 'package:community_health_app/core/common_widgets/app_button.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/fonts.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:community_health_app/core/utilities/data_provider.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/user_auths/forgotpassword_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;

import '../core/common_widgets/app_round_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  bool _obscureText = true;

  @override
  void initState() {
    _usernameController.text = '';
    _passwordController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                "assets/bgimg.png",
                fit: BoxFit.cover,
              )),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /*SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Image.asset(
                  "assets/loginlogo.png",
                  fit: BoxFit.contain,
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  height: MediaQuery.sizeOf(context).width * 0.4,
                ),
              ),*/
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Community Health Camp ",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "LOGIN",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              _isLoading
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.red,
                        ),
                        Text(
                          'Please wait..',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 30, right: 30),
                          child: AppRoundTextField(
                            controller: _usernameController,
                            onChange: (p0) {},
                            label: RichText(
                              text: const TextSpan(
                                  text: 'Username',
                                  style: TextStyle(
                                    color: kHintColor,
                                  ),
                                  children: [
                                    TextSpan(
                                        text: "*",
                                        style: TextStyle(color: Colors.red))
                                  ]),
                            ),
                            hint: "",
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 30, right: 30),
                          child: AppRoundTextField(
                            obscureText: true,
                            suffix: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText =
                                      !_obscureText; // Toggle password visibility
                                });
                              },
                            ),
                            controller: _passwordController,
                            onChange: (p0) {},
                            label: RichText(
                              text: const TextSpan(
                                  text: 'Password',
                                  style: TextStyle(
                                    color: kHintColor,
                                  ),
                                  children: [
                                    TextSpan(
                                        text: "*",
                                        style: TextStyle(color: Colors.red))
                                  ]),
                            ),
                            hint: "",
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            /*  InkWell(
                      onTap: () {
                        Get.to(const ResetPasswordPage());
                      },
                      child: Container(margin: EdgeInsets.only(left: 30), child: Text("Reset Password "))),*/
                            InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.forgotScreen);
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(right: 30),
                                    child: const Text("Forgot Password ?"))),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        AppButton(
                          mWidth: responsiveWidth(260),
                          mHeight: responsiveHeight(50),
                          iconData: Icon(
                            Icons.arrow_forward,
                            size: responsiveHeight(24),
                            color: Colors.white,
                          ),
                          title: "Login",
                          onTap: () async {
                            Navigator.pushNamed(context, AppRoutes.dashboard);
                            // validateFields();
                          },
                        )
                      ],
                    ),
            ],
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void validateFields() {
    if (_usernameController.value.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Enter Username",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (_passwordController.value.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Enter Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      loginAPI();
    }
  }

  Future<void> loginAPI() async {
    setState(() {
      _isLoading = true; // Show loader
    });

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST',
        Uri.parse('http://210.89.42.117:8085/api/public/account/login'));
    request.body = json.encode({
      "username": _usernameController.text.toString().trim(),
      "password": _passwordController.text.toString().trim()
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
      String details = responseBody['details'].toString();
      String token = responseBody['details'][0]['token'].toString();
      if (statusCode == "200") {
        DataProvider().storeUserData(token);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Login Successfull',
            ),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushNamed(context, AppRoutes.dashboard);
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

class RadiantGradientMask extends StatelessWidget {
  const RadiantGradientMask({
    Key? key,
    required this.child,
    required this.gradient,
  }) : super(key: key);
  final Widget child;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return gradient.createShader(bounds);
      },
      child: child,
    );
  }
}
