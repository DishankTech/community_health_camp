import 'package:community_health_app/core/common_widgets/app_button.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternetIssue extends StatelessWidget {
  // const InternetIssue({super.key});

  final Function onRetryPressed;

  const InternetIssue({super.key, required this.onRetryPressed});

  @override
  Widget build(BuildContext context) {
    final screenHeight = Get.height;
    final screenWidth = Get.width;
    return Card(
        elevation: 3.0,
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 40),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            height: screenHeight / 1.19,
            width: screenWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 30, bottom: 14, left: 14, right: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/icons/internet.png",
                    width: 350,
                    height: 300,
                  ),
                  const Center(
                      child: Text(
                        "Oh No! ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )),
                  const Center(
                      child: Column(
                        children: [
                          Text(
                            "No Internet found.",
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            "Check your connection or try again.",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AppButton(
                          onTap: () async{
                            Get.defaultDialog(
                              title: "Loading",
                              content:
                              const CircularProgressIndicator(),
                            );

                            // Wait for a few seconds
                            await Future.delayed(
                                const Duration(seconds: 3));

                            // Close the loading dialog
                            Get.back();

                            // Call the retry function
                            onRetryPressed();
                          },
                          title: "Retry",
                          iconData: Icon(
                            Icons.arrow_forward,
                            color: kWhiteColor,
                            size: responsiveHeight(24),
                          ),
                        )


                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
