import 'package:flutter/material.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/utilities/size_config.dart';

PreferredSize? mAppBar(
    {String? scTitle,
    String? leadingIcon,
    double? elevation,
    bool? showActions = false,
    Function()? onLeadingIconClick,
    List<Widget>? actions}) {
  return PreferredSize(
      preferredSize: const Size.fromHeight(60.0), // here the desired height
      child: AppBar(
        centerTitle: false,
        leading: leadingIcon != null
            ? GestureDetector(
                onTap: onLeadingIconClick,
                child: Center(
                  child: Image.asset(
                    leadingIcon,
                    height: getProportionateScreenHeight(24),
                    width: getProportionateScreenWidth(24),
                    fit: BoxFit.fill,
                  ),
                ),
              )
            : null,
        title: scTitle != null
            ? Text(
                scTitle,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: kBlackColor),
              )
            : null,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: kBlackColor),
        elevation: elevation ?? 0,
        actions: showActions! ? actions : null,
      ));
}
