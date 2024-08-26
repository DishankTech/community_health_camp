import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:community_health_app/screens/user_master/repository/user_master_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;
part 'user_master_event.dart';
part 'user_master_state.dart';

class UserMasterBloc extends Bloc<UserMasterEvent, UserMasterState> {
  final UserMasterRepository userMasterRepository;
  UserMasterBloc({required this.userMasterRepository})
      : super(const UserMasterState(
            createUserResponse: '',
            createUserStatus: FormzSubmissionStatus.initial,
            getUserResponse: '',
            getUserStatus: FormzSubmissionStatus.initial)) {
    on<CreateUserRequest>(_onCreateUserRequest);
    on<GetUserRequest>(_onGetUserRequest);
    on<ResetUserMasterState>(_onResetUserMasterState);
  }

  FutureOr<void> _onCreateUserRequest(
      CreateUserRequest event, Emitter<UserMasterState> emit) async {
    try {
      emit(state.copyWith(
          createUserResponse: '',
          createUserStatus: FormzSubmissionStatus.inProgress));
      Response res = await userMasterRepository.createUser(event.payload);

      // http.Response res = await userMasterRepository.createUser(event.payload);

      if (res.statusCode == 201) {
        emit(state.copyWith(
            createUserResponse: jsonEncode(res.data),
            createUserStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            createUserResponse: res.statusMessage,
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

  FutureOr<void> _onGetUserRequest(
      GetUserRequest event, Emitter<UserMasterState> emit) async {
    try {
      emit(state.copyWith(
          createUserResponse: '',
          getUserResponse: '',
          createUserStatus: FormzSubmissionStatus.initial,
          getUserStatus: FormzSubmissionStatus.inProgress));
      print(event.payload);
      http.Response res = await userMasterRepository.getAll(event.payload);

      if (res.statusCode == 200) {
        String decodeRes = res.body;
        emit(state.copyWith(
            getUserResponse: decodeRes,
            getUserStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getUserResponse: res.reasonPhrase,
            getUserStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
          getUserResponse: e.toString(),
          getUserStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onResetUserMasterState(
      ResetUserMasterState event, Emitter<UserMasterState> emit) async {
    try {
      emit(state.copyWith(
          createUserResponse: '',
          createUserStatus: FormzSubmissionStatus.initial,
          getUserResponse: '',
          getUserStatus: FormzSubmissionStatus.initial));
    } catch (e) {}
  }
}
