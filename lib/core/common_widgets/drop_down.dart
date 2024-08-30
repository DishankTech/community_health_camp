import 'dart:convert';

import 'package:community_health_app/core/common_bloc/bloc/master_data_bloc.dart';
import 'package:community_health_app/core/common_bloc/models/camp_dropdown_list_response_model.dart'
    as CommonCamp;
import 'package:community_health_app/core/common_bloc/models/get_master_response_model_with_hier.dart';
import 'package:community_health_app/core/common_bloc/models/master_lookup_det_hier_response_model.dart';
import 'package:community_health_app/core/common_bloc/models/master_response_model.dart';
import 'package:community_health_app/core/common_widgets/app_button.dart';
import 'package:community_health_app/core/common_widgets/app_round_textfield.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/fonts.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/camp_coordinator/controller/camp_details_controller.dart';
import 'package:community_health_app/screens/camp_creation/camp_creation_controller.dart';
import 'package:community_health_app/screens/stakeholder/bloc/stakeholder_master_bloc.dart';
import 'package:community_health_app/screens/stakeholder/models/stakeholder_name_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';

Future<dynamic> genderBottomSheet(
    BuildContext context, Function(LookupDet) onItemSelected) {
  int selectedIndex = -1;
  return showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (c) => StatefulBuilder(
            builder: (c, setState) => Container(
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(responsiveHeight(50)),
                      topRight: Radius.circular(responsiveHeight(50)))),
              child: Padding(
                padding: EdgeInsets.all(responsiveHeight(30)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Gender",
                            style: TextStyle(
                                fontSize: responsiveFont(17),
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                icSquareClose,
                                height: responsiveHeight(24),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeight(25),
                    ),
                    BlocBuilder<MasterDataBloc, MasterDataState>(
                      builder: (context, state) {
                        MasterResponseModel? responseModel;
                        if (state.getGenderResponse.isNotEmpty) {
                          responseModel = MasterResponseModel.fromJson(
                              jsonDecode(state.getGenderResponse));
                        }
                        return responseModel != null &&
                                responseModel.details != null &&
                                responseModel.details![0].lookupDet != null
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: responseModel
                                      .details![0].lookupDet!.length,
                                  itemBuilder: (c, i) => Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: () {
                                          var selectedItem = {
                                            'id': responseModel!.details![0]
                                                .lookupDet![i].lookupDetId!,
                                            'title': responseModel.details![0]
                                                .lookupDet![i].lookupDetDescEn!
                                          };
                                          onItemSelected(responseModel!
                                              .details![0].lookupDet![i]);
                                          setState(
                                            () {
                                              selectedIndex = i;
                                            },
                                          );

                                          Navigator.pop(context);
                                        },
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            color: i == selectedIndex
                                                ? Colors.transparent
                                                : kListBGColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  i == selectedIndex
                                                      ? icCircleDot
                                                      : icCircle,
                                                  height: responsiveHeight(20),
                                                ),
                                                SizedBox(
                                                  width: responsiveWidth(20),
                                                ),
                                                Expanded(
                                                  child: Text(responseModel!
                                                      .details![0]
                                                      .lookupDet![i]
                                                      .lookupDetDescEn!),
                                                ),
                                                const Spacer(),
                                                i == selectedIndex
                                                    ? Image.asset(
                                                        icCircleCheck,
                                                        height:
                                                            responsiveHeight(
                                                                20),
                                                      )
                                                    : const SizedBox.shrink(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text("Data Not Available"));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ));
}

Future<dynamic> stakeholderBottomSheet(
    BuildContext context, Function(LookupDetHierarchical) onItemSelected) {
  int selectedIndex = -1;
  return showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (c) => StatefulBuilder(
            builder: (c, setState) => Container(
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(responsiveHeight(50)),
                      topRight: Radius.circular(responsiveHeight(50)))),
              child: Padding(
                padding: EdgeInsets.all(responsiveHeight(30)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Stakeholder Type",
                            style: TextStyle(
                                fontSize: responsiveFont(17),
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                icSquareClose,
                                height: responsiveHeight(24),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeight(25),
                    ),
                    BlocBuilder<MasterDataBloc, MasterDataState>(
                      builder: (context, state) {
                        GetUserMasterWithHierResponse? responseModel;
                        if (state.getMasterResponse.isNotEmpty) {
                          responseModel =
                              GetUserMasterWithHierResponse.fromJson(
                                  jsonDecode(state.getMasterResponse));
                        }

                        return state.getMasterStatus.isInProgress
                            ? const Center(child: CircularProgressIndicator())
                            : responseModel != null &&
                                    responseModel.details != null
                                ? Expanded(
                                    child: ListView.builder(
                                      itemCount: responseModel.details![0]
                                          .lookupDetHierarchical!.length,
                                      itemBuilder: (c, i) => Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            onTap: () {
                                              onItemSelected(responseModel!
                                                  .details![0]
                                                  .lookupDetHierarchical![i]);
                                              setState(
                                                () {
                                                  selectedIndex = i;
                                                },
                                              );
                                              Navigator.pop(context);
                                            },
                                            child: Ink(
                                              decoration: BoxDecoration(
                                                color: i == selectedIndex
                                                    ? Colors.transparent
                                                    : kListBGColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      i == selectedIndex
                                                          ? icCircleDot
                                                          : icCircle,
                                                      height:
                                                          responsiveHeight(20),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          responsiveWidth(20),
                                                    ),
                                                    Text(responseModel!
                                                        .details![0]
                                                        .lookupDetHierarchical![
                                                            i]
                                                        .lookupDetHierDescEn!),
                                                    const Spacer(),
                                                    i == selectedIndex
                                                        ? Image.asset(
                                                            icCircleCheck,
                                                            height:
                                                                responsiveHeight(
                                                                    20),
                                                          )
                                                        : const SizedBox
                                                            .shrink(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const Center(
                                    child: Text("Data Not Available"));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ));
}

Future<dynamic> sectorTypeBottomSheet(
    BuildContext context, Function(LookupDet) onItemSelected) {
  int selectedIndex = -1;
  return showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (c) => StatefulBuilder(
            builder: (c, setState) => Container(
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(responsiveHeight(50)),
                      topRight: Radius.circular(responsiveHeight(50)))),
              child: Padding(
                padding: EdgeInsets.all(responsiveHeight(30)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Sector Type",
                            style: TextStyle(
                                fontSize: responsiveFont(17),
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                icSquareClose,
                                height: responsiveHeight(24),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeight(25),
                    ),
                    BlocBuilder<MasterDataBloc, MasterDataState>(
                      builder: (context, state) {
                        MasterResponseModel? responseModel;
                        if (state.getSectorTypeResponse.isNotEmpty) {
                          responseModel = MasterResponseModel.fromJson(
                              jsonDecode(state.getSectorTypeResponse));
                        }

                        return state.getSectorTypeStatus.isInProgress
                            ? const Center(child: CircularProgressIndicator())
                            : responseModel != null &&
                                    responseModel.details != null
                                ? Expanded(
                                    child: ListView.builder(
                                      itemCount: responseModel
                                          .details![0].lookupDet!.length,
                                      itemBuilder: (c, i) => Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            onTap: () {
                                              onItemSelected(responseModel!
                                                  .details![0].lookupDet![i]);
                                              setState(
                                                () {
                                                  selectedIndex = i;
                                                },
                                              );
                                              Navigator.pop(context);
                                            },
                                            child: Ink(
                                              decoration: BoxDecoration(
                                                color: i == selectedIndex
                                                    ? Colors.transparent
                                                    : kListBGColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      i == selectedIndex
                                                          ? icCircleDot
                                                          : icCircle,
                                                      height:
                                                          responsiveHeight(20),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          responsiveWidth(20),
                                                    ),
                                                    Text(responseModel!
                                                        .details![0]
                                                        .lookupDet![i]
                                                        .lookupDetDescEn!),
                                                    const Spacer(),
                                                    i == selectedIndex
                                                        ? Image.asset(
                                                            icCircleCheck,
                                                            height:
                                                                responsiveHeight(
                                                                    20),
                                                          )
                                                        : const SizedBox
                                                            .shrink(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const Center(
                                    child: Text("Data Not Available"));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ));
}

Future<dynamic> stakeholderSubTypeBottomSheet(
    BuildContext context, Function(LookupDetHierarchical) onItemSelected) {
  int selectedIndex = -1;
  return showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (c) => StatefulBuilder(
            builder: (c, setState) => Container(
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(responsiveHeight(50)),
                      topRight: Radius.circular(responsiveHeight(50)))),
              child: Padding(
                padding: EdgeInsets.all(responsiveHeight(30)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Stakeholder Sub Type",
                            style: TextStyle(
                                fontSize: responsiveFont(17),
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                icSquareClose,
                                height: responsiveHeight(24),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeight(25),
                    ),
                    BlocBuilder<MasterDataBloc, MasterDataState>(
                      builder: (context, state) {
                        GetUserMasterWithHierResponse responseModel =
                            GetUserMasterWithHierResponse.fromJson(jsonDecode(
                                state.getStakeholderSubTypeResponse));

                        return responseModel.details != null &&
                                responseModel
                                        .details![0].lookupDetHierarchical !=
                                    null
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: responseModel.details![0]
                                      .lookupDetHierarchical!.length,
                                  itemBuilder: (c, i) => Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: () {
                                          var selectedItem = {
                                            'id': responseModel
                                                .details![0]
                                                .lookupDetHierarchical![i]
                                                .lookupDetHierId,
                                            'title': responseModel
                                                .details![0]
                                                .lookupDetHierarchical![i]
                                                .lookupDetHierDescEn!
                                          };
                                          onItemSelected(responseModel
                                              .details![0]
                                              .lookupDetHierarchical![i]);
                                          setState(
                                            () {
                                              selectedIndex = i;
                                            },
                                          );
                                          Navigator.pop(context);
                                        },
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            color: i == selectedIndex
                                                ? Colors.transparent
                                                : kListBGColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  i == selectedIndex
                                                      ? icCircleDot
                                                      : icCircle,
                                                  height: responsiveHeight(20),
                                                ),
                                                SizedBox(
                                                  width: responsiveWidth(20),
                                                ),
                                                Expanded(
                                                  child: Text(responseModel
                                                      .details![0]
                                                      .lookupDetHierarchical![i]
                                                      .lookupDetHierDescEn!),
                                                ),
                                                const Spacer(),
                                                i == selectedIndex
                                                    ? Image.asset(
                                                        icCircleCheck,
                                                        height:
                                                            responsiveHeight(
                                                                20),
                                                      )
                                                    : const SizedBox.shrink(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text("Data Not Available"));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ));
}

Future<dynamic> stakeholderNameBottomSheet(
    BuildContext context, Function(StakeholderNameDetails) onItemSelected) {
  int selectedIndex = -1;
  List<StakeholderNameDetails> filteredData = [];
  TextEditingController _searchTextController = TextEditingController();
  return showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (c) => StatefulBuilder(
            builder: (c, setState) => Container(
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(responsiveHeight(50)),
                      topRight: Radius.circular(responsiveHeight(50)))),
              child: Padding(
                padding: EdgeInsets.all(responsiveHeight(30)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Stakeholder Name",
                            style: TextStyle(
                                fontSize: responsiveFont(17),
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                icSquareClose,
                                height: responsiveHeight(24),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeight(25),
                    ),
                    BlocBuilder<StakeholderMasterBloc, StakeholderMasterState>(
                      builder: (context, state) {
                        StakeholderNameResponseModel responseModel =
                            StakeholderNameResponseModel.fromJson(
                                jsonDecode(state.getStakeholderNameResponse));

                        return responseModel.details != null &&
                                responseModel.details!.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: responseModel.details!.length,
                                  itemBuilder: (c, i) => Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: () {
                                          onItemSelected(
                                              responseModel.details![i]);
                                          setState(
                                            () {
                                              selectedIndex = i;
                                            },
                                          );
                                          Navigator.pop(context);
                                        },
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            color: i == selectedIndex
                                                ? Colors.transparent
                                                : kListBGColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  i == selectedIndex
                                                      ? icCircleDot
                                                      : icCircle,
                                                  height: responsiveHeight(20),
                                                ),
                                                SizedBox(
                                                  width: responsiveWidth(20),
                                                ),
                                                Expanded(
                                                  child: Text(responseModel
                                                      .details![i]
                                                      .stakeholderNameEn!),
                                                ),
                                                const Spacer(),
                                                i == selectedIndex
                                                    ? Image.asset(
                                                        icCircleCheck,
                                                        height:
                                                            responsiveHeight(
                                                                20),
                                                      )
                                                    : const SizedBox.shrink(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text("Data Not Available"));
                      },
                    ),
                    // SizedBox(
                    //   height: responsiveHeight(25),
                    // ),
                    // AppRoundTextField(
                    //   label: Text("Search"),
                    //   hint: "Search",
                    //   controller: _searchTextController,
                    // ),
                    // SizedBox(
                    //   height: responsiveHeight(10),
                    // ),
                  ],
                ),
              ),
            ),
          ));
}

Future<dynamic> designationTypeBottomSheet(
    BuildContext context, Function(Map<String, dynamic>) onItemSelected) {
  int selectedIndex = -1;
  return showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (c) => StatefulBuilder(
            builder: (c, setState) => Container(
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(responsiveHeight(50)),
                      topRight: Radius.circular(responsiveHeight(50)))),
              child: Padding(
                padding: EdgeInsets.all(responsiveHeight(30)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Designation Type",
                            style: TextStyle(
                                fontSize: responsiveFont(17),
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                icSquareClose,
                                height: responsiveHeight(24),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeight(25),
                    ),
                    BlocBuilder<MasterDataBloc, MasterDataState>(
                      builder: (context, state) {
                        MasterResponseModel? responseModel;
                        if (state.getMasterDesignationTypeResponse.isNotEmpty) {
                          responseModel = MasterResponseModel.fromJson(
                              jsonDecode(
                                  state.getMasterDesignationTypeResponse));
                        }
                        return responseModel != null &&
                                responseModel.details != null &&
                                responseModel.details![0].lookupDet != null
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: responseModel
                                      .details![0].lookupDet!.length,
                                  itemBuilder: (c, i) => Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: () {
                                          var selectedItem = {
                                            'id': responseModel!.details![0]
                                                .lookupDet![i].lookupDetId!,
                                            'title': responseModel.details![0]
                                                .lookupDet![i].lookupDetDescEn!
                                          };
                                          onItemSelected(selectedItem);
                                          setState(
                                            () {
                                              selectedIndex = i;
                                            },
                                          );

                                          Navigator.pop(context);
                                        },
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            color: i == selectedIndex
                                                ? Colors.transparent
                                                : kListBGColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  i == selectedIndex
                                                      ? icCircleDot
                                                      : icCircle,
                                                  height: responsiveHeight(20),
                                                ),
                                                SizedBox(
                                                  width: responsiveWidth(20),
                                                ),
                                                Text(responseModel!
                                                    .details![0]
                                                    .lookupDet![i]
                                                    .lookupDetDescEn!),
                                                const Spacer(),
                                                i == selectedIndex
                                                    ? Image.asset(
                                                        icCircleCheck,
                                                        height:
                                                            responsiveHeight(
                                                                20),
                                                      )
                                                    : const SizedBox.shrink(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text("Data Not Available"));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ));
}

Future<dynamic> divisionBottomSheet(
    BuildContext context, Function(LookupDet) onItemSelected) {
  int selectedIndex = -1;
  return showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (c) => StatefulBuilder(
            builder: (c, setState) => Container(
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(responsiveHeight(50)),
                      topRight: Radius.circular(responsiveHeight(50)))),
              child: Padding(
                padding: EdgeInsets.all(responsiveHeight(30)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Divison",
                            style: TextStyle(
                                fontSize: responsiveFont(17),
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                icSquareClose,
                                height: responsiveHeight(24),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeight(25),
                    ),
                    BlocBuilder<MasterDataBloc, MasterDataState>(
                      builder: (context, state) {
                        MasterResponseModel? responseModel;
                        if (state.getDivisionListResponse.isNotEmpty) {
                          responseModel = MasterResponseModel.fromJson(
                              jsonDecode(state.getDivisionListResponse));
                        }
                        return responseModel != null &&
                                responseModel.details != null &&
                                responseModel.details![0].lookupDet != null
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: responseModel
                                      .details![0].lookupDet!.length,
                                  itemBuilder: (c, i) => Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: () {
                                          var selectedItem = {
                                            'id': responseModel!.details![0]
                                                .lookupDet![i].lookupDetId!,
                                            'title': responseModel.details![0]
                                                .lookupDet![i].lookupDetDescEn!
                                          };
                                          onItemSelected(responseModel!
                                              .details![0].lookupDet![i]);
                                          setState(
                                            () {
                                              selectedIndex = i;
                                            },
                                          );

                                          Navigator.pop(context);
                                        },
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            color: i == selectedIndex
                                                ? Colors.transparent
                                                : kListBGColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  i == selectedIndex
                                                      ? icCircleDot
                                                      : icCircle,
                                                  height: responsiveHeight(20),
                                                ),
                                                SizedBox(
                                                  width: responsiveWidth(20),
                                                ),
                                                Expanded(
                                                  child: Text(responseModel!
                                                      .details![0]
                                                      .lookupDet![i]
                                                      .lookupDetDescEn!),
                                                ),
                                                const Spacer(),
                                                i == selectedIndex
                                                    ? Image.asset(
                                                        icCircleCheck,
                                                        height:
                                                            responsiveHeight(
                                                                20),
                                                      )
                                                    : const SizedBox.shrink(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text("Data Not Available"));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ));
}

Future<dynamic> districtBottomSheet(
    BuildContext context, Function(LookupDetHierarchical) onItemSelected) {
  int selectedIndex = -1;
  return showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (c) => StatefulBuilder(
            builder: (c, setState) => Container(
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(responsiveHeight(50)),
                      topRight: Radius.circular(responsiveHeight(50)))),
              child: Padding(
                padding: EdgeInsets.all(responsiveHeight(30)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "District",
                            style: TextStyle(
                                fontSize: responsiveFont(17),
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                icSquareClose,
                                height: responsiveHeight(24),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeight(25),
                    ),
                    BlocBuilder<MasterDataBloc, MasterDataState>(
                      builder: (context, state) {
                        GetUserMasterWithHierResponse? responseModel;

                        if (state.getDistrictListResponse.isNotEmpty) {
                          responseModel =
                              GetUserMasterWithHierResponse.fromJson(
                                  jsonDecode(state.getDistrictListResponse));
                        }

                        return responseModel != null &&
                                responseModel.details != null
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: responseModel.details![0]
                                      .lookupDetHierarchical!.length,
                                  itemBuilder: (c, i) => Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: () {
                                          var selectedItem = {
                                            'id': responseModel!
                                                .details![0]
                                                .lookupDetHierarchical![i]
                                                .lookupDetHierId,
                                            'title': responseModel
                                                .details![0]
                                                .lookupDetHierarchical![i]
                                                .lookupDetHierDescEn!
                                          };
                                          onItemSelected(responseModel
                                              .details![0]
                                              .lookupDetHierarchical![i]);
                                          setState(
                                            () {
                                              selectedIndex = i;
                                            },
                                          );
                                          Navigator.pop(context);
                                        },
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            color: i == selectedIndex
                                                ? Colors.transparent
                                                : kListBGColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  i == selectedIndex
                                                      ? icCircleDot
                                                      : icCircle,
                                                  height: responsiveHeight(20),
                                                ),
                                                SizedBox(
                                                  width: responsiveWidth(20),
                                                ),
                                                Text(responseModel!
                                                    .details![0]
                                                    .lookupDetHierarchical![i]
                                                    .lookupDetHierDescEn!),
                                                const Spacer(),
                                                i == selectedIndex
                                                    ? Image.asset(
                                                        icCircleCheck,
                                                        height:
                                                            responsiveHeight(
                                                                20),
                                                      )
                                                    : const SizedBox.shrink(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text("Data Not Available"));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ));
}

Future<dynamic> districtBottomSheetV1(
    BuildContext context, Function(LookupDetHierDetails) onItemSelected) {
  int selectedIndex = -1;
  return showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (c) => StatefulBuilder(
            builder: (c, setState) => Container(
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(responsiveHeight(50)),
                      topRight: Radius.circular(responsiveHeight(50)))),
              child: Padding(
                padding: EdgeInsets.all(responsiveHeight(30)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "District",
                            style: TextStyle(
                                fontSize: responsiveFont(17),
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                icSquareClose,
                                height: responsiveHeight(24),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeight(25),
                    ),
                    BlocBuilder<MasterDataBloc, MasterDataState>(
                      builder: (context, state) {
                        MasterLookupDetHierResponseModel? responseModel;

                        if (state.getTalukaListResponse.isNotEmpty) {
                          responseModel =
                              MasterLookupDetHierResponseModel.fromJson(
                                  jsonDecode(state.getTalukaListResponse));
                        }

                        return responseModel != null &&
                                responseModel.details != null
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: responseModel.details!.length,
                                  itemBuilder: (c, i) => Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: () {
                                          onItemSelected(
                                              responseModel!.details![i]);
                                          setState(
                                            () {
                                              selectedIndex = i;
                                            },
                                          );
                                          Navigator.pop(context);
                                        },
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            color: i == selectedIndex
                                                ? Colors.transparent
                                                : kListBGColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  i == selectedIndex
                                                      ? icCircleDot
                                                      : icCircle,
                                                  height: responsiveHeight(20),
                                                ),
                                                SizedBox(
                                                  width: responsiveWidth(20),
                                                ),
                                                Text(responseModel!.details![i]
                                                    .lookupDetHierDescEn!),
                                                const Spacer(),
                                                i == selectedIndex
                                                    ? Image.asset(
                                                        icCircleCheck,
                                                        height:
                                                            responsiveHeight(
                                                                20),
                                                      )
                                                    : const SizedBox.shrink(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text("Data Not Available"));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ));
}

Future<dynamic> talukaBottomSheet(
    BuildContext context, Function(LookupDetHierarchical) onItemSelected) {
  int selectedIndex = -1;
  return showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (c) => StatefulBuilder(
            builder: (c, setState) => Container(
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(responsiveHeight(50)),
                      topRight: Radius.circular(responsiveHeight(50)))),
              child: Padding(
                padding: EdgeInsets.all(responsiveHeight(30)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Taluka",
                            style: TextStyle(
                                fontSize: responsiveFont(17),
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                icSquareClose,
                                height: responsiveHeight(24),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeight(25),
                    ),
                    BlocBuilder<MasterDataBloc, MasterDataState>(
                      builder: (context, state) {
                        GetUserMasterWithHierResponse? responseModel;

                        if (state.getTalukaListResponse.isNotEmpty) {
                          responseModel =
                              GetUserMasterWithHierResponse.fromJson(
                                  jsonDecode(state.getTalukaListResponse));
                        }

                        return responseModel != null &&
                                responseModel.details != null
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: responseModel.details![0]
                                      .lookupDetHierarchical!.length,
                                  itemBuilder: (c, i) => Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: () {
                                          var selectedItem = {
                                            'id': responseModel!
                                                .details![0]
                                                .lookupDetHierarchical![i]
                                                .lookupDetHierId,
                                            'title': responseModel
                                                .details![0]
                                                .lookupDetHierarchical![i]
                                                .lookupDetHierDescEn!
                                          };
                                          onItemSelected(responseModel
                                              .details![0]
                                              .lookupDetHierarchical![i]);
                                          setState(
                                            () {
                                              selectedIndex = i;
                                            },
                                          );
                                          Navigator.pop(context);
                                        },
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            color: i == selectedIndex
                                                ? Colors.transparent
                                                : kListBGColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  i == selectedIndex
                                                      ? icCircleDot
                                                      : icCircle,
                                                  height: responsiveHeight(20),
                                                ),
                                                SizedBox(
                                                  width: responsiveWidth(20),
                                                ),
                                                Text(responseModel!
                                                    .details![0]
                                                    .lookupDetHierarchical![i]
                                                    .lookupDetHierDescEn!),
                                                const Spacer(),
                                                i == selectedIndex
                                                    ? Image.asset(
                                                        icCircleCheck,
                                                        height:
                                                            responsiveHeight(
                                                                20),
                                                      )
                                                    : const SizedBox.shrink(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text("Data Not Available"));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ));
}

Future<dynamic> talukaBottomSheetV1(
    BuildContext context, Function(LookupDetHierDetails) onItemSelected) {
  int selectedIndex = -1;
  return showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (c) => StatefulBuilder(
            builder: (c, setState) => Container(
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(responsiveHeight(50)),
                      topRight: Radius.circular(responsiveHeight(50)))),
              child: Padding(
                padding: EdgeInsets.all(responsiveHeight(30)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Taluka",
                            style: TextStyle(
                                fontSize: responsiveFont(17),
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                icSquareClose,
                                height: responsiveHeight(24),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeight(25),
                    ),
                    BlocBuilder<MasterDataBloc, MasterDataState>(
                      builder: (context, state) {
                        MasterLookupDetHierResponseModel? responseModel;

                        if (state.getTalukaListResponse.isNotEmpty) {
                          responseModel =
                              MasterLookupDetHierResponseModel.fromJson(
                                  jsonDecode(state.getTalukaListResponse));
                        }

                        return responseModel != null &&
                                responseModel.details != null
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: responseModel.details!.length,
                                  itemBuilder: (c, i) => Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: () {
                                          onItemSelected(
                                              responseModel!.details![i]);
                                          setState(
                                            () {
                                              selectedIndex = i;
                                            },
                                          );
                                          Navigator.pop(context);
                                        },
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            color: i == selectedIndex
                                                ? Colors.transparent
                                                : kListBGColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  i == selectedIndex
                                                      ? icCircleDot
                                                      : icCircle,
                                                  height: responsiveHeight(20),
                                                ),
                                                SizedBox(
                                                  width: responsiveWidth(20),
                                                ),
                                                Text(responseModel!.details![i]
                                                    .lookupDetHierDescEn!),
                                                const Spacer(),
                                                i == selectedIndex
                                                    ? Image.asset(
                                                        icCircleCheck,
                                                        height:
                                                            responsiveHeight(
                                                                20),
                                                      )
                                                    : const SizedBox.shrink(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text("Data Not Available"));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ));
}

Future<dynamic> stakeholderSubTypeBottomSheetV1(
    BuildContext context, Function(LookupDetHierDetails) onItemSelected) {
  int selectedIndex = -1;
  return showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (c) => StatefulBuilder(
            builder: (c, setState) => Container(
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(responsiveHeight(50)),
                      topRight: Radius.circular(responsiveHeight(50)))),
              child: Padding(
                padding: EdgeInsets.all(responsiveHeight(30)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Stakeholder Sub Type",
                            style: TextStyle(
                                fontSize: responsiveFont(17),
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                icSquareClose,
                                height: responsiveHeight(24),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeight(25),
                    ),
                    BlocBuilder<MasterDataBloc, MasterDataState>(
                      builder: (context, state) {
                        MasterLookupDetHierResponseModel? responseModel;

                        if (state.getStakeholderSubTypeResponse.isNotEmpty) {
                          responseModel =
                              MasterLookupDetHierResponseModel.fromJson(
                                  jsonDecode(
                                      state.getStakeholderSubTypeResponse));
                        }

                        return responseModel != null &&
                                responseModel.details != null
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: responseModel.details!.length,
                                  itemBuilder: (c, i) => Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: () {
                                          onItemSelected(
                                              responseModel!.details![i]);
                                          setState(
                                            () {
                                              selectedIndex = i;
                                            },
                                          );
                                          Navigator.pop(context);
                                        },
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            color: i == selectedIndex
                                                ? Colors.transparent
                                                : kListBGColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  i == selectedIndex
                                                      ? icCircleDot
                                                      : icCircle,
                                                  height: responsiveHeight(20),
                                                ),
                                                SizedBox(
                                                  width: responsiveWidth(20),
                                                ),
                                                Expanded(
                                                  child: Text(responseModel!
                                                      .details![i]
                                                      .lookupDetHierDescEn!),
                                                ),
                                                const Spacer(),
                                                i == selectedIndex
                                                    ? Image.asset(
                                                        icCircleCheck,
                                                        height:
                                                            responsiveHeight(
                                                                20),
                                                      )
                                                    : const SizedBox.shrink(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text("Data Not Available"));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ));
}

Future<dynamic> townBottomSheet(
    BuildContext context, Function(LookupDetHierarchical) onItemSelected) {
  int selectedIndex = -1;
  return showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (c) => StatefulBuilder(
            builder: (c, setState) => Container(
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(responsiveHeight(50)),
                      topRight: Radius.circular(responsiveHeight(50)))),
              child: Padding(
                padding: EdgeInsets.all(responsiveHeight(30)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "City",
                            style: TextStyle(
                                fontSize: responsiveFont(17),
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                icSquareClose,
                                height: responsiveHeight(24),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeight(25),
                    ),
                    BlocBuilder<MasterDataBloc, MasterDataState>(
                      builder: (context, state) {
                        GetUserMasterWithHierResponse? responseModel;

                        if (state.getTownListResponse.isNotEmpty) {
                          responseModel =
                              GetUserMasterWithHierResponse.fromJson(
                                  jsonDecode(state.getTownListResponse));
                        }

                        return responseModel != null &&
                                responseModel.details != null &&
                                responseModel.details!.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: responseModel.details![0]
                                      .lookupDetHierarchical!.length,
                                  itemBuilder: (c, i) => Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: () {
                                          var selectedItem = {
                                            'id': responseModel!
                                                .details![0]
                                                .lookupDetHierarchical![i]
                                                .lookupDetHierId,
                                            'title': responseModel
                                                .details![0]
                                                .lookupDetHierarchical![i]
                                                .lookupDetHierDescEn!
                                          };
                                          onItemSelected(responseModel
                                              .details![0]
                                              .lookupDetHierarchical![i]);
                                          setState(
                                            () {
                                              selectedIndex = i;
                                            },
                                          );
                                          Navigator.pop(context);
                                        },
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            color: i == selectedIndex
                                                ? Colors.transparent
                                                : kListBGColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  i == selectedIndex
                                                      ? icCircleDot
                                                      : icCircle,
                                                  height: responsiveHeight(20),
                                                ),
                                                SizedBox(
                                                  width: responsiveWidth(20),
                                                ),
                                                Text(responseModel!
                                                    .details![0]
                                                    .lookupDetHierarchical![i]
                                                    .lookupDetHierDescEn!),
                                                const Spacer(),
                                                i == selectedIndex
                                                    ? Image.asset(
                                                        icCircleCheck,
                                                        height:
                                                            responsiveHeight(
                                                                20),
                                                      )
                                                    : const SizedBox.shrink(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text("Data Not Available"));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ));
}

Future<dynamic> townBottomSheetV1(
    BuildContext context, Function(LookupDetHierDetails) onItemSelected) {
  int selectedIndex = -1;
  return showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (c) => StatefulBuilder(
            builder: (c, setState) => Container(
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(responsiveHeight(50)),
                      topRight: Radius.circular(responsiveHeight(50)))),
              child: Padding(
                padding: EdgeInsets.all(responsiveHeight(30)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "City",
                            style: TextStyle(
                                fontSize: responsiveFont(17),
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                icSquareClose,
                                height: responsiveHeight(24),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeight(25),
                    ),
                    BlocBuilder<MasterDataBloc, MasterDataState>(
                      builder: (context, state) {
                        MasterLookupDetHierResponseModel? responseModel;

                        if (state.getTownListResponse.isNotEmpty) {
                          responseModel =
                              MasterLookupDetHierResponseModel.fromJson(
                                  jsonDecode(state.getTownListResponse));
                        }

                        return responseModel != null &&
                                responseModel.details != null &&
                                responseModel.details!.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: responseModel.details!.length,
                                  itemBuilder: (c, i) => Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: () {
                                          onItemSelected(
                                              responseModel!.details![i]);
                                          setState(
                                            () {
                                              selectedIndex = i;
                                            },
                                          );
                                          Navigator.pop(context);
                                        },
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            color: i == selectedIndex
                                                ? Colors.transparent
                                                : kListBGColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  i == selectedIndex
                                                      ? icCircleDot
                                                      : icCircle,
                                                  height: responsiveHeight(20),
                                                ),
                                                SizedBox(
                                                  width: responsiveWidth(20),
                                                ),
                                                Text(responseModel!.details![i]
                                                    .lookupDetHierDescEn!),
                                                const Spacer(),
                                                i == selectedIndex
                                                    ? Image.asset(
                                                        icCircleCheck,
                                                        height:
                                                            responsiveHeight(
                                                                20),
                                                      )
                                                    : const SizedBox.shrink(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text("Data Not Available"));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ));
}

Future<dynamic> campListDropdownBottomSheet(
    BuildContext context, Function(CommonCamp.CampDetails) onItemSelected) {
  int selectedIndex = -1;
  return showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (c) => StatefulBuilder(
            builder: (c, setState) => Container(
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(responsiveHeight(50)),
                      topRight: Radius.circular(responsiveHeight(50)))),
              child: Padding(
                padding: EdgeInsets.all(responsiveHeight(30)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Camp",
                            style: TextStyle(
                                fontSize: responsiveFont(17),
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                icSquareClose,
                                height: responsiveHeight(24),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeight(25),
                    ),
                    BlocBuilder<MasterDataBloc, MasterDataState>(
                      builder: (context, state) {
                        CommonCamp.CampDropdownReponseModel? responseModel;

                        if (state.getCampDropdownListResponse.isNotEmpty) {
                          responseModel =
                              CommonCamp.CampDropdownReponseModel.fromJson(
                                  jsonDecode(
                                      state.getCampDropdownListResponse));
                        }

                        return responseModel != null &&
                                responseModel.details != null &&
                                responseModel.details!.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: responseModel.details!.length,
                                  itemBuilder: (c, i) => Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: () {
                                          onItemSelected(
                                              responseModel!.details![i]);
                                          setState(
                                            () {
                                              selectedIndex = i;
                                            },
                                          );
                                          Navigator.pop(context);
                                        },
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            color: i == selectedIndex
                                                ? Colors.transparent
                                                : kListBGColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  i == selectedIndex
                                                      ? icCircleDot
                                                      : icCircle,
                                                  height: responsiveHeight(20),
                                                ),
                                                SizedBox(
                                                  width: responsiveWidth(20),
                                                ),
                                                Text(
                                                    'Camp :-${responseModel!.details![i].campCreateRequestId}'),
                                                const Spacer(),
                                                i == selectedIndex
                                                    ? Image.asset(
                                                        icCircleCheck,
                                                        height:
                                                            responsiveHeight(
                                                                20),
                                                      )
                                                    : const SizedBox.shrink(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text("Data Not Available"));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ));
}

Future<dynamic> stakeholderStatusBottomSheet(
    BuildContext context, Function(Map<String, dynamic>) onItemSelected) {
  int selectedIndex = -1;
  return showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (c) => StatefulBuilder(
            builder: (c, setState) => Container(
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(responsiveHeight(50)),
                      topRight: Radius.circular(responsiveHeight(50)))),
              child: Padding(
                padding: EdgeInsets.all(responsiveHeight(30)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Status",
                            style: TextStyle(
                                fontSize: responsiveFont(17),
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              icSquareClose,
                              height: responsiveHeight(24),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: responsiveHeight(25),
                    ),
                    BlocBuilder<MasterDataBloc, MasterDataState>(
                      builder: (context, state) {
                        List<Map<String, dynamic>> list = [
                          {"title": "Active", "id": 0},
                          {"title": "In Active", "id": 1},
                        ];
                        return list != null
                            ? ListView.builder(
                                itemCount: list.length,
                                shrinkWrap: true,
                                itemBuilder: (c, i) => Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(10),
                                      onTap: () {
                                        var selectedItem = {
                                          'id': list[i]['id'],
                                          'title': list[i]['title']
                                        };
                                        onItemSelected(selectedItem);
                                        setState(
                                          () {
                                            selectedIndex = i;
                                          },
                                        );

                                        Navigator.pop(context);
                                      },
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          color: i == selectedIndex
                                              ? Colors.transparent
                                              : kListBGColor,
                                          // border: Border.all(
                                          //     color: kTextFieldBorder,
                                          //     width: 0.5),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                i == selectedIndex
                                                    ? icCircleDot
                                                    : icCircle,
                                                height: responsiveHeight(20),
                                              ),
                                              SizedBox(
                                                width: responsiveWidth(20),
                                              ),
                                              Text(list[i]['title']),
                                              const Spacer(),
                                              i == selectedIndex
                                                  ? Image.asset(
                                                      icCircleCheck,
                                                      height:
                                                          responsiveHeight(20),
                                                    )
                                                  : const SizedBox.shrink(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: Text("Data Not Available"));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ));
}

Future<dynamic> commonBottonSheet(
    BuildContext context,
    Function(Map<String, dynamic>) onItemSelected,
    String bottomSheetTitle,
    List<Map<String, dynamic>> list) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (c) => Container(
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(responsiveHeight(50)),
                    topRight: Radius.circular(responsiveHeight(50)))),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        bottomSheetTitle,
                        style: TextStyle(
                            fontSize: responsiveFont(17),
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.cancel_presentation))
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.3,
                  child: BlocBuilder<MasterDataBloc, MasterDataState>(
                    builder: (context, state) {
                      return list != null
                          ? ListView.builder(
                              itemCount: list.length,
                              shrinkWrap: true,
                              itemBuilder: (c, i) => Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 12),
                                  child: InkWell(
                                    onTap: () {
                                      var selectedItem = {
                                        'id': list[i]['id'],
                                        'title': list[i]['title']
                                      };
                                      onItemSelected(selectedItem);
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: kContainerBack,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.circle_outlined),
                                            SizedBox(
                                              width: responsiveWidth(6),
                                            ),
                                            Text(list[i]['title']),
                                            const Spacer(),
                                            const Icon(
                                              Icons.check_circle,
                                              color: kPrimaryColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const Center(child: Text("Data Not Available"));
                    },
                  ),
                ),
              ],
            ),
          ));
}

Future<dynamic> commonBottomSheet(
    BuildContext context,
    Function(dynamic) onItemSelected,
    String bottomSheetTitle,
    List<dynamic> list,
    {bool? isVisible}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (c) => _CommonBottomSheetContent(
      onItemSelected: onItemSelected,
      bottomSheetTitle: bottomSheetTitle,
      list: list,
      isVisible: isVisible ?? true,
    ),
  );
}

class _CommonBottomSheetContent extends StatefulWidget {
  final Function(dynamic) onItemSelected;
  final String bottomSheetTitle;
  final List<dynamic> list;
  final bool isVisible;

  const _CommonBottomSheetContent({
    required this.onItemSelected,
    required this.bottomSheetTitle,
    required this.list,
    required this.isVisible,
  });

  @override
  State<_CommonBottomSheetContent> createState() =>
      _CommonBottomSheetContentState();
}

class _CommonBottomSheetContentState extends State<_CommonBottomSheetContent> {
  int? selectedIndex;
  TextEditingController txtContro = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(responsiveHeight(50)),
          topRight: Radius.circular(responsiveHeight(50)),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.bottomSheetTitle,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: responsiveFont(17),
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel_presentation),
                ),
              ],
            ),
          ),
          Visibility(
            visible: widget.isVisible,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: kTextFieldBorder, width: 1),
                    borderRadius: BorderRadius.circular(responsiveHeight(60))),
                child: TypeAheadField<dynamic>(
                  controller: txtContro,
                  suggestionsCallback: (search) {
                    return widget.list.where((stakeHolder) {
                      final stakeHNameLower =
                          stakeHolder.lookupDetHierDescEn?.toLowerCase() ?? "";
                      final searchLower = search.toLowerCase();
                      return stakeHNameLower.contains(searchLower);
                    }).toList();
                  },
                  builder: (BuildContext context,
                      TextEditingController textController,
                      FocusNode focusNode) {
                    return TextField(
                        controller: textController,
                        focusNode: focusNode,
                        autofocus: true,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(left: 8, top: 12),
                          suffixIcon:
                              const Icon(Icons.search, color: kPrimaryColor),
                          border: InputBorder.none,
                          hintText: "Search ${widget.bottomSheetTitle}",
                        ));
                  },
                  itemBuilder: (context, stakeholder) {
                    bool isSelected =
                        widget.list.indexOf(stakeholder) == selectedIndex;
                    return Container(
                      decoration: BoxDecoration(
                        color: kContainerBack,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          children: [
                            isSelected
                                ? Icon(
                                    Icons.radio_button_checked,
                                    color: kPrimaryColor,
                                    size: responsiveFont(14.0),
                                  )
                                : Icon(
                                    Icons.circle_outlined,
                                    size: responsiveFont(14.0),
                                  ),
                            SizedBox(
                              width: responsiveWidth(6),
                            ),
                            Expanded(
                              child: Text(
                                stakeholder.lookupDetHierDescEn ?? "",
                                style: TextStyle(
                                  fontSize: responsiveFont(14.0),
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                            const Spacer(),
                            if (isSelected)
                              Icon(
                                Icons.check_circle,
                                color: kPrimaryColor,
                                size: responsiveFont(14.0),
                              ),
                          ],
                        ).paddingSymmetric(horizontal: 4, vertical: 2),
                      ),
                    );
                    // return ListTile(
                    //   title: Text(stakeholder.lookupDetHierDescEn ?? ""),
                    //   // subtitle: Text(city.country),
                    // );
                  },
                  onSelected: (dynamic selectedStakeH) {
                    txtContro.text = selectedStakeH.lookupDetHierDescEn ?? '';
                    setState(() {
                      // Move the selected item to the top of the list
                      int selectedIndex = widget.list.indexOf(selectedStakeH);
                      if (selectedIndex != -1) {
                        var selectedItem = widget.list.removeAt(selectedIndex);
                        widget.list.insert(0, selectedItem);
                        this.selectedIndex =
                            0; // Update the selectedIndex for the ListView
                      }
                    });
                    widget.onItemSelected(selectedStakeH);
                    Get.back();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.list.length,
              shrinkWrap: true,
              itemBuilder: (c, i) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = i;
                      });

                      widget.onItemSelected(widget.list[i]);
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: kContainerBack,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            selectedIndex == i
                                ? Icon(
                                    Icons.radio_button_checked,
                                    color: kPrimaryColor,
                                    size: responsiveFont(14.0),
                                  )
                                : Icon(
                                    Icons.circle_outlined,
                                    size: responsiveFont(14.0),
                                  ),
                            SizedBox(
                              width: responsiveWidth(6),
                            ),
                            Expanded(
                              child: Text(
                                widget.list[i].lookupDetHierDescEn ?? "",
                                style: TextStyle(
                                    fontSize: responsiveFont(14.0),
                                    fontWeight: selectedIndex == i
                                        ? FontWeight.bold
                                        : FontWeight.w500),
                              ),
                            ),
                            const Spacer(),
                            if (selectedIndex == i)
                              Icon(
                                Icons.check_circle,
                                color: kPrimaryColor,
                                size: responsiveFont(14.0),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<dynamic> commonBottomSheet1(
  BuildContext context,
  Future Function(dynamic) onItemSelected,
  String bottomSheetTitle,
  List<dynamic> list,
  bool isVisible,
) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (c) => _CommonBottomSheetContent1(
      onItemSelected: onItemSelected,
      bottomSheetTitle: bottomSheetTitle,
      list: list,
      isVisible: isVisible,
    ),
  );
}

class _CommonBottomSheetContent1 extends StatefulWidget {
  final Function(dynamic) onItemSelected;
  final String bottomSheetTitle;
  final List<dynamic> list;
  final bool isVisible;

  const _CommonBottomSheetContent1({
    required this.onItemSelected,
    required this.bottomSheetTitle,
    required this.list,
    required this.isVisible,
  });

  @override
  State<_CommonBottomSheetContent1> createState() =>
      _CommonBottomSheetContent1State();
}

class _CommonBottomSheetContent1State
    extends State<_CommonBottomSheetContent1> {
  int? selectedIndex;
  TextEditingController txtContro = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(responsiveHeight(50)),
          topRight: Radius.circular(responsiveHeight(50)),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.bottomSheetTitle,
                  style: TextStyle(
                    fontSize: responsiveFont(17),
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel_presentation),
                ),
              ],
            ),
          ),
          Visibility(
            visible: widget.isVisible,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: kTextFieldBorder, width: 1),
                    borderRadius: BorderRadius.circular(responsiveHeight(60))),
                child: TypeAheadField<dynamic>(
                  controller: txtContro,
                  suggestionsCallback: (search) {
                    return widget.list.where((stakeHolder) {
                      final stakeHNameLower =
                          stakeHolder.lookupDetHierDescEn?.toLowerCase() ?? "";
                      final searchLower = search.toLowerCase();
                      return stakeHNameLower.contains(searchLower);
                    }).toList();
                  },
                  builder: (BuildContext context,
                      TextEditingController textController,
                      FocusNode focusNode) {
                    return TextField(
                        controller: textController,
                        focusNode: focusNode,
                        autofocus: true,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(left: 8, top: 12),
                          suffixIcon:
                              const Icon(Icons.search, color: kPrimaryColor),
                          border: InputBorder.none,
                          hintText: "Search ${widget.bottomSheetTitle}",
                        ));
                  },
                  itemBuilder: (context, stakeholder) {
                    bool isSelected =
                        widget.list.indexOf(stakeholder) == selectedIndex;
                    return Container(
                      decoration: BoxDecoration(
                        color: kContainerBack,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          children: [
                            isSelected
                                ? Icon(
                                    Icons.radio_button_checked,
                                    color: kPrimaryColor,
                                    size: responsiveFont(14.0),
                                  )
                                : Icon(
                                    Icons.circle_outlined,
                                    size: responsiveFont(14.0),
                                  ),
                            SizedBox(
                              width: responsiveWidth(6),
                            ),
                            Expanded(
                              child: Text(
                                stakeholder.lookupDetHierDescEn ?? "",
                                style: TextStyle(
                                  fontSize: responsiveFont(14.0),
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                            const Spacer(),
                            if (isSelected)
                              Icon(
                                Icons.check_circle,
                                color: kPrimaryColor,
                                size: responsiveFont(14.0),
                              ),
                          ],
                        ).paddingSymmetric(horizontal: 4, vertical: 2),
                      ),
                    );
                    // return ListTile(
                    //   title: Text(stakeholder.lookupDetHierDescEn ?? ""),
                    //   // subtitle: Text(city.country),
                    // );
                  },
                  onSelected: (dynamic selectedStakeH) {
                    txtContro.text = selectedStakeH.lookupDetHierDescEn ?? '';
                    setState(() {
                      // Move the selected item to the top of the list
                      int selectedIndex = widget.list.indexOf(selectedStakeH);
                      if (selectedIndex != -1) {
                        var selectedItem = widget.list.removeAt(selectedIndex);
                        widget.list.insert(0, selectedItem);
                        this.selectedIndex =
                            0; // Update the selectedIndex for the ListView
                      }
                    });
                    widget.onItemSelected(selectedStakeH);
                    Get.back();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.list.length,
              shrinkWrap: true,
              itemBuilder: (c, i) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = i;
                      });

                      widget.onItemSelected(widget.list[i]);
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: kContainerBack,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            selectedIndex == i
                                ? Icon(
                                    Icons.radio_button_checked,
                                    color: kPrimaryColor,
                                    size: responsiveFont(14.0),
                                  )
                                : Icon(
                                    Icons.circle_outlined,
                                    size: responsiveFont(14.0),
                                  ),
                            SizedBox(
                              width: responsiveWidth(6),
                            ),
                            Text(
                              widget.list[i].lookupDetHierDescEn ?? "",
                              style: TextStyle(
                                  fontSize: responsiveFont(14.0),
                                  fontWeight: selectedIndex == i
                                      ? FontWeight.bold
                                      : FontWeight.w500),
                            ),
                            const Spacer(),
                            if (selectedIndex == i)
                              Icon(
                                Icons.check_circle,
                                color: kPrimaryColor,
                                size: responsiveFont(14.0),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<dynamic> commonBottomSheets(
  BuildContext context,
  Function(dynamic) onItemSelected,
  String bottomSheetTitle,
  List<dynamic> list,
) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (c) => _CommonBottomSheetContents(
      onItemSelected: onItemSelected,
      bottomSheetTitle: bottomSheetTitle,
      list: list,
    ),
  );
}

class _CommonBottomSheetContents extends StatefulWidget {
  final Function(dynamic) onItemSelected;
  final String bottomSheetTitle;
  final List<dynamic> list;

  const _CommonBottomSheetContents({
    required this.onItemSelected,
    required this.bottomSheetTitle,
    required this.list,
  });

  @override
  State<_CommonBottomSheetContents> createState() =>
      _CommonBottomSheetContentsState();
}

class _CommonBottomSheetContentsState
    extends State<_CommonBottomSheetContents> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(responsiveHeight(50)),
          topRight: Radius.circular(responsiveHeight(50)),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.bottomSheetTitle,
                  style: TextStyle(
                    fontSize: responsiveFont(17),
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel_presentation),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.list.length,
              shrinkWrap: true,
              itemBuilder: (c, i) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = i;
                      });

                      widget.onItemSelected(widget.list[i]);
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: kContainerBack,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            selectedIndex == i
                                ? Icon(
                                    Icons.radio_button_checked,
                                    color: kPrimaryColor,
                                    size: responsiveFont(14.0),
                                  )
                                : Icon(
                                    Icons.circle_outlined,
                                    size: responsiveFont(14.0),
                                  ),
                            SizedBox(
                              width: responsiveWidth(6),
                            ),
                            Text(
                              widget.list[i].lookupDetDescEn ?? "",
                              style: TextStyle(
                                  fontSize: responsiveFont(14.0),
                                  fontWeight: selectedIndex == i
                                      ? FontWeight.bold
                                      : FontWeight.w500),
                            ),
                            const Spacer(),
                            if (selectedIndex == i)
                              Icon(
                                Icons.check_circle,
                                color: kPrimaryColor,
                                size: responsiveFont(14.0),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<dynamic> userBottomSheet(
  BuildContext context,
  Function(dynamic) onItemSelected,
  String bottomSheetTitle,
  List<dynamic> list,
) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (c) => SheetContents(
      onItemSelected: onItemSelected,
      bottomSheetTitle: bottomSheetTitle,
      list: list,
    ),
  );
}

class SheetContents extends StatefulWidget {
  final Function(dynamic) onItemSelected;
  final String bottomSheetTitle;
  final List<dynamic> list;

  const SheetContents({
    super.key,
    required this.onItemSelected,
    required this.bottomSheetTitle,
    required this.list,
  });

  @override
  State<SheetContents> createState() => SheetContentsState();
}

class SheetContentsState extends State<SheetContents> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(responsiveHeight(50)),
          topRight: Radius.circular(responsiveHeight(50)),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.bottomSheetTitle,
                  style: TextStyle(
                    fontSize: responsiveFont(17),
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel_presentation),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.list.length,
              shrinkWrap: true,
              itemBuilder: (c, i) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = i;
                      });

                      widget.onItemSelected(widget.list[i]);
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: kContainerBack,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            selectedIndex == i
                                ? Icon(
                                    Icons.radio_button_checked,
                                    color: kPrimaryColor,
                                    size: responsiveFont(14.0),
                                  )
                                : Icon(
                                    Icons.circle_outlined,
                                    size: responsiveFont(14.0),
                                  ),
                            SizedBox(
                              width: responsiveWidth(6),
                            ),
                            Text(
                              widget.list[i].fullName ?? "",
                              style: TextStyle(
                                  fontSize: responsiveFont(14.0),
                                  fontWeight: selectedIndex == i
                                      ? FontWeight.bold
                                      : FontWeight.w500),
                            ),
                            const Spacer(),
                            if (selectedIndex == i)
                              Icon(
                                Icons.check_circle,
                                color: kPrimaryColor,
                                size: responsiveFont(14.0),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<dynamic> createUserBottomSheet(
  BuildContext context,
  Function(dynamic) onItemSelected,
  String bottomSheetTitle,
  String fullName,
  String mobileNo,
  int? memberTypeId,
  List<dynamic> list,
  TextEditingController stakeH,
  TextEditingController loginName,
) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (c) => CreateUserBottomSheet(
      onItemSelected: onItemSelected,
      bottomSheetTitle: bottomSheetTitle,
      fullName: fullName,
      mobileNo: mobileNo,
      memberTypeId: memberTypeId,
      list: list,
      stakeH: stakeH,
      loginName: loginName,
    ),
  );
}

