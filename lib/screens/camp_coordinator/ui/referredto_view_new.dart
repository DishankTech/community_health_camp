import 'dart:convert';

import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/common_widgets/app_button.dart';
import 'package:community_health_app/core/common_widgets/app_round_textfield.dart';
import 'package:community_health_app/core/common_widgets/drop_down.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/fonts.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/utilities/data_provider.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/camp_coordinator/controller/camp_details_controller.dart';
import 'package:community_health_app/screens/location_master/model/country/country_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/routes/app_routes.dart';
import '../models/camp_coordinator_registered_patient_model.dart';
import 'package:http/http.dart' as http;

import '../models/multiple_referred_to_request_model.dart';

class NewReferredToScreen extends StatefulWidget {
  const NewReferredToScreen({super.key});

  @override
  State<NewReferredToScreen> createState() => _ReferredToScreenState();
}

class _ReferredToScreenState extends State<NewReferredToScreen> {
  XFile? capturedFile;
  List<CardData> carbonCommentsList = [];

  TextEditingController patientNameController = TextEditingController();
  TextEditingController listpatientNameController = TextEditingController();

  TextEditingController referredTo = TextEditingController();
  TextEditingController referredToId = TextEditingController();
  TextEditingController stakeholderSubType = TextEditingController();
  TextEditingController stakeholderSubTypeId = TextEditingController();

  Map<String, dynamic>? selectedDesignationType;
  Map<String, dynamic>? selecteStakeholderSubType;


  List<CampCoordRegisteredPatientModel> campregisteredpatients = [];

  bool isLoading = false;

  List<Map<String, dynamic>> extractedStackholderData = [];
  List<Map<String, dynamic>> extractedStackholderSubType = [];

  List selectedItems = [];
  List selectedItemsString = [];

  final CampDetailsController campDetailsController = Get.put(CampDetailsController());

  CountryModel? stakeHolderModel;

  List<Widget> _widgetList = [];

  List<TextEditingController> referredToControllers = [];
  List<TextEditingController> referredToIdControllers = [];
  List<TextEditingController> stakeholderSubTypeControllers = [];
  List<TextEditingController> stakeholderSubTypeIdControllers = [];



