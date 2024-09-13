import 'dart:convert';

import 'package:community_health_app/core/common_bloc/bloc/master_data_bloc.dart';
import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/patient_registration/bloc/patient_registration_bloc.dart';
import 'package:community_health_app/screens/patient_registration/models/registered_patient_model.dart';
import 'package:community_health_app/screens/patient_registration/models/registered_patient_response_model.dart';
import 'package:community_health_app/screens/patient_registration/ui/patient_registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class RegisteredPatientsScreen extends StatefulWidget {
  const RegisteredPatientsScreen({super.key});

  @override
  State<RegisteredPatientsScreen> createState() =>
      _RegisteredPatientsScreenState();
}

class _RegisteredPatientsScreenState extends State<RegisteredPatientsScreen> {
  List<PatientData> _list = [];
  int crrPage = 1;
  int perPage = 10;
  int totalPages = 1;
  bool _isEndReached = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          _isEndReached == false &&
          crrPage <= totalPages) {
        setState(() {
          crrPage += 1;
        });
        context
            .read<PatientRegistrationBloc>()
            .add(GetPatientListRequest(payload: {
              "total_pages": totalPages,
              "page": crrPage,
              "total_count": 1,
              "per_page": perPage,
              "data": ""
            }));
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<PatientRegistrationBloc>()
          .add(GetPatientListRequest(payload: {
            "total_pages": totalPages,
            "page": crrPage,
            "total_count": 1,
            "per_page": perPage,
            "data": ""
          }));
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Change to your desired color
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness:
          Brightness.light, // For light text/icons on the status bar
    ));

    return BlocListener<PatientRegistrationBloc, PatientRegistrationState>(
      listener: (context, state) {
        if (state.patientListStatus.isSuccess) {
          var res = jsonDecode(state.patientListResponse);
          if (res['message'] == 'Data Not Found') {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(const SnackBar(
                content: Text('You have reached at end of the list'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ));
          } else if (res['status_code'] == 200) {
            RegisteredPatientResponseModel? registeredPatientModel;
            if (state.patientListStatus.isSuccess) {
              registeredPatientModel = RegisteredPatientResponseModel.fromJson(
                  jsonDecode(state.patientListResponse));
            }
            if (registeredPatientModel != null &&
                registeredPatientModel.details != null &&
                registeredPatientModel.details!.data != null &&
                registeredPatientModel.details!.data!.isNotEmpty) {
              setState(() {
                totalPages = registeredPatientModel!.details!.totalPages!;
              });
              _list.addAll(registeredPatientModel.details!.data!);
            }
          } else {
            setState(() {
              _isEndReached = true;
            });
          }
        }
      },
      child: Scaffold(
          body: Container(
        decoration: const BoxDecoration(
            image:
                DecorationImage(image: AssetImage(patRegBg), fit: BoxFit.fill)),
        child: Column(
          children: [
            mAppBarV1(
              title: "Registered Patients",
              context: context,
              onBackButtonPress: () {
                Navigator.pop(context);
              },
              suffix: Row(
                children: [
                  Visibility(
                    visible: true,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(5),
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.patientRegListSearchScreen);
                        },
                        child: Ink(
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: responsiveHeight(24),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: responsiveHeight(10),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: () async {
                        var res = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PatientRegistrationScreen()),
                        );
                        if (res != null && mounted) {
                          _list.clear();
                          context
                              .read<PatientRegistrationBloc>()
                              .add(GetPatientListRequest(payload: {
                                "total_pages": totalPages,
                                "page": crrPage,
                                "total_count": 1,
                                "per_page": perPage,
                                "data": ""
                              }));
                        }
                      },
                      child: Ink(
                        child: Center(
                          child: Image.asset(
                            icSquarePlus,
                            fit: BoxFit.cover,
                            height: responsiveHeight(24),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            BlocBuilder<PatientRegistrationBloc, PatientRegistrationState>(
              builder: (context, state) {
                print(state);

                return Expanded(
                  child: Column(
                    children: [
                      Visibility(
                        visible: _list.isNotEmpty,
                        child: Expanded(
                          child: ListView.builder(
                              itemCount: _list.length,
                              padding: EdgeInsets.zero,
                              controller: _scrollController,
                              itemBuilder: (c, i) {
                                String address =
                                    '${_list[i].address1 ?? ''} ${_list[i].address2 ?? ''} ${_list[i].districtDescEn ?? ''} ${_list[i].stateDescEn ?? ''}';
                                return Stack(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
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
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.blue),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            responsiveHeight(
                                                                10))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(1.0),
                                                  child: Icon(
                                                    Icons.person,
                                                    size: responsiveHeight(54),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: responsiveWidth(16),
                                            ),
                                            Flexible(
                                              flex: 3,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      _list[i].patientName ??
                                                          '',
                                                      style: TextStyle(
                                                          fontSize:
                                                              responsiveFont(
                                                                  14),
                                                          color: kBlackColor,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                  SizedBox(
                                                    height:
                                                        responsiveHeight(10),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      text: "Mobile No: ",
                                                      style: TextStyle(
                                                          color: kTextColor,
                                                          fontSize:
                                                              responsiveFont(
                                                                  12),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      children: [
                                                        TextSpan(
                                                            text: _list[i]
                                                                    .contactNumber ??
                                                                '',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    responsiveFont(
                                                                        12),
                                                                color:
                                                                    kTextColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal))
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        responsiveHeight(10),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      text: "Address: ",
                                                      style: TextStyle(
                                                          color: kTextColor,
                                                          fontSize:
                                                              responsiveFont(
                                                                  12),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      children: [
                                                        TextSpan(
                                                            text: address,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    responsiveFont(
                                                                        12),
                                                                color:
                                                                    kTextColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal))
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        responsiveHeight(10),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      text: "Camp Name: ",
                                                      style: TextStyle(
                                                          color: kTextColor,
                                                          fontSize:
                                                              responsiveFont(
                                                                  12),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      children: [
                                                        TextSpan(
                                                            text: _list[i]
                                                                    .campCreateRequestId
                                                                    .toString() ??
                                                                '',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    responsiveFont(
                                                                        12),
                                                                color:
                                                                    kTextColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal))
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        responsiveHeight(10),
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      text: "Camp Date: ",
                                                      style: TextStyle(
                                                          color: kTextColor,
                                                          fontSize:
                                                              responsiveFont(
                                                                  12),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      children: [
                                                        TextSpan(
                                                            text: _list[i]
                                                                    .campDate ??
                                                                '',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    responsiveFont(
                                                                        12),
                                                                color:
                                                                    kTextColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal))
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        responsiveHeight(10),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Positioned(
                                  //   top: 20,
                                  //   right: 20,
                                  //   child: Row(
                                  //     children: [
                                  //       Material(
                                  //         color: Colors.transparent,
                                  //         child: InkWell(
                                  //           borderRadius:
                                  //               BorderRadius.circular(5),
                                  //           onTap: () {
                                  //             Navigator.pushNamed(
                                  //                 context,
                                  //                 AppRoutes
                                  //                     .patientRegEditScreen,
                                  //                 arguments: _list[i]);
                                  //           },
                                  //           child: Ink(
                                  //             child: Image.asset(
                                  //               icEdit,
                                  //               height: responsiveHeight(24),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       // SizedBox(
                                  //       //   width: responsiveHeight(10),
                                  //       // ),
                                  //       // Material(
                                  //       //   color: Colors.transparent,
                                  //       //   child: InkWell(
                                  //       //     borderRadius:
                                  //       //         BorderRadius.circular(5),
                                  //       //     onTap: () {},
                                  //       //     child: Ink(
                                  //       //       child: Image.asset(
                                  //       //         icEye,
                                  //       //         height: responsiveHeight(24),
                                  //       //       ),
                                  //       //     ),
                                  //       //   ),
                                  //       // ),
                                  //     ],
                                  //   ),
                                  // ),
                                ]);
                              }),
                        ),
                      ),
                      state.patientListStatus.isInProgress
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: kPrimaryColor,
                              ),
                            )
                          : const SizedBox.shrink(),
                      Visibility(
                          visible: _list.isEmpty &&
                              !state.patientListStatus.isInProgress,
                          child: const Text("No Data Found"))
                    ],
                  ),
                );
              },
            )
          ],
        ),
      )),
    );
  }
}
