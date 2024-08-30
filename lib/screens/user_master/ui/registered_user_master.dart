import 'dart:convert';

import 'package:community_health_app/core/common_bloc/bloc/master_data_bloc.dart';
import 'package:community_health_app/core/common_bloc/models/get_master_response_model_with_hier.dart';
import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/patient_registration/models/registered_patient_master_model.dart';
import 'package:community_health_app/screens/stakeholder/bloc/stakeholder_master_bloc.dart';
import 'package:community_health_app/screens/user_master/bloc/user_master_bloc.dart';
import 'package:community_health_app/screens/user_master/models/get_user_response_model.dart';
import 'package:community_health_app/screens/user_master/ui/user_master.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class RegisteredUserMasterScreen extends StatefulWidget {
  const RegisteredUserMasterScreen({super.key});

  @override
  State<RegisteredUserMasterScreen> createState() =>
      _RegisteredUserMasterScreenState();
}

class _RegisteredUserMasterScreenState
    extends State<RegisteredUserMasterScreen> {
  List<RegisteredPatientMasterModel> _list = [];
  ScrollController _scrollController = ScrollController();
  int crrPage = 1;
  int perPage = 10;
  int totalPages = 1;
  List<UserMasterData> data = [];
  bool _isEndReached = false;
  GetUserMasterWithHierResponse? _selectedStakeholderType;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          _isEndReached == false &&
          crrPage <= totalPages) {
        setState(() {
          crrPage += 1;
        });
        context.read<UserMasterBloc>().add(GetUserRequest(payload: {
              "total_pages": totalPages,
              "page": crrPage,
              "total_count": 1,
              "per_page": perPage,
              "data": ""
            }));
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MasterDataBloc>().add(GetMasters(payload: const {
            "lookup_det_code_list1": [
              {"lookup_det_code": "STY"}
            ]
          }));

      context
          .read<MasterDataBloc>()
          .add(GetMastersDesignationType(payload: const {
            "lookup_code_list1": [
              {"lookup_code": "MTY"}
            ]
          }));
      context.read<UserMasterBloc>().add(GetUserRequest(payload: {
            "total_pages": totalPages,
            "page": crrPage,
            "total_count": 1,
            "per_page": perPage,
            "data": ""
          }));
    });
    _list.addAll([
      RegisteredPatientMasterModel(
          designationType: "Type 1",
          stakeholderType: "NGO",
          stakeholderName: "Pragati Foundation",
          name: "Yashvi Kunal Bhandari",
          mobileNo: "+91 8520147630",
          email: "yashvi@gmail.com"),
      RegisteredPatientMasterModel(
          designationType: "Type 1",
          stakeholderType: "Hospital",
          stakeholderName: "Health Tarachand Ramnath Charitable Hospital Trust",
          name: "Radha Yash Subramanian",
          mobileNo: "+91 5241036987",
          email: "radha@gmail.com"),
      RegisteredPatientMasterModel(
          designationType: "Type 1",
          stakeholderType: "Hospital",
          stakeholderName: "Ca. Dinanath Mangeshkar Hospital",
          name: "Ayesha Madhav Mathur",
          mobileNo: "+91 8520147630",
          email: "ayesha@gmail.com"),
      RegisteredPatientMasterModel(
          designationType: "Type 1",
          stakeholderType: "STEM",
          stakeholderName: "Pragati Foundation",
          name: "Leena Amol Bhatia",
          mobileNo: "+91 8520147630",
          email: "leena@gmail.com"),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // _selectedStakeholderType = GetUserMasterWithHierResponse.fromJson(
    //     jsonDecode(context
    //         .select((MasterDataBloc bloc) => bloc.state.getMasterResponse)));
    return BlocListener<UserMasterBloc, UserMasterState>(
      listener: (context, state) {
        if (state.getUserStatus.isSuccess) {
          var res = jsonDecode(state.getUserResponse);
          if (res['status_code'] == 200) {
            GetUserMasterResponse? getUserMasterResponse;
            if (state.getUserStatus.isSuccess) {
              getUserMasterResponse = GetUserMasterResponse.fromJson(
                  jsonDecode(state.getUserResponse));
            }
            if (getUserMasterResponse != null &&
                getUserMasterResponse.details != null &&
                getUserMasterResponse.details!.data != null &&
                getUserMasterResponse.details!.data!.isNotEmpty) {
              setState(() {
                totalPages = getUserMasterResponse!.details!.totalPages!;
              });
              data.addAll(getUserMasterResponse.details!.data!);
            }
          } else {
            setState(() {
              _isEndReached = true;
            });
          }
        }
      },
      child: BlocListener<MasterDataBloc, MasterDataState>(
        listener: (context, state) {
          if (state.getMasterStatus.isSuccess) {
            _selectedStakeholderType = GetUserMasterWithHierResponse.fromJson(
                jsonDecode(state.getMasterResponse));
          }
        },
        child: Scaffold(
            body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(patRegBg), fit: BoxFit.fill)),
          child: Column(
            children: [
              mAppBarV1(
                title: "Registered User Master",
                onBackButtonPress: () {
                  Navigator.pop(context);
                },
                context: context,
                suffix: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () async {
                      var res = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserMasterScreen()),
                      );
                      if (res != null && mounted) {
                        data.clear();
                        context
                            .read<UserMasterBloc>()
                            .add(GetUserRequest(payload: {
                              "total_pages": totalPages,
                              "page": crrPage,
                              "total_count": 1,
                              "per_page": perPage,
                              "data": ""
                            }));
                      }
                    },
                    child: Ink(
                      child: Image.asset(
                        icSquarePlus,
                        height: responsiveHeight(24),
                      ),
                    ),
                  ),
                ),
              ),
              BlocBuilder<UserMasterBloc, UserMasterState>(
                builder: (context, state) {
                  GetUserMasterResponse? getUserMasterResponse;
                  if (state.getUserStatus.isSuccess) {
                    getUserMasterResponse = GetUserMasterResponse.fromJson(
                        jsonDecode(state.getUserResponse));
                  }
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: data.isNotEmpty,
                          child: Expanded(
                            child: ListView.builder(
                                controller: _scrollController,
                                itemCount: data.length,
                                // shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemBuilder: (c, i) {
                                  return Stack(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: SizeConfig.screenWidth,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  offset: const Offset(0, 0),
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 5)
                                            ],
                                            borderRadius: BorderRadius.circular(
                                                responsiveHeight(20))),
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              responsiveHeight(20)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  text: "Stakeholder Type: ",
                                                  style: TextStyle(
                                                      color: kTextColor,
                                                      fontSize:
                                                          responsiveFont(12),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  children: [
                                                    TextSpan(
                                                        text: data[i]
                                                            .stakeHolderType1En,
                                                        style: TextStyle(
                                                            fontSize:
                                                                responsiveFont(
                                                                    12),
                                                            color: kTextColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal))
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: responsiveHeight(10),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  text: "Stakeholder Name: ",
                                                  style: TextStyle(
                                                      color: kTextColor,
                                                      fontSize:
                                                          responsiveFont(12),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  children: [
                                                    TextSpan(
                                                        text: data[i]
                                                            .stakeholderNameEn,
                                                        style: TextStyle(
                                                            fontSize:
                                                                responsiveFont(
                                                                    12),
                                                            color: kTextColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal))
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: responsiveHeight(10),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  text: "Full Name: ",
                                                  style: TextStyle(
                                                      color: kTextColor,
                                                      fontSize:
                                                          responsiveFont(12),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  children: [
                                                    TextSpan(
                                                        text: data[i].fullName,
                                                        style: TextStyle(
                                                            fontSize:
                                                                responsiveFont(
                                                                    12),
                                                            color: kTextColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal))
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: responsiveHeight(10),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  text:
                                                      "Designation/Member Type : ",
                                                  style: TextStyle(
                                                      color: kTextColor,
                                                      fontSize:
                                                          responsiveFont(12),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  children: [
                                                    TextSpan(
                                                        text: data[i]
                                                            .memberTypeEn,
                                                        style: TextStyle(
                                                            fontSize:
                                                                responsiveFont(
                                                                    12),
                                                            color: kTextColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal))
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: responsiveHeight(10),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  text: "Mobile No : ",
                                                  style: TextStyle(
                                                      color: kTextColor,
                                                      fontSize:
                                                          responsiveFont(12),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  children: [
                                                    TextSpan(
                                                        text: data[i]
                                                            .mobileNumber,
                                                        style: TextStyle(
                                                            fontSize:
                                                                responsiveFont(
                                                                    12),
                                                            color: kTextColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal))
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: responsiveHeight(10),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  text: "Email : ",
                                                  style: TextStyle(
                                                      color: kTextColor,
                                                      fontSize:
                                                          responsiveFont(12),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  children: [
                                                    TextSpan(
                                                        text: data[i].emailId,
                                                        style: TextStyle(
                                                            fontSize:
                                                                responsiveFont(
                                                                    12),
                                                            color: kTextColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal))
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: responsiveHeight(10),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 20,
                                      right: 20,
                                      child: Row(
                                        children: [
                                          Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context,
                                                    AppRoutes
                                                        .userMasterEditScreen,
                                                    arguments:
                                                        getUserMasterResponse!
                                                            .details!.data![i]);
                                              },
                                              child: Ink(
                                                child: Image.asset(
                                                  icEdit,
                                                  height: responsiveHeight(24),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // SizedBox(
                                          //   width: responsiveHeight(10),
                                          // ),
                                          // Material(
                                          //   color: Colors.transparent,
                                          //   child: InkWell(
                                          //     borderRadius:
                                          //         BorderRadius.circular(5),
                                          //     onTap: () {},
                                          //     child: Ink(
                                          //       child: Image.asset(
                                          //         icEye,
                                          //         height: responsiveHeight(24),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ]);
                                }),
                          ),
                        ),
                        state.getUserStatus.isInProgress
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                              )
                            : SizedBox.shrink(),
                        Visibility(
                            visible: data.isEmpty &&
                                !state.getUserStatus.isInProgress,
                            child: Text("No Data Found"))
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        )),
      ),
    );
  }
}