class CreateUserBottomSheet extends StatefulWidget {
  final Function(dynamic) onItemSelected;
  final String bottomSheetTitle;
  final String fullName;
  final String mobileNo;
  final int? memberTypeId;
  final List<dynamic> list;
  final TextEditingController stakeH;
  final TextEditingController loginName;

  const CreateUserBottomSheet({
    super.key,
    required this.onItemSelected,
    required this.bottomSheetTitle,
    required this.list,
    required this.stakeH,
    required this.loginName,
    required this.fullName,
    required this.mobileNo,
    this.memberTypeId,
  });

  @override
  State<CreateUserBottomSheet> createState() => CreateUserBottomSheetState();
}

class CreateUserBottomSheetState extends State<CreateUserBottomSheet> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    CampCreationController campCreationController = Get.find();

    return Container(
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(responsiveHeight(50)),
          topRight: Radius.circular(responsiveHeight(50)),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.bottomSheetTitle,
                  style: TextStyle(
                    fontSize: responsiveFont(17),
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel_presentation),
                ),
              ],
            ),
          ),
          SizedBox(
            height: responsiveHeight(20),
          ),
          AppRoundTextField(
            controller: widget.stakeH,
            inputType: TextInputType.text,
            onChange: (p0) {},
            onTap: () async {
              await commonBottomSheet(
                  context,
                  (p0) => {
                        widget.stakeH.text = p0.lookupDetHierDescEn,
                        campCreationController.selectedStakeHolder = p0,
                        setState(() {})
                      },
                  "Stakeholder Type",
                  widget.list,
                  isVisible: true);
            },
            // maxLength: 12,
            readOnly: true,
            label: RichText(
              text: const TextSpan(
                  text: 'Stakeholder Type',
                  style: TextStyle(color: kHintColor, fontFamily: Montserrat),
                  children: [
                    TextSpan(text: "*", style: TextStyle(color: Colors.red))
                  ]),
            ),
            hint: "",
            suffix: SizedBox(
              height: getProportionateScreenHeight(20),
              width: getProportionateScreenHeight(20),
              child: Center(
                child: Image.asset(
                  icArrowDownOrange,
                  height: getProportionateScreenHeight(20),
                  width: getProportionateScreenHeight(20),
                ),
              ),
            ),
          ),
          SizedBox(
            height: responsiveHeight(20),
          ),
          AppRoundTextField(
            controller: widget.loginName,
            inputStyle:
                TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
            inputType: TextInputType.text,
            onChange: (p0) {},
            label: RichText(
              text: const TextSpan(
                  text: 'Login Name',
                  style: TextStyle(color: kHintColor, fontFamily: Montserrat),
                  children: [
                    TextSpan(text: "*", style: TextStyle(color: Colors.red))
                  ]),
            ),
            hint: "",
          ),
          SizedBox(
            height: responsiveHeight(20),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppButton(
                    title: "Save",
                    onTap: () {
                      campCreationController.userCreation(
                          widget.loginName.text,
                          widget.fullName,
                          widget.mobileNo,
                          widget.memberTypeId);
                    },
                    iconData: Icon(
                      Icons.arrow_forward,
                      color: kWhiteColor,
                      size: responsiveHeight(24),
                    ),
                  ),
                ),
                SizedBox(
                  width: responsiveWidth(20),
                ),
                Expanded(
                  child: AppButton(
                    title: "Cancel",
                    onTap: () {
                      Get.back();
                    },
                    buttonColor: Colors.grey,
                    iconData: Icon(
                      Icons.arrow_forward,
                      color: kWhiteColor,
                      size: responsiveHeight(24),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Future<dynamic> locationNameBottomSheet(
  BuildContext context,
  Function(dynamic) onItemSelected,
  String bottomSheetTitle,
  List<dynamic> list,
  bool isVisible,
) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (c) => LocationNameBottomSheetContent(
      onItemSelected: onItemSelected,
      bottomSheetTitle: bottomSheetTitle,
      list: list,
      isVisible: isVisible,
    ),
  );
}

class LocationNameBottomSheetContent extends StatefulWidget {
  final Function(dynamic) onItemSelected;
  final String bottomSheetTitle;
  final List<dynamic> list;
  final bool isVisible;

  const LocationNameBottomSheetContent({
    super.key,
    required this.onItemSelected,
    required this.bottomSheetTitle,
    required this.list,
    required this.isVisible,
  });

  @override
  State<LocationNameBottomSheetContent> createState() =>
      LocationNameBottomSheetContentState();
}

class LocationNameBottomSheetContentState
    extends State<LocationNameBottomSheetContent> {
  int? selectedIndex;
  TextEditingController txtContro = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(responsiveHeight(50)),
          topRight: Radius.circular(responsiveHeight(50)),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.bottomSheetTitle,
                  style: TextStyle(
                    fontSize: responsiveFont(17),
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel_presentation),
                ),
              ],
            ),
          ),
          Visibility(
            visible: widget.isVisible,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: kTextFieldBorder, width: 1),
                    borderRadius: BorderRadius.circular(responsiveHeight(60))),
                child: TypeAheadField<dynamic>(
                  controller: txtContro,
                  suggestionsCallback: (search) {
                    return widget.list.where((stakeHolder) {
                      final stakeHNameLower =
                          stakeHolder.locationName?.toLowerCase() ?? "";
                      final searchLower = search.toLowerCase();
                      return stakeHNameLower.contains(searchLower);
                    }).toList();
                  },
                  builder: (BuildContext context,
                      TextEditingController textController,
                      FocusNode focusNode) {
                    return TextField(
                        controller: textController,
                        focusNode: focusNode,
                        autofocus: true,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(left: 8, top: 12),
                          suffixIcon:
                              const Icon(Icons.search, color: kPrimaryColor),
                          border: InputBorder.none,
                          hintText: "Search ${widget.bottomSheetTitle}",
                        ));
                  },
                  itemBuilder: (context, stakeholder) {
                    bool isSelected =
                        widget.list.indexOf(stakeholder) == selectedIndex;
                    return Container(
                      decoration: BoxDecoration(
                        color: kContainerBack,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          children: [
                            isSelected
                                ? Icon(
                                    Icons.radio_button_checked,
                                    color: kPrimaryColor,
                                    size: responsiveFont(14.0),
                                  )
                                : Icon(
                                    Icons.circle_outlined,
                                    size: responsiveFont(14.0),
                                  ),
                            SizedBox(
                              width: responsiveWidth(6),
                            ),
                            Expanded(
                              child: Text(
                                stakeholder.locationName ?? "",
                                style: TextStyle(
                                  fontSize: responsiveFont(14.0),
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                            const Spacer(),
                            if (isSelected)
                              Icon(
                                Icons.check_circle,
                                color: kPrimaryColor,
                                size: responsiveFont(14.0),
                              ),
                          ],
                        ).paddingSymmetric(horizontal: 4, vertical: 2),
                      ),
                    );
                    // return ListTile(
                    //   title: Text(stakeholder.lookupDetHierDescEn ?? ""),
                    //   // subtitle: Text(city.country),
                    // );
                  },
                  onSelected: (dynamic selectedStakeH) {
                    txtContro.text = selectedStakeH.locationName ?? '';
                    setState(() {
                      // Move the selected item to the top of the list
                      int selectedIndex = widget.list.indexOf(selectedStakeH);
                      if (selectedIndex != -1) {
                        var selectedItem = widget.list.removeAt(selectedIndex);
                        widget.list.insert(0, selectedItem);
                        this.selectedIndex =
                            0; // Update the selectedIndex for the ListView
                      }
                    });
                    widget.onItemSelected(selectedStakeH);
                    Get.back();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.list.length,
              shrinkWrap: true,
              itemBuilder: (c, i) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = i;
                      });

                      widget.onItemSelected(widget.list[i]);
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: kContainerBack,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            selectedIndex == i
                                ? Icon(
                                    Icons.radio_button_checked,
                                    color: kPrimaryColor,
                                    size: responsiveFont(14.0),
                                  )
                                : Icon(
                                    Icons.circle_outlined,
                                    size: responsiveFont(14.0),
                                  ),
                            SizedBox(
                              width: responsiveWidth(6),
                            ),
                            Text(
                              widget.list[i].locationName ?? "",
                              style: TextStyle(
                                  fontSize: responsiveFont(14.0),
                                  fontWeight: selectedIndex == i
                                      ? FontWeight.bold
                                      : FontWeight.w500),
                            ),
                            const Spacer(),
                            if (selectedIndex == i)
                              Icon(
                                Icons.check_circle,
                                color: kPrimaryColor,
                                size: responsiveFont(14.0),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<dynamic> commonLocationSheet(
    BuildContext context,
    Function(Map<String, dynamic>) onItemSelected,
    String bottomSheetTitle,
    List<Map<String, dynamic>> list) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (c) => Container(
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(responsiveHeight(50)),
                    topRight: Radius.circular(responsiveHeight(50)))),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        bottomSheetTitle,
                        style: TextStyle(
                            fontSize: responsiveFont(17),
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.cancel_presentation))
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.3,
                  child: BlocBuilder<MasterDataBloc, MasterDataState>(
                    builder: (context, state) {
                      return list != null
                          ? ListView.builder(
                              itemCount: list.length,
                              shrinkWrap: true,
                              itemBuilder: (c, i) => Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 12),
                                  child: InkWell(
                                    onTap: () {
                                      // var selectedItem = {'id': list[i]['location_master_id'], 'title': list[i]['lookup_det_hier_desc_en']};
                                      var selectedItem = {
                                        'id': list[i]['location_master_id'],
                                        'title': list[i]['location_name']
                                      };
                                      onItemSelected(selectedItem);
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: kContainerBack,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.circle_outlined),
                                            SizedBox(
                                              width: responsiveWidth(6),
                                            ),
                                            // Text(list[i]['lookup_det_hier_desc_en']),
                                            Text(list[i]['location_name']),
                                            const Spacer(),
                                            const Icon(
                                              Icons.check_circle,
                                              color: kPrimaryColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const Center(child: Text("Data Not Available"));
                    },
                  ),
                ),
              ],
            ),
          ));
}

