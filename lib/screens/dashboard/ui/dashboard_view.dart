// import 'package:community_health_app/core/constants/images.dart';
// import 'package:community_health_app/core/routes/app_routes.dart';
// import 'package:community_health_app/core/utilities/size_config.dart';
// import 'package:community_health_app/screens/dashboard/model/dashboard_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
//
// import '../../../core/common_widgets/app_bar_v1.dart';
//
// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});
//
//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }
//
// class _DashboardScreenState extends State<DashboardScreen> {
//   List<DashboardPagesModel> _homepageslist = [];
//
//   @override
//   void initState() {
//     super.initState();
//
//     _homepageslist.addAll([DashboardPagesModel(pageName: "CampCalendar",image: ""), DashboardPagesModel(pageName: "CampCreation",image: "")]);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//
//
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent, // Change to your desired color
//       statusBarBrightness: Brightness.light,
//       statusBarIconBrightness: Brightness.light, // For light text/icons on the status bar
//     ));
//
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(patRegBg), fit: BoxFit.fill)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             mAppBarV1(
//                 title: "Dashboard",
//                 onBackButtonPress: (){
//                   Navigator.pop(context);
//                 },
//                 context: context,
//                 suffix: Material(
//                   color: Colors.white,
//                   child: InkWell(
//                     borderRadius: BorderRadius.circular(5),
//                     onTap: () {
//                       Navigator.pushNamed(context, AppRoutes.patientRegScreen);
//                     },
//                     child: Ink(
//                       child: Image.asset(
//                         icSquarePlus,
//                         height: responsiveHeight(24),
//                       ),
//                     ),
//                   ),
//                 )),
//             Expanded(
//                 child: ListView.builder(
//                     itemCount: _homepageslist.length,
//                     itemBuilder: (context, index) {
//                       return InkWell(
//                         onTap: (){
//                           if(_homepageslist[index].pageName=="CampCalendar")
//                             {
//                               Navigator.of(context).popAndPushNamed(AppRoutes.campCalendar);
//                             }
//                         },
//                         child: Container(
//                           margin: EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               boxShadow: [BoxShadow(offset: Offset(0, 0), color: Colors.grey.withOpacity(0.5), spreadRadius: 1, blurRadius: 5)],
//                               borderRadius: BorderRadius.circular(responsiveHeight(20))),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               children: [
//                                 Text(_homepageslist[index].pageName),
//                                 Spacer(),
//                                 Icon(Icons.arrow_right_alt),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     }))
//           ],
//         ),
//       ),
//     );
//   }
//
//
// }
