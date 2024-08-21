import 'package:community_health_app/core/common_bloc/bloc/master_data_bloc.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
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
                  child: Text(
                    "Select Gender",
                    style: TextStyle(
                        fontSize: responsiveFont(17),
                        fontWeight: FontWeight.bold),
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


Future<dynamic> commonBottonSheet(
    BuildContext context, Function(Map<String, dynamic>) onItemSelected,String bottomSheetTitle,List<Map<String, dynamic>> list) {
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
              padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    bottomSheetTitle,
                    style: TextStyle(
                        fontSize: responsiveFont(17),
                        fontWeight: FontWeight.bold,color: kPrimaryColor),
                  ),
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.cancel_presentation))
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
                        padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 12),
                        child: InkWell(
                          onTap: onItemSelected(list[i]),
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
                                  SizedBox(width: responsiveWidth(6),),
                                  Text(list[i]['title']),
                                  const Spacer(),
                                  const Icon(Icons.check_circle,color: kPrimaryColor,),

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