Future<dynamic> commonStackholderSheet(
    BuildContext context,
    Function(Map<String, dynamic>) onItemSelected,
    String bottomSheetTitle,
    List<Map<String, dynamic>> list) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (c) => Container(
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(responsiveHeight(50)),
                    topRight: Radius.circular(responsiveHeight(50)))),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        bottomSheetTitle,
                        style: TextStyle(
                            fontSize: responsiveFont(17),
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.cancel_presentation))
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.3,
                  child: BlocBuilder<MasterDataBloc, MasterDataState>(
                    builder: (context, state) {
                      return list != null
                          ? ListView.builder(
                              itemCount: list.length,
                              shrinkWrap: true,
                              itemBuilder: (c, i) => Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 12),
                                  child: InkWell(
                                    onTap: () {
                                      // var selectedItem = {'id': list[i]['location_master_id'], 'title': list[i]['lookup_det_hier_desc_en']};
                                      var selectedItem = {
                                        'id': list[i]['lookup_det_hier_id'],
                                        'title': list[i]
                                            ['lookup_det_hier_desc_en']
                                      };
                                      onItemSelected(selectedItem);
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: kContainerBack,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.circle_outlined),
                                            SizedBox(
                                              width: responsiveWidth(6),
                                            ),
                                            // Text(list[i]['lookup_det_hier_desc_en']),
                                            Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.7,
                                                child: Text(
                                                  list[i][
                                                      'lookup_det_hier_desc_en'],
                                                  textAlign: TextAlign.start,
                                                  softWrap: true,
                                                )),
                                            const Spacer(),
                                            const Icon(
                                              Icons.check_circle,
                                              color: kPrimaryColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const Center(child: Text("Data Not Available"));
                    },
                  ),
                ),
              ],
            ),
          ));
}

