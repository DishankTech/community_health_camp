part of 'stakeholder_master_bloc.dart';

class StakeholderMasterState extends Equatable {
  const StakeholderMasterState(
      {required this.getAllStakeholderResponse,
      required this.getAllStakeholderStatus,
      required this.registerStakeholderResponse,
      required this.registerStakeholderStatus});
  final FormzSubmissionStatus getAllStakeholderStatus;
  final String getAllStakeholderResponse;
  final FormzSubmissionStatus registerStakeholderStatus;
  final String registerStakeholderResponse;

  StakeholderMasterState copyWith({
    FormzSubmissionStatus? getAllStakeholderStatus,
    String? getAllStakeholderResponse,
    FormzSubmissionStatus? registerStakeholderStatus,
    String? registerStakeholderResponse,
  }) {
    return StakeholderMasterState(
        getAllStakeholderResponse:
            getAllStakeholderResponse ?? this.getAllStakeholderResponse,
        getAllStakeholderStatus:
            getAllStakeholderStatus ?? this.getAllStakeholderStatus,
        registerStakeholderResponse:
            registerStakeholderResponse ?? this.registerStakeholderResponse,
        registerStakeholderStatus:
            registerStakeholderStatus ?? this.registerStakeholderStatus);
  }

  @override
  List<Object> get props => [
        getAllStakeholderResponse,
        getAllStakeholderStatus,
        registerStakeholderResponse,
        registerStakeholderStatus
      ];
}
