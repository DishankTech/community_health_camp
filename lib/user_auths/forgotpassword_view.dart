import 'package:community_camp_app/user_auths/enterpin_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
              child: Stack(
                children:[
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
                          SizedBox(
                            height: 100,
                          ),
                          Text(
                            "Forgot Password ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            child: Text(
                              "Enter your Mobile number for the verification process and we will send you OTP to your Email or Number",
                              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.normal, fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 30, right: 30),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                              ],
                              controller: _mobileNoController,
                              decoration: InputDecoration(
                                errorMaxLines: 3,
                                label: Text.rich(TextSpan(children: [
                                  TextSpan(text: 'Mobile Number'),
                                  TextSpan(text: ' *', style: TextStyle(fontSize: 14, fontFamily: 'Montserrat', color: Colors.red)),
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
                            ),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)],
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    stops: [0.0, 1.0],
                                    colors: [
                                      Colors.orange,
                                      Colors.lightBlue,
                                    ],
                                  ),
                                  color: Colors.deepPurple.shade300,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                width: Get.width * 0.7,
                                height: Get.height * 1 / 21,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    minimumSize: MaterialStateProperty.all(Size(MediaQuery.sizeOf(context).width, 50)),
                                    backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                    // elevation: MaterialStateProperty.all(3),
                                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                                  ),
                                  onPressed: () async {
                                    print("object");

                                    if (_formKey.currentState!.validate()) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Validation Successfull',
                                          ),
                                          backgroundColor: Colors.green,
                                        ),
                                      );

                                      Get.to(PinValidationPage());
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'Send OTP',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_right_alt_rounded,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),]
              ),
            ),
          ]),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
