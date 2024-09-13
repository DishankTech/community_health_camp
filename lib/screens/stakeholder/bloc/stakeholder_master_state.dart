part of 'stakeholder_master_bloc.dart';

class StakeholderMasterState extends Equatable {
  const StakeholderMasterState(
      {required this.getAllStakeholderResponse,
      required this.getAllStakeholderStatus,
      required this.registerStakeholderResponse,
      required this.registerStakeholderStatus,
      required this.getStakeholderNameResponse,
      required this.getStakeholderNameStatus});
  final FormzSubmissionStatus getAllStakeholderStatus;
  final String getAllStakeholderResponse;
  final FormzSubmissionStatus registerStakeholderStatus;
  final String registerStakeholderResponse;

  final FormzSubmissionStatus getStakeholderNameStatus;
  final String getStakeholderNameResponse;


  StakeholderMasterState copyWith({
    FormzSubmissionStatus? getAllStakeholderStatus,
    String? getAllStakeholderResponse,
    FormzSubmissionStatus? registerStakeholderStatus,
    String? registerStakeholderResponse,
    FormzSubmissionStatus? getStakeholderNameStatus,
    String? getStakeholderNameResponse,
  }) {
    return StakeholderMasterState(
        getAllStakeholderResponse:
            getAllStakeholderResponse ?? this.getAllStakeholderResponse,
        getAllStakeholderStatus:
            getAllStakeholderStatus ?? this.getAllStakeholderStatus,
        registerStakeholderResponse:
            registerStakeholderResponse ?? this.registerStakeholderResponse,
        registerStakeholderStatus:
            registerStakeholderStatus ?? this.registerStakeholderStatus,
        getStakeholderNameResponse:
            getStakeholderNameResponse ?? this.getStakeholderNameResponse,
        getStakeholderNameStatus:
            getStakeholderNameStatus ?? this.getStakeholderNameStatus);
  }

  @override
  List<Object> get props => [
        getAllStakeholderResponse,
        getAllStakeholderStatus,
        registerStakeholderResponse,
        registerStakeholderStatus,
        getStakeholderNameResponse,
        getStakeholderNameStatus
      ];
}
