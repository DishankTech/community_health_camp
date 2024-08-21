class RegisteredPatientMasterModel {
  String name;
  String stakeholderType;
  String stakeholderName;
  String designationType;
  String mobileNo;
  String email;

  RegisteredPatientMasterModel(
      {required this.designationType,
      required this.name,
      required this.stakeholderType,
      required this.stakeholderName,
      required this.mobileNo,
      required this.email});
}
