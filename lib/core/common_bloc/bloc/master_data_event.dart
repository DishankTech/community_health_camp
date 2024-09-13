part of 'master_data_bloc.dart';

sealed class MasterDataEvent extends Equatable {
  const MasterDataEvent();

  @override
  List<Object> get props => [];
}

class GetPrefix extends MasterDataEvent {}

class GetUnitList extends MasterDataEvent {}

class GetViralLoadStatus extends MasterDataEvent {}

class GetIDProofList extends MasterDataEvent {}

class SchemeAdopted extends MasterDataEvent {}

class GetSlotList extends MasterDataEvent {
  int unitId;
  GetSlotList({required this.unitId});

  @override
  List<Object> get props => [unitId];
}

class GetMaritalStatus extends MasterDataEvent {}

class GetRelation extends MasterDataEvent {}

class GetDivisionList extends MasterDataEvent {
  Map payload;
  GetDivisionList({required this.payload});

  @override
  // TODO: implement props
  List<Object> get props => [payload];
}

class UpdateStakeHolder extends MasterDataEvent {
  final Map payload;
 const UpdateStakeHolder({required this.payload});

  @override
  // TODO: implement props
  List<Object> get props => [payload];
}

class GetDistrictList extends MasterDataEvent {
  Map payload;
  GetDistrictList({required this.payload});

  @override
  // TODO: implement props
  List<Object> get props => [payload];
}

class GetStakeHolderDetails extends MasterDataEvent {
  final int payload;
 const GetStakeHolderDetails({required this.payload});

  @override
  // TODO: implement props
  List<Object> get props => [payload];
}

class GetDistrictOnDivision extends MasterDataEvent {
  int payload;
  GetDistrictOnDivision({required this.payload});

  @override
  // TODO: implement props
  List<Object> get props => [payload];
}

class GetStateList extends MasterDataEvent {
  Map payload;
  GetStateList({required this.payload});

  @override
  // TODO: implement props
  List<Object> get props => [payload];
}

class GetTownList extends MasterDataEvent {
  int payload;
  GetTownList({required this.payload});

  @override
  // TODO: implement props
  List<Object> get props => [payload];
}

class GetTalukaList extends MasterDataEvent {
  int payload;
  GetTalukaList({required this.payload});

  @override
  // TODO: implement props
  List<Object> get props => [payload];
}

class GetSchemeAdptedList extends MasterDataEvent {}

class GetSchemeAdopted extends MasterDataEvent {}

class GetBloodGroup extends MasterDataEvent {}

class GetDialysisModeList extends MasterDataEvent {}

class GetRefferedBy extends MasterDataEvent {}

class GetAddressByPincode extends MasterDataEvent {
  int pincode;
  GetAddressByPincode({required this.pincode});

  @override
  List<Object> get props => [pincode];
}

class GetMasters extends MasterDataEvent {
  Map payload;
  GetMasters({required this.payload});

  @override
  List<Object> get props => [payload];
}

class GetMastersDesignationType extends MasterDataEvent {
  Map payload;
  GetMastersDesignationType({required this.payload});

  @override
  List<Object> get props => [payload];
}

class GetGenderRequest extends MasterDataEvent {
  Map payload;
  GetGenderRequest({required this.payload});

  @override
  List<Object> get props => [payload];
}

class GetStakeholderSubType extends MasterDataEvent {
  int payload;

  GetStakeholderSubType({required this.payload});

  @override
  List<Object> get props => [payload];
}

class GetStakeholderSubTypeWithLookupCode extends MasterDataEvent {
  Map payload;
  GetStakeholderSubTypeWithLookupCode({required this.payload});

  @override
  List<Object> get props => [payload];
}

class GetSectorType extends MasterDataEvent {
  Map payload;
  GetSectorType({required this.payload});

  @override
  List<Object> get props => [payload];
}

class ResetMasterState extends MasterDataEvent {}

class GetCampListDropdown extends MasterDataEvent {
  int locationId;
  GetCampListDropdown({required this.locationId});

  @override
  // TODO: implement props
  List<Object> get props => [locationId];
}

class GetDiseaseTypes extends MasterDataEvent {
  Map payload;
  GetDiseaseTypes({required this.payload});

  @override
  // TODO: implement props
  List<Object> get props => [payload];
}

class GetReferToDepartment extends MasterDataEvent {
  Map payload;
  GetReferToDepartment({required this.payload});

  @override
  // TODO: implement props
  List<Object> get props => [payload];
}
