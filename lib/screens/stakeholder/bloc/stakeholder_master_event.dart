part of 'stakeholder_master_bloc.dart';

sealed class StakeholderMasterEvent extends Equatable {
  const StakeholderMasterEvent();

  @override
  List<Object> get props => [];
}

class GetAllStakeholder extends StakeholderMasterEvent {
  Map payload;
  GetAllStakeholder({required this.payload});

  @override
  List<Object> get props => [payload];
}

class RegisterStakeholder extends StakeholderMasterEvent {
  Map payload;
  RegisterStakeholder({required this.payload});

  @override
  List<Object> get props => [payload];
}

class GetStakeholderName extends StakeholderMasterEvent {
  int payload;
  GetStakeholderName({required this.payload});

  @override
  List<Object> get props => [payload];
}

class ResetStakeholderMasterState extends StakeholderMasterEvent {}
