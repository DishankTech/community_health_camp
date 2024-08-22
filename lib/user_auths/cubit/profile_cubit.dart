import 'package:bloc/bloc.dart';
import 'package:community_health_app/core/utilities/data_provider.dart';
import 'package:community_health_app/user_auths/models/login_response_model.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState(loginResponseModel: null));

  void getProfile() => emit(
      state.copyWith(loginResponseModel: DataProvider().getParsedUserData()));

  void logout() {
    DataProvider().clearUserData();
    emit(const ProfileState(loginResponseModel: null));
  }
}
