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
  List<RegisteredPatientModel> _list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _list.addAll([
      RegisteredPatientModel(
          address:
              "Address : R-603, Midc, Thane Belapur Rd, Rabale,Navi Mumbai, 400701",
          campDate: "21 Aug 2024",
          campName: "Health Camp",
          mobile: "+91 5630178450",
          name: "Abhinandan Vohra",
          image: pat1),
      RegisteredPatientModel(
          address:
              "Address : R-603, Midc, Thane Belapur Rd, Rabale,Navi Mumbai, 400701",
          campDate: "19 Aug 2024",
          campName: "Health Camp",
          mobile: "+91 6398740210",
          name: "Anaya Mehra",
          image: pat2),
      RegisteredPatientModel(
          address:
              "Address : R-603, Midc, Thane Belapur Rd, Rabale,Navi Mumbai, 400701",
          campDate: "18 Aug 2024",
          campName: "Health Camp",
          mobile: "+91 3210456008",
          name: "Imran Siddiqui",
          image: pat3),
      RegisteredPatientModel(
          address:
              "Address : Shop 13, C, Shyam Kamal Bldg, Opp Parle Intl Hotel, Vile Parle (east), 400057",
          campDate: "10 Aug 2024",
          campName: "Health Camp",
          mobile: "+91 6541026874",
          name: "Sanjay Desai",
          image: pat1),
    ]);

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.read<MasterDataBloc>().add(GetGenderRequest(payload: const {
    //         "lookup_code_list1": [
    //           {"lookup_code": "GEN"}
    //         ]
    //       }));

    //   context.read<MasterDataBloc>().add(GetDistrictList(payload: const {
    //         "lookup_det_code_list1": const [
    //           {"lookup_det_code": "DIS"}
    //         ]
    //       }));

    //   context.read<MasterDataBloc>().add(GetTalukaList(payload: const {
    //         "lookup_det_code_list1": const [
    //           {"lookup_det_code": "TLK"}
    //         ]
    //       }));
    // });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Change to your desired color
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness:
          Brightness.light, // For light text/icons on the status bar
    ));

    context.read<PatientRegistrationBloc>().add(GetPatientListRequest(
            payload: const {
              "total_pages": 1,
              "page": 1,
              "total_count": 1,
              "per_page": 100,
              "data": ""
            }));
    return BlocListener<PatientRegistrationBloc, PatientRegistrationState>(
      listener: (context, state) {
        if (state.patientListStatus.isSuccess) {
          var res = jsonDecode(state.patientListResponse);
          if (res['message'] == 'Data Not Found') {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(SnackBar(
                content: Text(res['message']),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
              ));
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
              suffix: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.patientRegScreen);
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
              ),
            ),
            BlocBuilder<PatientRegistrationBloc, PatientRegistrationState>(
              builder: (context, state) {
                print(state);
                RegisteredPatientResponseModel? regPatients;
                if (state.patientListStatus.isSuccess) {
                  var res = jsonDecode(state.patientListResponse);
                  regPatients = RegisteredPatientResponseModel.fromJson(res);
                }
                return state.patientListStatus.isInProgress
                    ? const Expanded(
                        child: Center(child: CircularProgressIndicator()))
                    : regPatients != null &&
                            regPatients.details != null &&
                            regPatients.details!.data!.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                                itemCount: regPatients.details!.data!.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (c, i) {
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
                                                        const EdgeInsets.all(
                                                            1.0),
                                                    child: Image.asset(
                                                      pat1,
                                                      height:
                                                          responsiveHeight(54),
                                                      width:
                                                          responsiveWidth(54),
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
                                                        regPatients!
                                                                .details!
                                                                .data![i]
                                                                .patientName ??
                                                            '',
                                                        style: TextStyle(
                                                            fontSize:
                                                                responsiveFont(
                                                                    14),
                                                            color: kBlackColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
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
                                                                FontWeight
                                                                    .bold),
                                                        children: [
                                                          TextSpan(
                                                              text: regPatients!
                                                                      .details!
                                                                      .data![i]
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
                                                                FontWeight
                                                                    .bold),
                                                        children: [
                                                          TextSpan(
                                                              text: regPatients!
                                                                  .details!
                                                                  .data![i]
                                                                  .pinCode,
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
                                                                FontWeight
                                                                    .bold),
                                                        children: [
                                                          TextSpan(
                                                              text: regPatients!
                                                                      .details!
                                                                      .data![i]
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
                                                                FontWeight
                                                                    .bold),
                                                        children: [
                                                          TextSpan(
                                                              text: regPatients!
                                                                      .details!
                                                                      .data![i]
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
                                                        .patientRegEditScreen,
                                                    arguments: regPatients!
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
                                          SizedBox(
                                            width: responsiveHeight(10),
                                          ),
                                          Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              onTap: () {},
                                              child: Ink(
                                                child: Image.asset(
                                                  icEye,
                                                  height: responsiveHeight(24),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]);
                                }),
                          )
                        : const Expanded(
                            child: Center(child: Text('Data Not Found')));
              },
            )
          ],
        ),
      )),
    );
  }
}
