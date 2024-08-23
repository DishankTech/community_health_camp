part of 'user_master_bloc.dart';

class UserMasterState extends Equatable {
  const UserMasterState(
      {required this.createUserResponse,
      required this.createUserStatus,
      required this.getUserResponse,
      required this.getUserStatus});
  final FormzSubmissionStatus createUserStatus;
  final String createUserResponse;

  final FormzSubmissionStatus getUserStatus;
  final String getUserResponse;

  UserMasterState copyWith({
    FormzSubmissionStatus? createUserStatus,
    String? createUserResponse,
    FormzSubmissionStatus? getUserStatus,
    String? getUserResponse,
  }) {
    return UserMasterState(
        createUserResponse: createUserResponse ?? this.createUserResponse,
        createUserStatus: createUserStatus ?? this.createUserStatus,
        getUserResponse: getUserResponse ?? this.getUserResponse,
        getUserStatus: getUserStatus ?? this.getUserStatus);
  }

  @override
  List<Object> get props =>
      [createUserResponse, createUserStatus, getUserResponse, getUserStatus];
}