  @override
  void initState() {
    // TODO: implement initState
    patientNameController.text = "";
    referredTo.text = "";
    // carbonCommentsList.add(CardData(""));
    clearAllFields();

    _widgetList = [];
    campregisteredpatients = [];

    _addDynamicWidget();
    getStakeholderSubType();
    // getStakeholdersDetails();

    super.initState();
    stakeholderSubType = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Change to your desired color
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light, // For light text/icons on the status bar
    ));

    return Scaffold(
      body: Container(
        height: SizeConfig.designScreenHeight,
        width: SizeConfig.designScreenWidth,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(patRegBg), fit: BoxFit.fill),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                mAppBarV1(
                  title: "Add Referred Patient",
                  context: context,
                  onBackButtonPress: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: responsiveHeight(10),
                ),
                Expanded(
                  child: _widgetList.isNotEmpty
                      ? ListView.builder(
                    padding: EdgeInsets.only(bottom: responsiveHeight(80)), // Bottom padding for ListView
                    itemCount: _widgetList.length,
                    itemBuilder: (context, index) => _widgetList[index],
                  )
                      : Center(child: Text("No data available")),
                ),
              ],
            ),
            Positioned(
              bottom: responsiveHeight(20),
              left: 0,
              right: 0,
              child:  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: AppButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: "Save",
                        iconData: Icon(
                          Icons.arrow_back_outlined,
                          color: kWhiteColor,
                          size: responsiveHeight(24),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: responsiveWidth(60),
                    ),
                    Flexible(
                      flex: 1,
                      child: AppButton(
                        onTap: () {
                          clearAllFields();
                        },
                        title: "Clear",
                        buttonColor: Colors.grey,
                        iconData: Icon(
                          Icons.arrow_forward,
                          color: kWhiteColor,
                          size: responsiveHeight(24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  void addCard() {
    // carbonCommentsList.add(CardData(""));
    setState(() {


      // referredToControllers.add(TextEditingController());
      // stakeholderSubTypeControllers.add(TextEditingController());
      // stakeholderSubTypeIdControllers.add(TextEditingController());

      patientNameController.text = "";
      referredTo.text = "";
      referredToId.text = "";
      stakeholderSubType.text = "";
      stakeholderSubTypeId.text = "";
      campDetailsController.patientsReferred.text = campDetailsController.campReferredPatientList.length.toString();
      campDetailsController.campReferredPatientStakeholderList.clear();
    });
  }

  void removeCard(int index) {
    if (campDetailsController.campReferredPatientList.isNotEmpty) {
      setState(() {
        print(index);

        referredToControllers[index].dispose();
        stakeholderSubTypeControllers[index].dispose();
        stakeholderSubTypeIdControllers[index].dispose();

        referredToIdControllers[index].dispose();
        referredToIdControllers[index].dispose();

        stakeholderSubTypeControllers.removeAt(index);
        stakeholderSubTypeIdControllers.removeAt(index);

        referredToControllers.removeAt(index);
        referredToIdControllers.removeAt(index);

        if (index >= 0 && index < campDetailsController.campReferredPatientList.length) {
          setState(() {
            campDetailsController.campReferredPatientList.removeAt(index);
            print(campregisteredpatients);
          });
        } else {
          print("Invalid index: $index");
        }

        // campregisteredpatients.removeAt(index);
        // campDetailsController.campReferredPatientList.removeAt(index);
        print(campregisteredpatients);
        // carbonCommentsList.removeAt(index);
      });
    }
  }

  getStakeholderSubType() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse('http://210.89.42.117:8085/api/common/lookup/lookupDetCode');
    // var headers = {'Content-Type': 'application/json'};
    try {
      // final response = await http.post(url);
      final Map<String, dynamic> body = {
        "lookup_det_code_list1": [
          {"lookup_det_code": "SUY"}
        ]
      };

      String jsonbody = json.encode(body);
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      http.Response response = await http.post(url, headers: headers, body: jsonbody);
      print(response);

      if (response.statusCode == 200) {
        Map<String, dynamic> decodedJson = jsonDecode(response.body);

        // var detailsArray = decodedJson['details'];
        //  List<dynamic> dataArray = detailsArray['lookup_det_hierarchical'];

        stakeHolderModel = CountryModel.fromJson(decodedJson);

        setState(() {
          isLoading = false;
        });

        print(stakeHolderModel);
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      throw Exception('Exception occurred: $e');
    }
  }

  Future<List> getStakeholdersDetails(String subtypeId) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse('http://210.89.42.117:8085/api/administrator/masters/dropdown/stake-holder-by-sub-type-list/$subtypeId');
    var headers = {'Content-Type': 'application/json'};
    try {

      print(url);

      http.Response response = await http.post(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> decodedJson = jsonDecode(response.body);

        List<dynamic> detailsArray = decodedJson['details'];

        setState(() {
          isLoading = false;
        });

        extractedStackholderData = detailsArray.map((item) {
          return {
            'stakeholder_master_id': item['stakeholder_master_id'],
            'stakeholder_name_en': item['stakeholder_name_en'].toString(),
          };
        }).toList();
        print(extractedStackholderData);
        return extractedStackholderData;
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      throw Exception('Exception occurred: $e');
    }
  }

  /*Future<void> sendPostRequest() async {
    setState(() {
      isLoading = true;
    });

    for (int i = 0; i < campregisteredpatients.length; i++) {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = json.encode({
        "tt_camp_dashboard_ref_patients_list": [
          {
            "dashboard_ref_patients_id": null,
            "camp_dashboard_id": null,
            "patient_id": null,
            "patient_name": campregisteredpatients[i].name,
            "age": 0,
            "lookup_det_id_gender": null,
            "contact_number": campregisteredpatients[i].mobile,
            "org_id": 1,
            "status": 1,
            "tt_camp_dashboard_ref_patients_det_list": [
              {
                "dashboard_ref_patients_det_id": null,
                "dashboard_ref_patients_id": null,
                "lookup_det_hier_id_stakeholder_sub_type2": null,
                "stakeholder_master_id": int.parse(campregisteredpatients[i].referredToId.toString()),
                "org_id": 1,
                "status": 1
              }
            ]
          }
        ]
      });
      print(body);
      var response = await http.post(
        Uri.parse('http://210.89.42.117:8085/api/administrator/masters/add/dashboard-patient-ref-details'),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print(response.body);
        final data = json.decode(response.body);
        if (data['status_code'] == 200) {
          setState(() {
            campregisteredpatients.removeAt(i);
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Patients Saved Successfully',
              ),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
          // Navigator.pushNamed(context, AppRoutes.campCoordinator);
        }
      } else {
        print('Request failed with status: ${response.statusCode}. ${response.reasonPhrase}');
      }
    }
  }*/

  void clearAllFields() {
    setState(() {
      campregisteredpatients.clear();
      patientNameController.text = "";
      stakeholderSubType.text = "";
      stakeholderSubTypeId.text = "";
      referredTo.text = "";
      referredToId.text = "";

      referredToControllers.forEach((controller) => controller.clear());
      stakeholderSubTypeControllers.forEach((controller) => controller.clear());
    });
  }

  void _addDynamicWidget() {
    setState(() {
      stakeholderSubTypeControllers.add(TextEditingController());
      stakeholderSubTypeIdControllers.add(TextEditingController());

      referredToControllers.add(TextEditingController());
      referredToIdControllers.add(TextEditingController());
      _widgetList.add(buildDynamicWidget(_widgetList.length));
    });
  }

  Widget buildDynamicWidget(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.all(10),
        width: SizeConfig.screenWidth * 0.8,
        // height: SizeConfig.screenHeight /7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(responsiveHeight(25)),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey, // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 7, // Blur radius
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: responsiveHeight(20),
            ),
            AppRoundTextField(
              controller: stakeholderSubTypeControllers[index],
              // controller: stakeholderSubType,
              inputType: TextInputType.none,
              onChange: (p0) {},
              onTap: () async {
                await commonBottomSheet(
                    context,
                    (p0) => {
                          // stakeholderSubTypeControllers[index].text = p0.lookupDetHierDescEn,
                          // stakeholderSubTypeId.text = p0.lookupDetHierId.toString(),
                          // campCreationController.selectedStakeHolder = p0,
                          setState(() {
                            stakeholderSubTypeControllers[index].text = p0.lookupDetHierDescEn; // Set the text property of the controller
                            stakeholderSubTypeIdControllers[index].text = p0.lookupDetHierId.toString(); // Set the text property of the controller

                            campDetailsController.stakeHolderSubTypeId =p0.lookupDetHierId;
                            getStakeholdersDetails(p0.lookupDetHierId.toString());
                          })
                        },
                    "Stakeholder Type",
                    stakeHolderModel?.details?.first.lookupDetHierarchical ?? []);
              },
              // maxLength: 12,
              readOnly: true,
              label: RichText(
                text: const TextSpan(text: 'Stakeholder Type', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
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
              height: responsiveHeight(30),
            ),
            AppRoundTextField(
              // controller: referredTo,
              controller: referredToControllers[index],
              maxLines: 3,
              inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
              onChange: (p0) {},
              onTap: () async {
                //multi select

                await multiSelectBottomSheet(
                  context,
                  (List<dynamic> items) {
                    setState(() {
                      selectedItems = items;



                        for (int i = 0; i < selectedItems.length; i++) {
                          // Create a new map for each referredTo entry
                          Map<String, dynamic> patientData = {
                            "dashboard_ref_patients_det_id": null,
                            "dashboard_ref_patients_id": null,
                            "lookup_det_hier_id_stakeholder_sub_type2":stakeholderSubTypeIdControllers[index].text.toString(),
                            "stakeholder_master_id": selectedItems[i]["stakeholder_master_id"],
                            "org_id": 1,
                            "status": 1,
                          };

                          // Add the generated map to the list
                        campDetailsController.ttCampDashboardRefPatientsDetList.add(patientData);

                      }





                      referredToId.text = selectedItems.map((item) => item['stakeholder_master_id']).join(', ');
                      referredTo.text = selectedItems.map((item) => item['stakeholder_name_en']).join(', ');

                      referredToControllers[index].text=(referredTo.text);
                      referredToIdControllers[index].text=(referredToId.text);


                        // Create a new map for each referredTo entry
                        Map<String, dynamic> patientData = {
                          "dashboard_ref_patients_det_id": null,
                          "dashboard_ref_patients_id": null,
                          "lookup_det_hier_id_stakeholder_sub_type2":stakeholderSubTypeControllers[index].text.toString(),
                          "stakeholder_master_id": referredTo.text,
                          "org_id": 1,
                          "status": 1,
                        };

                        // Add the generated map to the list
                        campDetailsController.ttCampDashboardRefPatientsNamesList.add(patientData);



                      // referredTo.text = selectedItems.join(', ');
                    });
                  },
                  "Referred To",
                  extractedStackholderData, // Example items
                );
              },
              readOnly: true,
              label: RichText(
                text: const TextSpan(text: 'Referred To', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
              ),
              hint: "",
              suffix: SizedBox(
                height: responsiveHeight(20),
                width: responsiveHeight(20),
                child: Center(
                  child: Image.asset(
                    icArrowDownOrange,
                    height: responsiveHeight(20),
                    width: responsiveHeight(20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    child: Image.asset("assets/icons/add.png"),
                    onTap: () {
                      _addDynamicWidget();
                      // addCard();
                    },
                  ),
                  SizedBox(
                    width: responsiveWidth(10),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }




}

class CardData {
  String? cardTitle;

  CardData(this.cardTitle);
}