Future<dynamic> commonDateTimeSheet(
    BuildContext context,
    Function(Map<String, dynamic>) onItemSelected,
    String bottomSheetTitle,
    List<Map<String, dynamic>> list) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      builder: (c) => Container(
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(responsiveHeight(50)),
                    topRight: Radius.circular(responsiveHeight(50)))),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        bottomSheetTitle,
                        style: TextStyle(
                            fontSize: responsiveFont(17),
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.cancel_presentation))
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.3,
                  child: BlocBuilder<MasterDataBloc, MasterDataState>(
                    builder: (context, state) {
                      return list != null
                          ? ListView.builder(
                              itemCount: list.length,
                              shrinkWrap: true,
                              itemBuilder: (c, i) => Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 12),
                                  child: InkWell(
                                    onTap: () {
                                      // var selectedItem = {'id': list[i]['location_master_id'], 'title': list[i]['lookup_det_hier_desc_en']};
                                      var selectedItem = {
                                        'id': list[i]['camp_create_request_id'],
                                        'title': list[i]['prop_camp_date']
                                      };
                                      onItemSelected(selectedItem);
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: kContainerBack,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.circle_outlined),
                                            SizedBox(
                                              width: responsiveWidth(6),
                                            ),
                                            // Text(list[i]['lookup_det_hier_desc_en']),
                                            Text(list[i]['prop_camp_date']),
                                            const Spacer(),
                                            const Icon(
                                              Icons.check_circle,
                                              color: kPrimaryColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const Center(child: Text("Data Not Available"));
                    },
                  ),
                ),
              ],
            ),
          ));
}

