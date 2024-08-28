part of 'user_master_bloc.dart';

sealed class UserMasterEvent extends Equatable {
  const UserMasterEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class CreateUserRequest extends UserMasterEvent {
  Map<String, dynamic> payload;
  CreateUserRequest({required this.payload});
  @override
  List<Object> get props => [payload];
}

class GetUserRequest extends UserMasterEvent {
  Map payload;
  GetUserRequest({required this.payload});
  @override
  List<Object> get props => [payload];
}

class CheckLoginNameRequest extends UserMasterEvent {
  String loginName;
  CheckLoginNameRequest({required this.loginName});
  @override
  List<Object> get props => [loginName];
}

class ResetUserMasterState extends UserMasterEvent {}
