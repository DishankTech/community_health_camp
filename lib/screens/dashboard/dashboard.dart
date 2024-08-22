import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/dashboard/models/dashbard_meu_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<DashboardMenuModel> _menuList = [];
  @override
  void initState() {
    super.initState();

    _menuList.addAll([
      DashboardMenuModel(
          name: "Dashboard",
          image: icDashboard,
          routeName: AppRoutes.dashboard),
      DashboardMenuModel(
          name: "User Master",
          image: icUserMaster,
          routeName: AppRoutes.registeredUserMaster),
      DashboardMenuModel(
          name: "Location Master",
          image: icLocationMaster,
          routeName: AppRoutes.locationMaster),
      DashboardMenuModel(
          name: "Stakeholder Master",
          image: icStakeholderMaster,
          routeName: AppRoutes.stakeholderMasterScreen),
      DashboardMenuModel(
          name: "Camp Creation",
          image: icCampCreation,
          routeName: AppRoutes.campCreation),
      DashboardMenuModel(
          name: "Camp Approval", image: icCampApproval, routeName: null),
      DashboardMenuModel(
          name: "Patient Registration",
          image: icPatientRegistration,
          routeName: AppRoutes.patientRegListScreen),
      DashboardMenuModel(
          name: "Doctor Desk",
          image: icDoctorDesk,
          routeName: AppRoutes.dashboard),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(patRegBg), fit: BoxFit.fill)),
            child: Column(children: [
              mAppBarV1(
                title: "Welcome, Admin",
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    icMenu,
                    height: responsiveHeight(30),
                  ),
                ),
                context: context,
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(
                    left: responsiveHeight(12), right: responsiveHeight(12)),
                child: Container(
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(
                        responsiveHeight(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: const Offset(0, 0),
                            blurRadius: 5,
                            spreadRadius: 1)
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: responsiveHeight(40),
                          bottom: responsiveHeight(40)),
                      child: Column(
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_menuList[0].routeName != null) {
                                        Navigator.pushNamed(
                                            context, _menuList[0].routeName!);
                                      }
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: responsiveHeight(22),
                                        ),
                                        Image.asset(
                                          _menuList[0].image,
                                          height: responsiveHeight(40),
                                          width: responsiveHeight(40),
                                        ),
                                        SizedBox(
                                          height: responsiveHeight(10),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 22),
                                          child: Text(_menuList[0].name),
                                        ),
                                        const Divider(
                                          color: Colors.grey,
                                          thickness: 0.5,
                                          height: 0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const VerticalDivider(
                                  color: Colors.grey,
                                  thickness: 0.5,
                                  width: 0,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_menuList[1].routeName != null) {
                                        Navigator.pushNamed(
                                            context, _menuList[1].routeName!);
                                      }
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: responsiveHeight(22),
                                        ),
                                        Image.asset(
                                          _menuList[1].image,
                                          height: responsiveHeight(40),
                                          width: responsiveHeight(40),
                                        ),
                                        SizedBox(
                                          height: responsiveHeight(10),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 22),
                                          child: Text(_menuList[1].name),
                                        ),
                                        const Divider(
                                          color: Colors.grey,
                                          thickness: 0.5,
                                          height: 0,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_menuList[2].routeName != null) {
                                        Navigator.pushNamed(
                                            context, _menuList[2].routeName!);
                                      }
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: responsiveHeight(22),
                                        ),
                                        Image.asset(
                                          _menuList[2].image,
                                          height: responsiveHeight(40),
                                          width: responsiveHeight(40),
                                        ),
                                        SizedBox(
                                          height: responsiveHeight(10),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 22),
                                          child: Text(_menuList[2].name),
                                        ),
                                        const Divider(
                                          color: Colors.grey,
                                          thickness: 0.5,
                                          height: 0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const VerticalDivider(
                                  color: Colors.grey,
                                  thickness: 0.5,
                                  width: 0,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_menuList[3].routeName != null) {
                                        Navigator.pushNamed(
                                            context, _menuList[3].routeName!);
                                      }
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: responsiveHeight(22),
                                        ),
                                        Image.asset(
                                          _menuList[3].image,
                                          height: responsiveHeight(40),
                                          width: responsiveHeight(40),
                                        ),
                                        SizedBox(
                                          height: responsiveHeight(10),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 22),
                                          child: Text(_menuList[3].name),
                                        ),
                                        const Divider(
                                          color: Colors.grey,
                                          thickness: 0.5,
                                          height: 0,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_menuList[4].routeName != null) {
                                        Navigator.pushNamed(
                                            context, _menuList[4].routeName!);
                                      }
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: responsiveHeight(22),
                                        ),
                                        Image.asset(
                                          _menuList[4].image,
                                          height: responsiveHeight(40),
                                          width: responsiveHeight(40),
                                        ),
                                        SizedBox(
                                          height: responsiveHeight(10),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 22),
                                          child: Text(_menuList[4].name),
                                        ),
                                        const Divider(
                                          color: Colors.grey,
                                          thickness: 0.5,
                                          height: 0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const VerticalDivider(
                                  color: Colors.grey,
                                  thickness: 0.5,
                                  width: 0,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_menuList[5].routeName != null) {
                                        Navigator.pushNamed(
                                            context, _menuList[5].routeName!);
                                      }
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: responsiveHeight(22),
                                        ),
                                        Image.asset(
                                          _menuList[5].image,
                                          height: responsiveHeight(40),
                                          width: responsiveHeight(40),
                                        ),
                                        SizedBox(
                                          height: responsiveHeight(10),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 22),
                                          child: Text(_menuList[5].name),
                                        ),
                                        const Divider(
                                          color: Colors.grey,
                                          thickness: 0.5,
                                          height: 0,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_menuList[6].routeName != null) {
                                        Navigator.pushNamed(
                                            context, _menuList[6].routeName!);
                                      }
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: responsiveHeight(22),
                                        ),
                                        Image.asset(
                                          _menuList[6].image,
                                          height: responsiveHeight(40),
                                          width: responsiveHeight(40),
                                        ),
                                        SizedBox(
                                          height: responsiveHeight(10),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 22),
                                          child: Text(_menuList[6].name),
                                        ),
                                        const Divider(
                                          color: Colors.white,
                                          thickness: 0.5,
                                          height: 0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const VerticalDivider(
                                  color: Colors.grey,
                                  thickness: 0.5,
                                  width: 0,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_menuList[7].routeName != null) {
                                        Navigator.pushNamed(
                                            context, _menuList[7].routeName!);
                                      }
                                    },
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: responsiveHeight(22),
                                        ),
                                        Image.asset(
                                          _menuList[7].image,
                                          height: responsiveHeight(40),
                                          width: responsiveHeight(40),
                                        ),
                                        SizedBox(
                                          height: responsiveHeight(10),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 22),
                                          child: Text(_menuList[7].name),
                                        ),
                                        const Divider(
                                          color: Colors.white,
                                          thickness: 0.5,
                                          height: 0,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              const Spacer(),
            ])));
  }
}
