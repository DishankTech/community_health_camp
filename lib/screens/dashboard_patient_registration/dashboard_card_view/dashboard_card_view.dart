// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utilities/size_config.dart';

class DashboardCardView extends StatelessWidget {
  DashboardCardView(
      {super.key,
      required this.titleString,
      required this.tillDateCount,
      required this.todayString,
      required this.isLoading});

  String titleString;
  String tillDateCount;
  String todayString;
  bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 0),
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5)
          ],
          borderRadius: BorderRadius.circular(
            responsiveHeight(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total",
              style: TextStyle(
                color: dasboardCardTitleColor,
                fontSize: responsiveFont(11),
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              titleString,
              style: TextStyle(
                color: dasboardCardTitleColor,
                fontSize: responsiveFont(11),
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              color: Colors.transparent,
              height: responsiveHeight(80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Expanded(
                  //   child: Container(
                  //     color: Colors.transparent,
                  //     width: double.infinity,
                  //     height: double.infinity,
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Text(
                  //           tillDateCount,
                  //           style: TextStyle(
                  //             color: Colors.black,
                  //             fontSize: responsiveFont(20),
                  //             fontWeight: FontWeight.w400,
                  //           ),
                  //         ),
                  //         Text(
                  //           "Till Date",
                  //           style: TextStyle(
                  //             color: dashboardSubTitle,
                  //             fontSize: responsiveFont(14),
                  //             fontWeight: FontWeight.w400,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      width: double.infinity,
                      height: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          isLoading
                              ? CircularProgressIndicator()
                              : Text(
                                  todayString,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: responsiveFont(20),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                          // Text(
                          //   "Today",
                          //   style: TextStyle(
                          //     color: dashboardSubTitle,
                          //     fontSize: responsiveFont(14),
                          //     fontWeight: FontWeight.w400,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// class DashboardCardView extends StatefulWidget {
//   DashboardCardView({
   
//   @override
//   State<DashboardCardView> createState() => _DashboardCardViewState();
// }

// class _DashboardCardViewState extends State<DashboardCardView> {
//   @override
//   Widget build(BuildContext context) {
//     return 

//   }
// }