Future<dynamic> stakeHolderNameBottomSheet(
  BuildContext context,
  Function(dynamic) onItemSelected,
  String bottomSheetTitle,
  List<dynamic> list,
  bool isVisible,
) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (c) => StakeHolderNameBottomSheetContent(
      onItemSelected: onItemSelected,
      bottomSheetTitle: bottomSheetTitle,
      list: list,
      isVisible: isVisible,
    ),
  );
}

class StakeHolderNameBottomSheetContent extends StatefulWidget {
  final Function(dynamic) onItemSelected;
  final String bottomSheetTitle;
  final List<dynamic> list;
  final bool isVisible;

  const StakeHolderNameBottomSheetContent({
    super.key,
    required this.onItemSelected,
    required this.bottomSheetTitle,
    required this.list,
    required this.isVisible,
  });

  @override
  State<StakeHolderNameBottomSheetContent> createState() =>
      StakeHolderNameBottomSheetContentState();
}

class StakeHolderNameBottomSheetContentState
    extends State<StakeHolderNameBottomSheetContent> {
  int? selectedIndex;
  TextEditingController txtContro = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(responsiveHeight(50)),
          topRight: Radius.circular(responsiveHeight(50)),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.bottomSheetTitle,
                  style: TextStyle(
                    fontSize: responsiveFont(17),
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel_presentation),
                ),
              ],
            ),
          ),
          Visibility(
            visible: widget.isVisible,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: kTextFieldBorder, width: 1),
                    borderRadius: BorderRadius.circular(responsiveHeight(60))),
                child: TypeAheadField<dynamic>(
                  controller: txtContro,
                  suggestionsCallback: (search) {
                    return widget.list.where((stakeHolder) {
                      final stakeHNameLower =
                          stakeHolder.stakeholderNameEn?.toLowerCase() ?? "";
                      final searchLower = search.toLowerCase();
                      return stakeHNameLower.contains(searchLower);
                    }).toList();
                  },
                  builder: (BuildContext context,
                      TextEditingController textController,
                      FocusNode focusNode) {
                    return TextField(
                        controller: textController,
                        focusNode: focusNode,
                        autofocus: true,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(left: 8, top: 12),
                          suffixIcon:
                              const Icon(Icons.search, color: kPrimaryColor),
                          border: InputBorder.none,
                          hintText: "Search ${widget.bottomSheetTitle}",
                        ));
                  },
                  itemBuilder: (context, stakeholder) {
                    bool isSelected =
                        widget.list.indexOf(stakeholder) == selectedIndex;
                    return Container(
                      decoration: BoxDecoration(
                        color: kContainerBack,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          children: [
                            isSelected
                                ? Icon(
                                    Icons.radio_button_checked,
                                    color: kPrimaryColor,
                                    size: responsiveFont(14.0),
                                  )
                                : Icon(
                                    Icons.circle_outlined,
                                    size: responsiveFont(14.0),
                                  ),
                            SizedBox(
                              width: responsiveWidth(6),
                            ),
                            Expanded(
                              child: Text(
                                stakeholder.stakeholderNameEn ?? "",
                                style: TextStyle(
                                  fontSize: responsiveFont(14.0),
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                            const Spacer(),
                            if (isSelected)
                              Icon(
                                Icons.check_circle,
                                color: kPrimaryColor,
                                size: responsiveFont(14.0),
                              ),
                          ],
                        ).paddingSymmetric(horizontal: 4, vertical: 2),
                      ),
                    );
                  },
                  onSelected: (dynamic selectedStakeH) {
                    txtContro.text = selectedStakeH.stakeholderNameEn ?? '';
                    setState(() {
                      // Move the selected item to the top of the list
                      int selectedIndex = widget.list.indexOf(selectedStakeH);
                      if (selectedIndex != -1) {
                        var selectedItem = widget.list.removeAt(selectedIndex);
                        widget.list.insert(0, selectedItem);
                        this.selectedIndex =
                            0; // Update the selectedIndex for the ListView
                      }
                    });
                    widget.onItemSelected(selectedStakeH);
                    Get.back();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.list.length,
              shrinkWrap: true,
              itemBuilder: (c, i) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = i;
                      });

                      widget.onItemSelected(widget.list[i]);
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: kContainerBack,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            selectedIndex == i
                                ? Icon(
                                    Icons.radio_button_checked,
                                    color: kPrimaryColor,
                                    size: responsiveFont(14.0),
                                  )
                                : Icon(
                                    Icons.circle_outlined,
                                    size: responsiveFont(14.0),
                                  ),
                            SizedBox(
                              width: responsiveWidth(6),
                            ),
                            Container(
                              width: SizeConfig.screenWidth * 0.7,
                              child: Text(
                                widget.list[i].stakeholderNameEn ?? "",
                                softWrap: true,
                                style: TextStyle(
                                    fontSize: responsiveFont(14.0),
                                    fontWeight: selectedIndex == i
                                        ? FontWeight.bold
                                        : FontWeight.w500),
                              ),
                            ),
                            const Spacer(),
                            if (selectedIndex == i)
                              Icon(
                                Icons.check_circle,
                                color: kPrimaryColor,
                                size: responsiveFont(14.0),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<dynamic> multiSelectBottomSheet(
  BuildContext context,
  Function(List<dynamic>) onItemsSelected, // Callback for selected items
  String bottomSheetTitle,
  List<dynamic> list,
) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (c) => _MultiSelectBottomSheetContent(
      onItemsSelected: onItemsSelected,
      bottomSheetTitle: bottomSheetTitle,
      list: list,
    ),
  );
}

