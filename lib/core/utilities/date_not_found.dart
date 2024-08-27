import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DataNotFound extends StatelessWidget {
  const DataNotFound({super.key});

  // const DataNotFound({super.key});



  @override
  Widget build(BuildContext context) {
    final screenHeight = Get.height * 0.6;
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
                      child: Column(
                        children: [
                          Text(
                            "No Data Found.",
                            style: TextStyle(color: Colors.black),
                          ),

                        ],
                      )),

                ],
              ),
            ),
          ),
        ));
  }
}