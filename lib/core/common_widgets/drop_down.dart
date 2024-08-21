import 'package:community_health_app/core/common_bloc/bloc/master_data_bloc.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  height: SizeConfig.screenHeight * 0.5,
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
                        List<Map<String, dynamic>> list = [
                          {"title": "Hospital", "id": 1},
                          {"title": "NGO", "id": 2},
                          {"title": "STEM", "id": 3},
                          {"title": "USER", "id": 4}
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
