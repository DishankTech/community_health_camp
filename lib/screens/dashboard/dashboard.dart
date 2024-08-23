import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/dashboard/models/dashbard_meu_model.dart';
import 'package:community_health_app/user_auths/cubit/profile_cubit.dart';
import 'package:community_health_app/user_auths/models/login_response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<DashboardMenuModel> _staticMenuList = [];
  List<DashboardMenuModel> _menuList = [];
  List<Menu>? loggedInMenu;
  bool hasDashboardAccess = false;

  @override
  void initState() {
    super.initState();

    _staticMenuList.addAll([
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
          routeName: AppRoutes.stakeholderMasterListScreen),
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
          routeName: AppRoutes.stakeholderMasterListScreen),
      DashboardMenuModel(
          name: "Camp Creation",
          image: icCampCreation,
          routeName: AppRoutes.campCreation),
      DashboardMenuModel(
          name: "Camp Calendar",
          image: icCampCreation,
          routeName: AppRoutes.campCalendar),
      DashboardMenuModel(
          name: "Camp Approval",
          image: icCampApproval,
          routeName: AppRoutes.campApproval),
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
    context.read<ProfileCubit>().getProfile();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state.loginResponseModel != null) {
          for (var element in state.loginResponseModel!.details!.last.menu!) {
            if (element.parentList != null) {
              if (element.parentList!.menuControllerMobile == "Dashboard") {
                // _menuList.clear();

                if (element.childList != null) {
                  for (var element in element.childList!) {
                    for (var staticMenu in _staticMenuList) {
                      if (element.menuControllerMobile != null &&
                          (element.menuControllerMobile == staticMenu.name)) {
                        // _menuList.add(staticMenu);
                      }
                    }
                  }
                }
              }
            }
          }
        }
        return Scaffold(
            body: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(patRegBg), fit: BoxFit.fill)),
                child: Column(children: [
                  mAppBarV1(
                    title:
                        "Welcome, ${state.loginResponseModel != null ? state.loginResponseModel!.details!.last.user!.fullName : ''}",
                    leading: GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        icMenu,
                        height: responsiveHeight(30),
                      ),
                    ),
                    context: context,
                  ),
                  const Spacer(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.7,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: responsiveHeight(12),
                          right: responsiveHeight(12)),
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
                              child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: _menuList.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  itemBuilder: (c, i) {
                                    return Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        splashFactory: InkRipple.splashFactory,
                                        onTap: () {
                                          if (_menuList[i].routeName != null) {
                                            Navigator.pushNamed(context,
                                                _menuList[i].routeName!);
                                          }
                                        },
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: i ==
                                                          _menuList.length -
                                                              1 ||
                                                      _menuList.length % 2 ==
                                                              0 &&
                                                          i ==
                                                              _menuList.length -
                                                                  2
                                                  ? BorderSide.none
                                                  : const BorderSide(
                                                      color: Colors
                                                          .grey, // Set the color of the bottom border
                                                      width:
                                                          0.5, // Set the width of the bottom border
                                                    ),
                                              right: i % 2 == 1
                                                  ? BorderSide.none
                                                  : const BorderSide(
                                                      color: Colors
                                                          .grey, // Set the color of the right border
                                                      width:
                                                          0.5, // Set the width of the right border
                                                    ),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: responsiveHeight(22),
                                              ),
                                              Image.asset(
                                                _menuList[i].image,
                                                height: responsiveHeight(40),
                                                width: responsiveHeight(40),
                                              ),
                                              SizedBox(
                                                height: responsiveHeight(10),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 22),
                                                child: Text(_menuList[i].name),
                                              ),
                                              // const Divider(
                                              //   color: Colors.grey,
                                              //   thickness: 0.5,
                                              //   height: 0,
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }))),
                    ),
                  ),
                  const Spacer(),
                ])));
      },
    );
  }
}
