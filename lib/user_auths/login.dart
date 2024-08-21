import 'dart:convert';

import 'package:community_camp_app/SizeConfig.dart';
import 'package:community_camp_app/user_auths/forgotpassword_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: "Montserrat"),
      home: const LoginPage(title: 'Flutter Demo Home Page'),
    );
  }
}

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

  @override
  void initState() {
    _usernameController.text = '';
    _passwordController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
              Container(
                width: MediaQuery.sizeOf(context).width,
                child: Image.asset(
                  "assets/loginlogo.png",
                  fit: BoxFit.contain,
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  height: MediaQuery.sizeOf(context).width * 0.4,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Community Health Camp ",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "LOGIN",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              _isLoading?
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.red,
                  ),
                  const Text(
                    'Please wait..',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'NotoSans',
                    ),
                  ),
                ],
              )
                  : Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 30, right: 30),
                          child: TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              label: Text.rich(TextSpan(children: [
                                TextSpan(text: 'Username'),
                                TextSpan(text: ' *', style: TextStyle(fontSize: 14, fontFamily: 'Montserrat', color: Colors.red)),
                              ])),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              hintText: "Enter your username",
                              fillColor: Colors.white70,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 30, right: 30),
                          child: TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              label: Text.rich(TextSpan(children: [
                                TextSpan(text: 'Password'),
                                TextSpan(text: ' *', style: TextStyle(fontSize: 14, fontFamily: 'NatoSans', color: Colors.red)),
                              ])),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              hintText: "Enter your password",
                              fillColor: Colors.white70,
                            ),
                          ),
                        ),
                        SizedBox(
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
                                  Get.to(const ForgotPasswordPage());
                                },
                                child: Container(margin: EdgeInsets.only(right: 30), child: Text("Forgot Password ?"))),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
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
                          width: Get.width / 1.2,
                          height: Get.height * 1 / 20,
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
                              validateFields();
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: MediaQuery.sizeOf(context).width * 0.6,
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.sizeOf(context).width * 0.1,
                                  child: Icon(
                                    Icons.arrow_right_alt_rounded,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
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
      Fluttertoast.showToast(msg: "Enter Username", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, textColor: Colors.white, fontSize: 16.0);
    } else if (_passwordController.value.text.isEmpty) {
      Fluttertoast.showToast(msg: "Enter Password", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, textColor: Colors.white, fontSize: 16.0);
    } else {
      loginAPI();
    }
  }

  Future<void> loginAPI() async {
    setState(() {
      _isLoading = true; // Show loader
    });

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('http://210.89.42.117:8085/api/public/account/login'));
    request.body = json.encode({"username": _usernameController.text.toString().trim(), "password": _passwordController.text.toString().trim()});
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
      if(statusCode=="200")
        {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login Successfull',),backgroundColor: Colors.green,),
          );
        }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Failed',),backgroundColor: Colors.red,),
        );
      }



      //navigate to dashboard page
    } else {
      setState(() {
        _isLoading = false; // Hide loader
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong',),backgroundColor: Colors.red,),
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
