import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:community_health_app/screens/user_master/repository/user_master_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart' as http;
part 'user_master_event.dart';
part 'user_master_state.dart';

class UserMasterBloc extends Bloc<UserMasterEvent, UserMasterState> {
  final UserMasterRepository userMasterRepository;
  UserMasterBloc({required this.userMasterRepository})
      : super(const UserMasterState(
            createUserResponse: '',
            createUserStatus: FormzSubmissionStatus.initial)) {
    on<CreateUserRequest>(_onCreateUserRequest);
  }

  FutureOr<void> _onCreateUserRequest(
      CreateUserRequest event, Emitter<UserMasterState> emit) async {
    try {
      emit(state.copyWith(
          createUserResponse: '',
          createUserStatus: FormzSubmissionStatus.inProgress));
      http.StreamedResponse res =
          await userMasterRepository.createUser(event.payload);

      if (res.statusCode == 201) {
        String decodeRes = await res.stream.bytesToString();
        emit(state.copyWith(
            createUserResponse: decodeRes,
            createUserStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            createUserResponse: res.reasonPhrase,
            createUserStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
          createUserResponse: e.toString(),
          createUserStatus: FormzSubmissionStatus.failure));
    }
  }
}
