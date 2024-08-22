import 'package:community_health_app/core/common_widgets/app_button.dart';
import 'package:community_health_app/core/common_widgets/app_round_textfield.dart';
import 'package:community_health_app/core/constants/fonts.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/core/utilities/validators.dart';
import 'package:community_health_app/user_auths/enterpin_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../core/constants/constants.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController _mobileNoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final indianMobileNumberRegex = RegExp(r'^[6-9]\d{9}$');

  // bool _obscureText_new = true;

  @override
  void initState() {
    _mobileNoController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          Stack(children: [
            /* Container(
              margin: EdgeInsets.only(top: 30,left: 10),
              child: IconButton(
                color: Colors.white,
                onPressed: () {
                  print('object');
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),*/
            Form(
              key: _formKey,
              child: Stack(children: [
                /* Container(
                    margin: EdgeInsets.only(top: 30, left: 10),
                    width: 50,
                    height: 50,
                    child: Material(
                      color: Colors.transparent, // Use transparent if you don't want a background color
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          print('Back button pressed');
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                    ),
                  ),*/

                SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          const Text(
                            "Forgot Password ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            child: const Text(
                              "Enter your Mobile number for the verification process and we will send you OTP to your Email or Number",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 30, right: 30),
                            child: AppRoundTextField(
                                controller: _mobileNoController,
                                inputType: TextInputType.number,
                                onChange: (p0) {},
                                maxLength: 10,
                                errorText: Validators.validateMobile(
                                    _mobileNoController.text),
                                label: RichText(
                                  text: const TextSpan(
                                      text: 'Mobile Number',
                                      style: TextStyle(
                                          color: kHintColor,
                                          fontFamily: Montserrat),
                                      children: [
                                        TextSpan(
                                            text: "*",
                                            style: TextStyle(color: Colors.red))
                                      ]),
                                ),
                                hint: "",
                                validators: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your mobile number';
                                  }
                                  if (!indianMobileNumberRegex
                                      .hasMatch(value)) {
                                    return 'Please enter a valid 10-digit Indian mobile number';
                                  }
                                  return null; // Validation passed
                                }),
                            /*child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9a-zA-Z]")),
                              ],
                              controller: _mobileNoController,
                              decoration: InputDecoration(
                                errorMaxLines: 3,
                                label: const Text.rich(TextSpan(children: [
                                  TextSpan(text: 'Mobile Number'),
                                  TextSpan(
                                      text: ' *',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Montserrat',
                                          color: Colors.red)),
                                ])),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                filled: true,
                                hintStyle: TextStyle(color: Colors.grey[500]),
                                hintText: "Enter your mobile number",
                                fillColor: Colors.white70,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your mobile number';
                                }
                                if (!indianMobileNumberRegex.hasMatch(value)) {
                                  return 'Please enter a valid 10-digit Indian mobile number';
                                }
                                return null; // Validation passed
                              },
                            ),*/
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                          AppButton(
                            title: "Send OTP",
                            iconData: Icon(
                              Icons.arrow_forward,
                              size: responsiveHeight(24),
                              color: Colors.white,
                            ),
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Validation Successfull',
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                );

                                Navigator.pushNamed(
                                    context, AppRoutes.pinValidationPage);
                              }
                            },
                          )
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Container(
                          //       decoration: BoxDecoration(
                          //         boxShadow: [
                          //           const BoxShadow(
                          //               color: Colors.black26,
                          //               offset: Offset(0, 4),
                          //               blurRadius: 5.0)
                          //         ],
                          //         gradient: const LinearGradient(
                          //           begin: Alignment.topLeft,
                          //           end: Alignment.bottomRight,
                          //           stops: [0.0, 1.0],
                          //           colors: [
                          //             Colors.orange,
                          //             Colors.lightBlue,
                          //           ],
                          //         ),
                          //         color: Colors.deepPurple.shade300,
                          //         borderRadius: BorderRadius.circular(20),
                          //       ),
                          //       width: Get.width * 0.7,
                          //       height: Get.height * 1 / 21,
                          //       child: ElevatedButton(
                          //         style: ButtonStyle(
                          //           shape: MaterialStateProperty.all<
                          //               RoundedRectangleBorder>(
                          //             RoundedRectangleBorder(
                          //               borderRadius:
                          //                   BorderRadius.circular(20.0),
                          //             ),
                          //           ),
                          //           minimumSize: MaterialStateProperty.all(Size(
                          //               MediaQuery.sizeOf(context).width, 50)),
                          //           backgroundColor: MaterialStateProperty.all(
                          //               Colors.transparent),
                          //           // elevation: MaterialStateProperty.all(3),
                          //           shadowColor: MaterialStateProperty.all(
                          //               Colors.transparent),
                          //         ),
                          //         onPressed: () async {
                          //           print("object");

                          //           if (_formKey.currentState!.validate()) {
                          //             ScaffoldMessenger.of(context)
                          //                 .showSnackBar(
                          //               const SnackBar(
                          //                 content: Text(
                          //                   'Validation Successfull',
                          //                 ),
                          //                 backgroundColor: Colors.green,
                          //               ),
                          //             );

                          //             Get.to(const PinValidationPage());
                          //           }
                          //         },
                          //         child: const Row(
                          //           children: [
                          //             Text(
                          //               'Send OTP',
                          //               style: TextStyle(
                          //                 fontSize: 14,
                          //                 color: Colors.white,
                          //               ),
                          //             ),
                          //             Spacer(),
                          //             Icon(
                          //               Icons.arrow_right_alt_rounded,
                          //               color: Colors.white,
                          //             )
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ]),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
