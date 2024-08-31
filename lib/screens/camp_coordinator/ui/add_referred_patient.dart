import 'dart:convert';

import 'package:community_health_app/core/common_widgets/app_bar_v1.dart';
import 'package:community_health_app/core/common_widgets/app_button.dart';
import 'package:community_health_app/core/common_widgets/app_round_textfield.dart';
import 'package:community_health_app/core/common_widgets/drop_down.dart';
import 'package:community_health_app/core/constants/constants.dart';
import 'package:community_health_app/core/constants/fonts.dart';
import 'package:community_health_app/core/constants/images.dart';
import 'package:community_health_app/core/utilities/cust_toast.dart';
import 'package:community_health_app/core/utilities/size_config.dart';
import 'package:community_health_app/screens/camp_coordinator/controller/camp_details_controller.dart';
import 'package:community_health_app/screens/camp_coordinator/models/camp_dropdown_resp_model.dart';
import 'package:community_health_app/screens/location_master/model/country/country_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/routes/app_routes.dart';
import '../models/camp_coordinator_registered_patient_model.dart';
import 'package:http/http.dart' as http;

import '../models/multiple_referred_to_request_model.dart';
import '../models/tt_camp_dashboard_ref_patients_list.dart';

class AddReferredPatient extends StatefulWidget {
  const AddReferredPatient({super.key});

  @override
  State<AddReferredPatient> createState() => _AddReferredPatientState();
}

class _AddReferredPatientState extends State<AddReferredPatient> {
  XFile? capturedFile;
  List<CardData> carbonCommentsList = [];

  // TextEditingController patientNameController = TextEditingController();
  TextEditingController referredPatientCount = TextEditingController();
  TextEditingController referredPatientPendingCount = TextEditingController();
  TextEditingController listpatientNameController = TextEditingController();

  TextEditingController campName = TextEditingController();
  TextEditingController campId = TextEditingController();

  Map<String, dynamic>? selectedDesignationType;
  Map<String, dynamic>? selecteStakeholderSubType;

  // TextEditingController countryCodeController = TextEditingController();

  Map<String, dynamic>? selectedCountryCode;

  // TextEditingController mobileController = TextEditingController();

  Map<String, dynamic>? selectedMobile;

/*  List<CampCoordRegisteredPatientModel> campregisteredpatients = [];*/

  bool isLoading = false;

  List<Map<String, dynamic>> extractedStackholderData = [];
  List<Map<String, dynamic>> extractedStackholderSubType = [];

  List selectedItems = [];
  List selectedItemsString = [];

  final CampDetailsController campDetailsController = Get.put(CampDetailsController());

  CountryModel? stakeHolderModel;
  CampDropdownRespModel? _referredCampDetails;

  List<Widget> _widgetList = [];

  List<TextEditingController> patientNameListController = [];
  List<TextEditingController> mobileNoListCOntroller = [];
  List<TextEditingController> countryCodeListController = [];

  bool isEmpty = true;

