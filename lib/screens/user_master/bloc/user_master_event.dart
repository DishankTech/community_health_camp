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

class GetUserRequest extends UserMasterEvent {}

class ResetUserMasterState extends UserMasterEvent {}
