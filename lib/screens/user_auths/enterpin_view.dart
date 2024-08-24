import 'dart:async';

import 'package:community_health_app/core/common_widgets/app_button.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/user_auths/createnewpassword_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PinValidationPage extends StatefulWidget {
  const PinValidationPage({Key? key}) : super(key: key);

  @override
  _PinValidationPageState createState() => _PinValidationPageState();
}

class _PinValidationPageState extends State<PinValidationPage> {
  TextEditingController _mobileNoController = TextEditingController();

  // final _formKey = GlobalKey<FormState>();

  final indianMobileNumberRegex = RegExp(r'^[6-9]\d{9}$');

  int _counter = 0;
  late StreamController<int> _events;

  @override
  void initState() {
    _mobileNoController.text = '';

    _events = StreamController<int>();
    _events.add(60);

    _startTimer();
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Timer _timer = Timer(const Duration(milliseconds: 30), () {});

  void _startTimer() {
    try {
      _counter = 30;
      if (_timer != null) {
        _timer.cancel();
      }
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        //setState(() {
        (_counter > 0) ? _counter-- : _timer.cancel();
        //});
        print(_counter);
        _events.add(_counter);
      });
    } catch (e) {
      print(e);
    }
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
          Container(
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
                    "Enter 4 Digits Code",
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
                      "Enter OTP that you have received on your Mobile Number",
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
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    height: MediaQuery.sizeOf(context).height * 0.2,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(left: 8, right: 8),
                            alignment: Alignment.center,
                            width: 40,
                            height: 120,
                            child: Center(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors
                                          .grey, // Change the border color when not focused
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[500]),
                                  hintText: "",
                                  fillColor: Colors.white70,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  StreamBuilder(
                      stream: _events.stream,
                      builder:
                          (BuildContext context, AsyncSnapshot<int> snapshot) {
                        print(snapshot.data.toString());
                        return SizedBox(
                          height: 215,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Remaining Time(seconds):',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text('${snapshot.data.toString()}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),

                              const SizedBox(
                                height: 10,
                              ),
                              Visibility(
                                visible: snapshot.data.toString() == "0"
                                    ? true
                                    : false,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Didnt get OTP ? ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                        )),
                                    InkWell(
                                      onTap: () {},
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("RESEND",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              AppButton(
                                buttonColor: snapshot.data.toString() == "0"
                                    ? Colors.grey
                                    : null,
                                title: "Submit OTP",
                                iconData: Icon(
                                  Icons.arrow_forward,
                                  size: responsiveHeight(24),
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.updatePasswordPage);
                                },
                              )

                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Container(
                              //       decoration: BoxDecoration(
                              //         boxShadow: [
                              //           BoxShadow(
                              //               color: Colors.black26,
                              //               offset: Offset(0, 4),
                              //               blurRadius: 5.0)
                              //         ],
                              //         gradient: LinearGradient(
                              //           begin: Alignment.topLeft,
                              //           end: Alignment.bottomRight,
                              //           stops: [0.0, 1.0],
                              //           colors: [
                              //             snapshot.data.toString() == "0"
                              //                 ? Colors.orange
                              //                 : Colors.orangeAccent.shade100,
                              //             snapshot.data.toString() == "0"
                              //                 ? Colors.lightBlue
                              //                 : Colors.lightBlue.shade100,
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
                              //           minimumSize:
                              //               MaterialStateProperty.all(Size(
                              //                   MediaQuery.sizeOf(context)
                              //                       .width,
                              //                   50)),
                              //           backgroundColor:
                              //               MaterialStateProperty.all(
                              //                   Colors.transparent),
                              //           // elevation: MaterialStateProperty.all(3),
                              //           shadowColor:
                              //               MaterialStateProperty.all(
                              //                   Colors.transparent),
                              //         ),
                              //         onPressed: () async {
                              //           print("object");

                              //           Get.to(UpdatePasswordPage());
                              //         },
                              //         child: Row(
                              //           children: [
                              //             Text(
                              //               'Submit OTP',
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
                              // ),
                              //new column child
                            ],
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
