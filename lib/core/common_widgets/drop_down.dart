import 'dart:convert';

import 'package:community_health_app/core/common_bloc/bloc/master_data_bloc.dart';
import 'package:community_health_app/core/common_bloc/models/master_response_model.dart';
import 'package:community_health_app/core/common_widgets/app_button.dart';
import 'package:community_health_app/core/common_widgets/app_round_textfield.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/fonts.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/camp_creation/camp_creation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

Future<dynamic> genderBottomSheet(
    BuildContext context, Function(Map<String, dynamic>) onItemSelected) {
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
                  // height: SizeConfig.screenHeight * 0.5,
                  child: BlocBuilder<MasterDataBloc, MasterDataState>(
                    builder: (context, state) {
                      List<Map<String, dynamic>> list = [
                        {"title": "Male", "id": 1},
                        {"title": "Female", "id": 2}
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
                                      Navigator.pop(context);
                                    },
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: kTextFieldBorder,
                                            width: 0.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(list[i]['title']),
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

Future<dynamic> stakeholderBottomSheet(
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
                        MasterResponseModel responseModel =
                            MasterResponseModel.fromJson(
                                jsonDecode(state.getMasterResponse));

                        return responseModel.details != null &&
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
                                            'id': responseModel.details![0]
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
                                                Text(responseModel
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
                          {"title": "Active", "id": 1},
                          {"title": "In Active", "id": 2},
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
) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (c) => _CommonBottomSheetContent(
      onItemSelected: onItemSelected,
      bottomSheetTitle: bottomSheetTitle,
      list: list,
    ),
  );
}

class _CommonBottomSheetContent extends StatefulWidget {
  final Function(dynamic) onItemSelected;
  final String bottomSheetTitle;
  final List<dynamic> list;

  const _CommonBottomSheetContent({
    required this.onItemSelected,
    required this.bottomSheetTitle,
    required this.list,
  });

  @override
  State<_CommonBottomSheetContent> createState() =>
      _CommonBottomSheetContentState();
}

class _CommonBottomSheetContentState extends State<_CommonBottomSheetContent> {
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
          SizedBox(
            height: SizeConfig.screenHeight * 0.3,
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

Future<dynamic> commonBottomSheet1(
  BuildContext context,
  Future Function(dynamic) onItemSelected,
  String bottomSheetTitle,
  List<dynamic> list,
) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (c) => _CommonBottomSheetContent1(
      onItemSelected: onItemSelected,
      bottomSheetTitle: bottomSheetTitle,
      list: list,
    ),
  );
}

class _CommonBottomSheetContent1 extends StatefulWidget {
  final Function(dynamic) onItemSelected;
  final String bottomSheetTitle;
  final List<dynamic> list;

  const _CommonBottomSheetContent1({
    required this.onItemSelected,
    required this.bottomSheetTitle,
    required this.list,
  });

  @override
  State<_CommonBottomSheetContent1> createState() =>
      _CommonBottomSheetContent1State();
}

class _CommonBottomSheetContent1State
    extends State<_CommonBottomSheetContent1> {
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
          SizedBox(
            height: SizeConfig.screenHeight * 0.3,
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
          SizedBox(
            height: SizeConfig.screenHeight * 0.3,
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
          SizedBox(
            height: SizeConfig.screenHeight * 0.3,
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
    List<dynamic> list,
    TextEditingController stakeH,
    TextEditingController loginName) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (c) => CreateUserBottomSheet(
      onItemSelected: onItemSelected,
      bottomSheetTitle: bottomSheetTitle,
      list: list,
      stakeH: stakeH,
      loginName: loginName,
    ),
  );
}

class CreateUserBottomSheet extends StatefulWidget {
  final Function(dynamic) onItemSelected;
  final String bottomSheetTitle;
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
                        // controller
                        //     .selectedStakeHVal =
                        //     p0.lookupDetHierDescEn,
                        // controller
                        //     .selectedStakeH = p0,
                        // controller
                        //     .stakeHolderController
                        //     .text = controller
                        //     .selectedStakeHVal ??
                        //     "",
                        // controller.update()
                      },
                  "Stakeholder Type",
                  widget.list);
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
                      campCreationController.userCreation(widget.loginName.text);
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
                    onTap: (){
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
