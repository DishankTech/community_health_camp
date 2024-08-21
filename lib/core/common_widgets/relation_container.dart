import 'package:flutter/material.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/utilities/size_config.dart';

class RelationContainer extends StatelessWidget {
  RelationContainer({super.key, required this.bgColor, required this.child});

  Color bgColor;
  Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(responsiveHeight(8), responsiveHeight(3),
            responsiveHeight(8), responsiveHeight(3)),
        child: child,
      ),
    );
  }
}