class _MultiSelectBottomSheetContent extends StatefulWidget {
  final Function(List<dynamic>) onItemsSelected;
  final String bottomSheetTitle;
  final List<dynamic> list;

  final CampDetailsController campDetailsController =
      Get.put(CampDetailsController());

  _MultiSelectBottomSheetContent({
    required this.onItemsSelected,
    required this.bottomSheetTitle,
    required this.list,
  });

  @override
  _MultiSelectBottomSheetContentState createState() =>
      _MultiSelectBottomSheetContentState();
}

class _MultiSelectBottomSheetContentState
    extends State<_MultiSelectBottomSheetContent> {
  List<dynamic> selectedItems = [];
  List<dynamic> selectedItemsName = [];
  List<dynamic> selectedItemsId = [];

  void _onItemTapped(dynamic item) {
    setState(() {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      } else {
        selectedItems.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    CampDetailsController campDetailsController = Get.find();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            widget.bottomSheetTitle,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        widget.list.isEmpty
            ? Container(
                width: SizeConfig.screenWidth * 0.8,
                height: SizeConfig.screenHeight * 0.2,
                child: Center(
                    child: Text("Stakeholder Not Available,Try again later")),
              )
            : Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.list.length,
                  itemBuilder: (context, index) {
                    final item = widget.list[index];
                    final isSelected = selectedItems.contains(item);
                    return ListTile(
                      title: Text(item['stakeholder_name_en'].toString()),
                      trailing: isSelected
                          ? Icon(Icons.check_box)
                          : Icon(Icons.check_box_outline_blank),
                      onTap: () => _onItemTapped(item),
                    );
                  },
                ),
              ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            child: widget.list.isEmpty ? Text('Cancel') : Text('Confirm'),
            onPressed: () {
              widget.onItemsSelected(selectedItems);
              if (selectedItems.isNotEmpty) {
                campDetailsController.createMultiStakeholderJson(selectedItems);
              }

              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}

class City {
  final String name;
  final String country;

  City({required this.name, required this.country});
}

class CityService {
  static List<City> getCities() {
    return [
      City(name: 'New York', country: 'USA'),
      City(name: 'Los Angeles', country: 'USA'),
      City(name: 'Chicago', country: 'USA'),
      City(name: 'London', country: 'UK'),
      City(name: 'Berlin', country: 'Germany'),
      City(name: 'Paris', country: 'France'),
    ];
  }

  static List<City> find(String query) {
    return getCities().where((city) {
      final cityNameLower = city.name.toLowerCase();
      final searchLower = query.toLowerCase();
      return cityNameLower.contains(searchLower);
    }).toList();
  }
}
