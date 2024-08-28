part of 'user_master_bloc.dart';

class UserMasterState extends Equatable {
  const UserMasterState(
      {required this.createUserResponse,
      required this.createUserStatus,
      required this.getUserResponse,
      required this.getUserStatus,
      required this.loginNameCheckResponse,
      required this.loginNameCheckStatus});
  final FormzSubmissionStatus createUserStatus;
  final String createUserResponse;

  final FormzSubmissionStatus getUserStatus;
  final String getUserResponse;
  final FormzSubmissionStatus loginNameCheckStatus;
  final String loginNameCheckResponse;

  UserMasterState copyWith({
    FormzSubmissionStatus? createUserStatus,
    String? createUserResponse,
    FormzSubmissionStatus? getUserStatus,
    String? getUserResponse,
    FormzSubmissionStatus? loginNameCheckStatus,
    String? loginNameCheckResponse,
  }) {
    return UserMasterState(
      createUserResponse: createUserResponse ?? this.createUserResponse,
      createUserStatus: createUserStatus ?? this.createUserStatus,
      getUserResponse: getUserResponse ?? this.getUserResponse,
      getUserStatus: getUserStatus ?? this.getUserStatus,
      loginNameCheckResponse:
          loginNameCheckResponse ?? this.loginNameCheckResponse,
      loginNameCheckStatus: loginNameCheckStatus ?? this.loginNameCheckStatus,
    );
  }

  @override
  List<Object> get props => [
        createUserResponse,
        createUserStatus,
        getUserResponse,
        getUserStatus,
        loginNameCheckResponse,
        loginNameCheckStatus,
      ];
}
