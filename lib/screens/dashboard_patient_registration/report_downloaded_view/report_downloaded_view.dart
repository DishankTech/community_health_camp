import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/images.dart';

class ReportDownloadedView extends StatelessWidget {
  const ReportDownloadedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.52),
      body: Center(
        child: Container(
          width: responsiveWidth(280),
          height: 280,
          padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              responsiveHeight(25),
            ),
            border: Border.all(
              color: Colors.white,
              width: 1,
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    width: responsiveHeight(30),
                    height: responsiveHeight(30),
                    child: Image.asset(icSquareClose),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: responsiveWidth(80),
                      height: responsiveHeight(80),
                      // child: Image.asset(verifiedicon),
                    ),
                    SizedBox(
                      height: responsiveHeight(20),
                    ),
                    Text(
                      "Report Downloaded\nSuccessfully",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: responsiveFont(20),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
