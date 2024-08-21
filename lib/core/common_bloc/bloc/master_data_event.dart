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

class GetDivisionList extends MasterDataEvent {}

class GetDistrictList extends MasterDataEvent {}

class GetStateList extends MasterDataEvent {}

class GetTownList extends MasterDataEvent {}

class GetTalukaList extends MasterDataEvent {}

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
