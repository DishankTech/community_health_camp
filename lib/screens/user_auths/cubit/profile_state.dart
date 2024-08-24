part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({required this.loginResponseModel});
  final LoginResponseModel? loginResponseModel;

  ProfileState copyWith(
      {FormzSubmissionStatus? status, LoginResponseModel? loginResponseModel}) {
    return ProfileState(
        loginResponseModel: loginResponseModel ?? this.loginResponseModel);
  }

  @override
  List<Object?> get props => [loginResponseModel];
}