  @override
  void initState() {
    // TODO: implement initState
    // patientNameController.text = "";
    // countryCodeController.text = "";
    // mobileController.text = "";

    // referredPatientCount.text = "0";
    // referredPatientPendingCount.text = "0";

    // carbonCommentsList.add(CardData(""));
    // clearAllFields();
    getStakeholderSubType();
    getCampsDetailsDropdown();
    // getStakeholdersDetails();

    _addDynamicWidget();

    super.initState();
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
      body: SingleChildScrollView(
        child: Container(
          // height: SizeConfig.designScreenHeight,
          width: SizeConfig.designScreenWidth,
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(patRegBg), fit: BoxFit.fill)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              mAppBarV1(
                  title: "Add Referred Patient",
                  context: context,
                  onBackButtonPress: () {
                    Navigator.pop(context);
                  }),
              SizedBox(
                height: responsiveHeight(10),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: SizeConfig.screenWidth * 0.95,
                  // height: SizeConfig.screenHeight /3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(responsiveHeight(25)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 7, // Blur radius
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isLoading
                        ? Container(
                            width: SizeConfig.designScreenWidth,
                            height: SizeConfig.screenHeight * 0.7,
                            color: Colors.black.withOpacity(0.3), // Semi-transparent overlay
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(color: Colors.red),
                                SizedBox(height: 10),
                                Text(
                                  'Please wait..',
                                  style: TextStyle(
                                    color: Colors.white, // Text color for visibility
                                    fontFamily: Montserrat,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Column(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: responsiveHeight(20),
                                    ),
                                    AppRoundTextField(
                                      controller: campName,
                                      inputType: TextInputType.text,
                                      onChange: (p0) {},
                                      onTap: () async {
                                        await commonReferredCampBottomSheet(
                                            context,
                                            (p0) => {
                                                  campName.text = p0.campNumber.toString(),
                                                  campId.text = p0.campDashboardId.toString(),
                                                  // campCreationController.selectedStakeHolder = p0,
                                                  setState(() {
                                                    campDetailsController.camDashboardId=p0.campDashboardId.toString();

                                                    referredPatientCount.text = p0.referredPatients.toString();
                                                  })
                                                },
                                            "Camp",
                                            _referredCampDetails?.details ?? []);
                                      },
                                      // maxLength: 12,
                                      readOnly: true,
                                      label: RichText(
                                        text: const TextSpan(
                                            text: 'Camp', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
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
                                      readOnly: true,
                                      controller: referredPatientCount,
                                      inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
                                      inputType: TextInputType.none,
                                      onChange: (p0) {},
                                      label: RichText(
                                        text: const TextSpan(
                                            text: 'Total Referred Patient',
                                            style: TextStyle(color: kHintColor, fontFamily: Montserrat),
                                            children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
                                      ),
                                      hint: "",
                                    ),
                                    SizedBox(
                                      height: responsiveHeight(20),
                                    ),
                                    AppRoundTextField(
                                      readOnly: true,
                                      controller: referredPatientPendingCount,
                                      inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
                                      inputType: TextInputType.none,
                                      onChange: (p0) {},
                                      label: RichText(
                                        text: const TextSpan(
                                            text: "Total Referred Patient's Details Pending",
                                            style: TextStyle(color: kHintColor, fontFamily: Montserrat),
                                            children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
                                      ),
                                      hint: "",
                                    ),
                                    SizedBox(
                                      height: responsiveHeight(5),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: SizeConfig.designScreenHeight* 0.5,
                                width: SizeConfig.designScreenWidth,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        padding: EdgeInsets.only(bottom: responsiveHeight(80)), // Bottom padding for ListView
                                        itemCount: _widgetList.length,
                                        itemBuilder: (context, index) => _widgetList[index],
                                      ),
                                    ),
                                    Padding(
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
                                    )
                                  ],
                                ),
                              ),


                              /* AppRoundTextField(
                                controller: campName,
                                inputType: TextInputType.text,
                                onChange: (p0) {},
                                onTap: () async {
                                  await commonBottomSheet(
                                      context,
                                      (p0) => {
                                            campName.text = p0.lookupDetHierDescEn,
                                            campId.text = p0.lookupDetHierId.toString(),
                                            // campCreationController.selectedStakeHolder = p0,
                                            setState(() {
                                              getStakeholdersDetails(campId.text.toString());
                                            })
                                          },
                                      "Stakeholder Type",
                                      stakeHolderModel?.details?.first.lookupDetHierarchical ?? []);
                                },
                                // maxLength: 12,
                                readOnly: true,
                                label: RichText(
                                  text: const TextSpan(
                                      text: 'Stakeholder Type', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
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
                                controller: referredTo,
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
                                        referredToId.text = selectedItems.map((item) => item['stakeholder_master_id']).join(', ');
                                        referredTo.text = selectedItems.map((item) => item['stakeholder_name_en']).join(', ');

                                        // referredTo.text = selectedItems.join(', ');
                                      });
                                    },
                                    "Referred To",
                                    extractedStackholderData, // Example items
                                  );

                                  */ /*await  multiSelectBottomSheet(
                                      context,
                                      (p0) => {
                                            setState(() {
                                              // selectedDesignationType = p0 ;
                                              referredTo.text =
                                                  selectedDesignationType![
                                                      'title'];
                                              referredToId.text =
                                                  selectedDesignationType!['id']
                                                      .toString();
                                              print(referredToId.text);
                                            })
                                          },
                                      "Referred To",
                                      extractedStackholderData);*/ /*
                                },
                                readOnly: true,
                                label: RichText(
                                  text: const TextSpan(
                                      text: 'Referred To', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
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
                              ),*/
                            ],
                          ),
                  ),
                ),
              ),


              /*   Container(
                width: SizeConfig.screenWidth * 0.95,
                // height: SizeConfig.screenHeight /3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(responsiveHeight(25)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 7, // Blur radius
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      AppRoundTextField(
                        controller: patientNameController,
                        inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
                        inputType: TextInputType.name,
                        onChange: (p0) {},
                        label: RichText(
                          text: const TextSpan(text: 'Patient Name', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
                        ),
                        hint: "",
                      ),
                      SizedBox(
                        height: responsiveHeight(10),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AppRoundTextField(
                              controller: countryCodeController,
                              inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
                              // inputType: TextInputType.number,
                              onChange: (p0) {},
                              onTap: () {
                                List<Map<String, dynamic>> list = [
                                  {"title": "+91", "id": 1},
                                ];
                                commonBottonSheet(
                                    context,
                                    (p0) => {
                                          setState(() {
                                            selectedCountryCode = p0;
                                            countryCodeController.text = selectedCountryCode!['title'];
                                          })
                                        },
                                    "Country Code",
                                    list);
                              },
                              maxLength: 3,
                              readOnly: true,
                              label: RichText(
                                text: const TextSpan(
                                    text: 'Country Code', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
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
                          ),
                          SizedBox(
                            width: responsiveWidth(10),
                          ),
                          Expanded(
                            child: AppRoundTextField(
                              controller: mobileController,
                              inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
                              inputType: TextInputType.number,
                              onChange: (p0) {},
                              maxLength: 10,
                              label: RichText(
                                text: const TextSpan(
                                    text: 'Mobile No', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
                              ),
                              hint: "",
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: responsiveHeight(30),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            // width: MediaQuery.sizeOf(context).width * 0.4,
                            // margin: EdgeInsets.only(right: 15),
                            child: AppButton(
                              onTap: () {
                                _showDetailsDialog(context);
                                // Navigator.pushNamed(context, AppRoutes.referredTo);
                              },
                              mWidth: SizeConfig.screenWidth * 0.4,
                              title: "View Referred",
                              iconData: Icon(
                                Icons.remove_red_eye,
                                color: kWhiteColor,
                                size: responsiveHeight(24),
                              ),
                            ),
                          ),
                          Container(
                            // width: MediaQuery.sizeOf(context).width * 0.4,
                            // margin: EdgeInsets.only(right: 15),
                            child: AppButton(
                              onTap: () {
                                if (patientNameController.text.isEmpty || countryCodeController.text.isEmpty || mobileController.text.isEmpty) {
                                  CustomMessage.toast("Please fill Patient Details");
                                } else {
                                  Navigator.pushNamed(context, AppRoutes.referredTo);
                                }
                              },
                              mWidth: SizeConfig.screenWidth * 0.4,
                              title: "Add Referred to",
                              iconData: Icon(
                                Icons.arrow_forward,
                                color: kWhiteColor,
                                size: responsiveHeight(24),
                              ),
                            ),
                          ),
                        ],
                      ),

                     */ /* Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 12, right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              child: Image.asset("assets/icons/add.png"),
                              onTap: () {
                                if (patientNameController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Enter Patient Name',
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } else if (countryCodeController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Select Country Code',
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } else if (mobileController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Enter Mobile Number',
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } else {
                                  addCard();
                                }
                              },
                            ),
                            SizedBox(
                              width: responsiveWidth(10),
                            ),
                            */ /**/ /*InkWell(
                                        child: Image.asset("assets/icons/remove.png"),
                                        onTap: () {
                                          removeCard(carbonCommentsList.length );
                                        },
                                      ),*/ /**/ /*
                          ],
                        ),
                      )*/ /*
                    ],
                  ),
                ),
              ),*/
              /*   Visibility(
                visible: campDetailsController.campReferredPatientList.isNotEmpty ? true : false,
                child: Flexible(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: campDetailsController.campReferredPatientList.length,
                      itemBuilder: (context, index) {
                        // listpatientNameController.text = campregisteredpatients[index].name;
                        var tempList = campDetailsController.campReferredPatientList[index];
                        return Container(
                          margin: const EdgeInsets.all(8),
                          width: SizeConfig.screenWidth * 0.95,
                          // height: SizeConfig.screenHeight /3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(responsiveHeight(25)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5), // Shadow color
                                spreadRadius: 2, // Spread radius
                                blurRadius: 7, // Blur radius
                                offset: const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: responsiveHeight(10),
                                ),
                                Container(
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Patient Name: ",
                                      style: TextStyle(color: kTextColor, fontSize: responsiveFont(14), fontWeight: FontWeight.bold),
                                      children: [TextSpan(text: tempList.patientName, style: TextStyle(fontSize: responsiveFont(14), color: kTextColor, fontWeight: FontWeight.normal))],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: responsiveHeight(10),
                                ),
                                Container(
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Mobile Number: ",
                                      style: TextStyle(color: kTextColor, fontSize: responsiveFont(14), fontWeight: FontWeight.bold),
                                      children: [TextSpan(text: tempList.contactNumber, style: TextStyle(fontSize: responsiveFont(14), color: kTextColor, fontWeight: FontWeight.normal))],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: responsiveHeight(10),
                                ),
                                Container(
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Referred To: ",
                                      style: TextStyle(color: kTextColor, fontSize: responsiveFont(14), fontWeight: FontWeight.bold),
                                      children: [TextSpan(text: "", style: TextStyle(fontSize: responsiveFont(14), color: kTextColor, fontWeight: FontWeight.normal))],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5, bottom: 5, right: 12),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          child: Image.asset(
                                            "assets/icons/remove.png",
                                            color: Colors.red,
                                          ),
                                          onTap: () {
                                            // removeCard(carbonCommentsList.length - 1);
                                            setState(() {
                                              removeCard(campDetailsController.campReferredPatientList.length - 1);
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),*/
              /*  Column(
                children: carbonCommentsList
                    .asMap()
                    .entries
                    .map((entry) {
                  int index = entry.key;
                  CardData cardData = entry.value;
                  return campCard(index, cardData);
                }).toList(),
              ),*/

            ],
          ),
        ),
      ),
    );
  }

  void addCard(index) {
    // carbonCommentsList.add(CardData(""));
    setState(() {
      // patientNameController.text = "";
      // countryCodeController.text = "";
      // mobileController.text = "";
      // campName.text = "";
      // campId.text = "";
      /*campDetailsController.campregisteredpatients
          .add(CampCoordRegisteredPatientModel(mobile: mobileNoListCOntroller[index].text.trim(), name: patientNameListController[index].text, ttCampDashboardRefPatientsDetList: []));
    */
      print(campDetailsController.campregisteredpatients);
      campDetailsController.createMultiplePatients(campDetailsController.campregisteredpatients);
      // campDetailsController.patientsReferred.text = campDetailsController.campReferredPatientList.length.toString();
      // campDetailsController.campReferredPatientStakeholderList.clear();
    });
  }

  void removeCard(int index) {
    if (campDetailsController.campregisteredpatients.isNotEmpty) {
      setState(() {
        print(index);
        // campregisteredpatients.removeAt(index);
        campDetailsController.campregisteredpatients.removeAt(index);
        print(campDetailsController.campregisteredpatients);
        // carbonCommentsList.removeAt(index);
      });
    }
  }

  getCampsDetailsDropdown() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse('http://210.89.42.117:8085/api/administrator/masters/dropdown/camp-number-id-list');
    // var headers = {'Content-Type': 'application/json'};
    try {
      // final response = await http.post(url);
      final Map<String, dynamic> body = {};

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

        _referredCampDetails = CampDropdownRespModel.fromJson(decodedJson);

        print("referred list==================");
        print(_referredCampDetails);

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

    // final url = Uri.parse('http://210.89.42.117:8085/api/administrator/masters/all-stake-holder-master-pagination');
    final url = Uri.parse('http://210.89.42.117:8085/api/administrator/masters/dropdown/stake-holder-by-sub-type-list/$subtypeId');
    var headers = {'Content-Type': 'application/json'};
    try {
      // final response = await http.post(url);

      // var body = json.encode({"lookup_det_hier_parent_id ": 20, "page": 1, "total_count": 10, "per_page": 10, "data": null});

      // print(body);

      print(url);

      http.Response response = await http.post(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> decodedJson = jsonDecode(response.body);

        List<dynamic> detailsArray = decodedJson['details'];
        // List<dynamic> dataArray = detailsArray['data'];

        setState(() {
          isLoading = false;
        });

        // Create a List of Maps to store the desired information
        extractedStackholderData = detailsArray.map((item) {
          return {
            'stakeholder_master_id': item['stakeholder_master_id'],
            // 'lookup_det_hier_desc_en': item['lookup_det_hier_desc_en'].toString(),
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
      campDetailsController.campregisteredpatients.clear();
      // patientNameController.text = "";
      // countryCodeController.text = "";
      // mobileController.text = "";
      campName.text = "";
      campId.text = "";
    });
  }

  void _showDetailsDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Details'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: campDetailsController.campregisteredpatients.map((item) {
                return ListTile(
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Stakeholder: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // Text(item.ttCampDashboardRefPatientsDetList[index]['stakeholder_master_id'].toString()),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        'Referred To: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // Text('Referred To: ${item['stakeholder_master_id']}'),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addDynamicWidget() {
    setState(() {
      patientNameListController.add(TextEditingController());
      mobileNoListCOntroller.add(TextEditingController());
      countryCodeListController.add(TextEditingController());
      _widgetList.add(buildDynamicWidget(_widgetList.length));
    });
  }

  Widget buildDynamicWidget(int index) {
    return Container(
      width: SizeConfig.screenWidth * 0.95,
      height: SizeConfig.screenHeight / 3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(responsiveHeight(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 2, // Spread radius
            blurRadius: 7, // Blur radius
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            AppRoundTextField(
              controller: patientNameListController[index],
              inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
              inputType: TextInputType.name,
              onChange: (p0) {},
              label: RichText(
                text: const TextSpan(text: 'Patient Name', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
              ),
              hint: "",
            ),
            SizedBox(
              height: responsiveHeight(10),
            ),
            Row(
              children: [
                Expanded(
                  child: AppRoundTextField(
                    controller: countryCodeListController[index],
                    inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
                    // inputType: TextInputType.number,
                    onChange: (p0) {},
                    onTap: () {
                      List<Map<String, dynamic>> list = [
                        {"title": "+91", "id": 1},
                      ];
                      commonBottonSheet(
                          context,
                          (p0) => {
                                setState(() {
                                  selectedCountryCode = p0;
                                  countryCodeListController[index].text = selectedCountryCode!['title'].toString();
                                })
                              },
                          "Country Code",
                          list);
                    },
                    maxLength: 3,
                    readOnly: true,
                    label: RichText(
                      text: const TextSpan(text: 'Country Code', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
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
                ),
                SizedBox(
                  width: responsiveWidth(10),
                ),
                Expanded(
                  child: AppRoundTextField(
                    controller: mobileNoListCOntroller[index],
                    inputStyle: TextStyle(fontSize: responsiveFont(14), color: kTextBlackColor),
                    inputType: TextInputType.number,
                    onChange: (p0) {},
                    maxLength: 10,
                    label: RichText(
                      text: const TextSpan(text: 'Mobile No', style: TextStyle(color: kHintColor, fontFamily: Montserrat), children: [TextSpan(text: "*", style: TextStyle(color: Colors.red))]),
                    ),
                    hint: "",
                  ),
                )
              ],
            ),
            SizedBox(
              height: responsiveHeight(30),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  // width: MediaQuery.sizeOf(context).width * 0.4,
                  // margin: EdgeInsets.only(right: 15),
                  child: AppButton(
                    onTap: () {
                      _showDetailsDialog(context,index);
                      // Navigator.pushNamed(context, AppRoutes.referredTo);
                    },
                    mWidth: SizeConfig.screenWidth * 0.4,
                    title: "View Referred",
                    iconData: Icon(
                      Icons.remove_red_eye,
                      color: kWhiteColor,
                      size: responsiveHeight(24),
                    ),
                  ),
                ),
                Container(
                  // width: MediaQuery.sizeOf(context).width * 0.4,
                  // margin: EdgeInsets.only(right: 15),
                  child: AppButton(
                    onTap: () {
                      if (patientNameListController[index].text.isEmpty || countryCodeListController[index].text.isEmpty || mobileNoListCOntroller[index].text.isEmpty) {
                        CustomMessage.toast("Please fill Patient Details");
                      } else {
                        Navigator.pushNamed(context, AppRoutes.referredTo);
                      }
                    },
                    mWidth: SizeConfig.screenWidth * 0.4,
                    title: "Add Referred to",
                    iconData: Icon(
                      Icons.arrow_forward,
                      color: kWhiteColor,
                      size: responsiveHeight(24),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    child: Image.asset("assets/icons/add.png"),
                    onTap: () {
                      if (patientNameListController[index].text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Enter Patient Name',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (countryCodeListController[index].text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Select Country Code',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (mobileNoListCOntroller[index].text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Enter Mobile Number',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        // addCard();
                        if(campDetailsController.ttCampDashboardRefPatientsDetList.isEmpty){
                          print("add toast of empty list");
                        }else{
                          campDetailsController. campregisteredpatients.add(CampCoordRegisteredPatientModel(
                              mobile: "${countryCodeListController[index].text} ${mobileNoListCOntroller[index].text}",
                              name: patientNameListController[index].text.trim(),
                              ));
                          print(campDetailsController.campregisteredpatients);
                          campDetailsController.ttCampDashboardRefPatientsDetList.clear();
                          campDetailsController.ttCampDashboardRefPatientsNamesList.clear();
                          _addDynamicWidget();
                        }


                        // checkPatientDetails(campregisteredpatients, index);
                      }
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


  void addPatients(int index) {
    campDetailsController.patientList.add(CampDashboardRefPatients(
      dashboardRefPatientsId: null,
      campDashboardId: null,
      patientId: null,
      patientName: patientNameListController[index].text,
      age: 0,
      lookupDetIdGender: null,
      contactNumber: countryCodeListController[index].text + " " + mobileNoListCOntroller[index].text,
      orgId: 1,
      status: 1,
      ttCampDashboardRefPatientsDetList: [],
    ));
  }

  void updateStakeholdersDataToPatientList(index) {
    updatePatientDetails(0, [
      CampDashboardRefPatientsDet(
        stakeholderMasterId: 3168,
        orgId: 1,
        status: 1,
      ),
      CampDashboardRefPatientsDet(
        stakeholderMasterId: 3169,
        orgId: 1,
        status: 1,
      ),
    ]);
  }

  bool isDetailsListEmpty(int index) {
    if (index >= 0 && index < ttCampDashboardRefPatientsList.length) {
      return ttCampDashboardRefPatientsList[index].ttCampDashboardRefPatientsDetList.isEmpty;
    }
    print("Invalid index.");
    return true; // Return true by default if the index is invalid
  }
}

class CardData {
  String? cardTitle;

  CardData(this.cardTitle);
}
