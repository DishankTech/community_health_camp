import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController _newpasswordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final String passwordPattern = r'^(?=.*[A-Za-z])(?=.*[\d@!#$_])[A-Za-z\d@!#$_]{8,}$';  //special character not necessary



  bool _obscureText_new = true;
  bool _obscureText_confirm = true;


  @override
  void initState() {
    _newpasswordController.text = '';
    _confirmpasswordController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        style: TextStyle(color: Colors.black54, fontWeight: FontWeight.normal, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(

                        obscureText: _obscureText_new,
                        controller: _newpasswordController,
                        decoration: InputDecoration(
                          errorMaxLines: 3,
                          label: Text.rich(TextSpan(children: [
                            TextSpan(text: 'New Password'),
                            TextSpan(text: ' *', style: TextStyle(fontSize: 14, fontFamily: 'Montserrat', color: Colors.red)),
                          ])),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          hintText: "Enter new password",
                          fillColor: Colors.white70,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText_new ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText_new = !_obscureText_new; // Toggle password visibility
                              });
                            },
                          ),
                        ),
                        validator: (value) {
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
                      child: TextFormField(
                        controller: _confirmpasswordController,
                        obscureText: _obscureText_confirm,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm Password is required';
                          }
                          final regex = RegExp(passwordPattern);
                          if (!regex.hasMatch(value)) {
                            return 'The password must be at least 8 characters long, \ncontain at least one alphabet, one number or one special character (@, !, #, \$, _).';
                          }
                          return null; // Validation passed
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText_confirm ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText_confirm = !_obscureText_confirm; // Toggle password visibility
                              });
                            },
                          ),
                          errorMaxLines: 3,
                          label: Text.rich(TextSpan(children: [
                            TextSpan(text: 'Confirm Password'),
                            TextSpan(text: ' *', style: TextStyle(fontSize: 14, fontFamily: 'Montserrat', color: Colors.red)),
                          ])),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          hintText: "Enter Confirm Password",
                          fillColor: Colors.white70,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            child: Text(
                                style: TextStyle(color: Colors.black54, fontWeight: FontWeight.normal, fontSize: 14),
                                textAlign: TextAlign.center,
                                "Note : The password must contain alphabet with 8 characters long and "
                                "included at least one number or  special character.Special Characters allowed (@, !, #, \$, _) "
                                '')),
                      ],
                    ),
                    SizedBox(
                      height: 40,
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
                          width: Get.width * 0.4,
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
                                  if(_newpasswordController.text.toString()==_confirmpasswordController.text.toString())
                                    {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Validation Successfull',),backgroundColor: Colors.green,),
                                      );
                                    }else{
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Passwords does not match'),backgroundColor: Colors.red,),
                                    );
                                  }

                                }

                            },
                            child: Row(
                              children: [
                                Text(
                                  'Submit',
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
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)],
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1.0],
                              colors: [
                                Colors.grey,
                                Colors.grey,
                              ],
                            ),
                            color: Colors.deepPurple.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: Get.width * 0.4,
                          height: Get.height * 1 / 21,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              minimumSize: MaterialStateProperty.all(Size(MediaQuery.sizeOf(context).width * 0.4, 50)),
                              backgroundColor: MaterialStateProperty.all(Colors.transparent),
                              // elevation: MaterialStateProperty.all(3),
                              shadowColor: MaterialStateProperty.all(Colors.transparent),
                            ),
                            onPressed: () async {
                              print("object");
                              Navigator.pop(context);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Cancel',
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
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
