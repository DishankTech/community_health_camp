import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class mAppBarV1 extends StatelessWidget {
  final String title;
  final BuildContext context;
  final Widget? suffix;
  final Widget? leading;
  final Widget? searchWidget;
  final Function? onBackButtonPress;
  final bool? isSearched;

  const mAppBarV1(
      {super.key,
      required this.title,
      required this.context,
      this.suffix,
      this.leading,
      this.onBackButtonPress,
      this.isSearched,
      this.searchWidget});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize:
          Size.fromHeight(responsiveHeight(isSearched == true ? 65 : 60)),
      child: Padding(
        padding: EdgeInsets.only(
            top: responsiveHeight(
              50,
            ),
            bottom: responsiveHeight(20)),
        child: SizedBox(
          height: responsiveHeight(isSearched == true ? 65 : 60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Visibility(
                  visible: isSearched == null || isSearched == false,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      leading ??
                          GestureDetector(
                            onTap: () {
                              // Navigator.pop(context);
                              if (onBackButtonPress != null) {
                                onBackButtonPress!();
                              }
                            },
                            child: Image.asset(
                              icArrowBack,
                              height: responsiveHeight(30),
                            ),
                          ),
                      SizedBox(
                        width: responsiveWidth(20),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          title,
                          style: TextStyle(
                              fontSize: responsiveFont(16),
                              color: kWhiteColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      // Spacer(),
                      suffix ?? const SizedBox.shrink(),
                      SizedBox(
                        width: responsiveHeight(10),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: isSearched == true,
                  child: Row(
                    children: [
                      Expanded(child: searchWidget ?? const SizedBox.shrink()),
                      suffix ?? const SizedBox.shrink(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
