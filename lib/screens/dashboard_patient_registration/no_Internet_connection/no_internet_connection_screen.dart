import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/common_widgets/app_button.dart';
import '../../../core/constants/constants.dart';

class NoInternetConnectionScreen extends StatefulWidget {
  const NoInternetConnectionScreen({super.key});

  @override
  State<NoInternetConnectionScreen> createState() =>
      _NoInternetConnectionScreenState();
}

class _NoInternetConnectionScreenState
    extends State<NoInternetConnectionScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Change to your desired color
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness:
          Brightness.light, // For light text/icons on the status bar
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: Container(
              color: Colors.transparent,
              width: responsiveWidth(300),
              height: responsiveHeight(220),
              child: Image.asset(
                nointernetconnectionicon,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            "No Internet Connection",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: responsiveHeight(24),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: responsiveHeight(20),
          ),
          Text(
            "Please check your internet\nconnection",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: noInternetTextColor,
              fontSize: responsiveHeight(18),
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          Flexible(
            flex: 1,
            child: Container(
              height: responsiveHeight(60),
              color: Colors.transparent,
              child: Center(
                child: AppButton(
                  mWidth: responsiveWidth(160),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  title: "Retry",
                  iconData: Icon(
                    Icons.arrow_forward,
                    color: kWhiteColor,
                    size: responsiveHeight(24),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
// class NoInternetConnectionScreen extends StatelessWidget {
//   const NoInternetConnectionScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         color: Colors.amber,
//         child: 
// Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 height: double.infinity,
//                 color: Colors.green,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       width: responsiveWidth(100),
//                       height: responsiveHeight(100),
//                       child: Image.asset(nointernetconnectionicon),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width,
//               height: 60,
//               color: Colors.blue,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// //nointernetconnectionicon