import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

PreferredSize mAppBarV1(
    {required String title, required BuildContext context, Widget? suffix}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(responsiveHeight(60)),
    child: Padding(
      padding: EdgeInsets.only(
          top: responsiveHeight(
            50,
          ),
          bottom: responsiveHeight(20)),
      child: SizedBox(
        height: responsiveHeight(50),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  icArrowBack,
                  height: responsiveHeight(30),
                ),
              ),
              SizedBox(
                width: responsiveWidth(20),
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: responsiveFont(20),
                    color: kWhiteColor,
                    fontWeight: FontWeight.w500),
              ),
              Spacer(),
              suffix ?? SizedBox.shrink(),
              SizedBox(
                width: responsiveHeight(10),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
