import 'dart:async';
import 'dart:convert';

import 'package:community_health_app/core/common_bloc/bloc/master_data_bloc.dart';
import 'package:community_health_app/core/common_widgets/app_bar_search.dart';
import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/common_widgets/app_round_textfield.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/fonts.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/routes/app_routes.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/patient_registration/bloc/patient_registration_bloc.dart';
import 'package:community_health_app/screens/patient_registration/models/patient_search_response_model.dart';
import 'package:community_health_app/screens/patient_registration/models/registered_patient_model.dart';
import 'package:community_health_app/screens/patient_registration/models/registered_patient_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class RegisteredPatientsSearchScreen extends StatefulWidget {
  const RegisteredPatientsSearchScreen({super.key});

  @override
  State<RegisteredPatientsSearchScreen> createState() =>
      _RegisteredPatientsSearchScreenState();
}

class _RegisteredPatientsSearchScreenState
    extends State<RegisteredPatientsSearchScreen> {
  List<PatientData> _list = [];
  int crrPage = 1;
  int perPage = 10;
  int totalPages = 1;
  bool _isEndReached = false;
  ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //           _scrollController.position.maxScrollExtent &&
    //       _isEndReached == false &&
    //       crrPage <= totalPages) {
    //     setState(() {
    //       crrPage += 1;
    //     });
    //     context
    //         .read<PatientRegistrationBloc>()
    //         .add(GetPatientListRequest(payload: {
    //           "total_pages": totalPages,
    //           "page": crrPage,
    //           "total_count": 1,
    //           "per_page": perPage,
    //           "data": ""
    //         }));
    //   }
    // });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.read<PatientRegistrationBloc>().add(GetPatientListRequest(
    //           payload: const {
    //             "total_pages": 1,
    //             "page": 1,
    //             "total_count": 1,
    //             "per_page": 100,
    //             "data": ""
    //           }));
    // });
  }

  @override
  void dispose() {
    _debounce?.cancel();

    super.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   context
  //       .read<PatientRegistrationBloc>()
  //       .add(ResetPatientRegistrationState());
  //   super.didChangeDependencies();
  // }

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
        if (state.patientSearchListStatus.isSuccess) {
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

          //  else if (res['status_code'] == 200) {
          //   RegisteredPatientResponseModel? registeredPatientModel;
          //   if (state.patientListStatus.isSuccess) {
          //     registeredPatientModel = RegisteredPatientResponseModel.fromJson(
          //         jsonDecode(state.patientListResponse));
          //   }
          //   if (registeredPatientModel != null &&
          //       registeredPatientModel.details != null &&
          //       registeredPatientModel.details!.data != null &&
          //       registeredPatientModel.details!.data!.isNotEmpty) {
          //     setState(() {
          //       totalPages = registeredPatientModel!.details!.totalPages!;
          //     });
          //     _list.addAll(registeredPatientModel.details!.data!);
          //   }
          // } else {
          //   setState(() {
          //     _isEndReached = true;
          //   });
          // }
        }
      },
      child: Scaffold(
          body: Container(
        decoration: const BoxDecoration(
            image:
                DecorationImage(image: AssetImage(patRegBg), fit: BoxFit.fill)),
        child: Column(
          children: [
            mAppBarSearch(
              title: "",
              context: context,
              onBackButtonPress: () {
                Navigator.pop(context);
              },
              isSearched: true,
              searchWidget: AppRoundTextField(
                width: SizeConfig.screenWidth * 0.8,
                onChange: (p0) {
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce = Timer(const Duration(milliseconds: 1000), () {
                    context
                        .read<PatientRegistrationBloc>()
                        .add(SearchPatientRequest(name: p0));
                  });
                },
                label: RichText(
                  text: const TextSpan(
                    text: 'Patient Name',
                    style:
                        TextStyle(color: kWhiteColor, fontFamily: Montserrat),
                    children: [
                      TextSpan(text: " *", style: TextStyle(color: Colors.red))
                    ],
                  ),
                ),
                hint: '',
              ),
            ),
            BlocBuilder<PatientRegistrationBloc, PatientRegistrationState>(
              builder: (context, state) {
                print(state);
                List<PatientSearchData> regPatientsList = [];

                PatientSearchResponseModel? regPatients;
                if (state.patientSearchListStatus.isSuccess) {
                  var res = jsonDecode(state.patientSearchListResponse);
                  regPatients = PatientSearchResponseModel.fromJson(res);
                  regPatientsList.addAll(regPatients.details!);
                }
                return state.patientSearchListStatus.isInProgress
                    ? const Expanded(
                        child: Center(child: CircularProgressIndicator()))
                    : regPatientsList.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                                itemCount: regPatientsList.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (c, i) {
                                  String address =
                                      '${regPatientsList[i].address1 ?? ''} ${regPatientsList[i].address2 ?? ''} ${regPatientsList[i].districtDescEn ?? ''} ${regPatientsList[i].stateDescEn ?? ''}';
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
                                                    child: Icon(
                                                      Icons.person,
                                                      size:
                                                          responsiveHeight(54),
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
                                                        regPatientsList[i]
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
                                                              text: regPatientsList[
                                                                          i]
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
                                                                FontWeight
                                                                    .bold),
                                                        children: [
                                                          TextSpan(
                                                              text: regPatientsList[
                                                                          i]
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
                                                              text: regPatientsList[
                                                                          i]
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
                                    //             Navigator.popAndPushNamed(
                                    //                 context,
                                    //                 AppRoutes
                                    //                     .patientRegEditScreen,
                                    //                 arguments:
                                    //                     regPatientsList[i]);
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
