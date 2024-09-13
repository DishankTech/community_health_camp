import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:community_health_app/screens/user_master/repository/user_master_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart' as getP;
import 'package:http/http.dart' as http;

part 'user_master_event.dart';
part 'user_master_state.dart';

class UserMasterBloc extends Bloc<UserMasterEvent, UserMasterState> {
  final UserMasterRepository userMasterRepository;

  UserMasterBloc({required this.userMasterRepository})
      : super(const UserMasterState(
            createUserResponse: '',
            createUserStatus: FormzSubmissionStatus.initial,
            updateUserResp: '',
            updateUserStatus: FormzSubmissionStatus.initial,
            getUserResponse: '',
            getUserStatus: FormzSubmissionStatus.initial,
            loginNameCheckResponse: '',
            loginNameCheckStatus: FormzSubmissionStatus.initial)) {
    on<CreateUserRequest>(_onCreateUserRequest);
    on<UpdateUserReq>(_onUpdateUserRequest);
    on<GetUserRequest>(_onGetUserRequest);
    on<ResetUserMasterState>(_onResetUserMasterState);
    on<CheckLoginNameRequest>(_onCheckLoginNameRequest);
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

  FutureOr<void> _onUpdateUserRequest(
      UpdateUserReq event, Emitter<UserMasterState> emit) async {
    try {
      emit(state.copyWith(
          updateUserResp: '',
          updateUserStatus: FormzSubmissionStatus.inProgress));
      Response res = await userMasterRepository.updateUser(event.payload);

      // http.Response res = await userMasterRepository.createUser(event.payload);

      if (res.statusCode == 200) {
        emit(state.copyWith(
            updateUserResp: jsonEncode(res.data),
            updateUserStatus: FormzSubmissionStatus.success));


      } else {
        emit(state.copyWith(
            updateUserResp: res.statusMessage,
            updateUserStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
          updateUserResp: e.toString(),
          updateUserStatus: FormzSubmissionStatus.failure));
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
      http.Response res = await userMasterRepository.getAll(event.payload);

      if (res.statusCode == 200) {
        emit(state.copyWith(
            getUserResponse: res.body,
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
          getUserStatus: FormzSubmissionStatus.initial,
          loginNameCheckStatus: FormzSubmissionStatus.initial,
          loginNameCheckResponse: ''));
    } catch (e) {}
  }

  FutureOr<void> _onCheckLoginNameRequest(
      CheckLoginNameRequest event, Emitter<UserMasterState> emit) async {
    try {
      emit(state.copyWith(
          createUserResponse: '',
          createUserStatus: FormzSubmissionStatus.initial,
          getUserResponse: '',
          getUserStatus: FormzSubmissionStatus.initial,
          loginNameCheckStatus: FormzSubmissionStatus.inProgress,
          loginNameCheckResponse: ''));

      http.Response res =
          await userMasterRepository.getLoginNameValidation(event.loginName);
      if (res.statusCode == 200) {
        emit(state.copyWith(
            loginNameCheckResponse: res.body,
            loginNameCheckStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            loginNameCheckResponse: res.reasonPhrase,
            loginNameCheckStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(
          loginNameCheckResponse: e.toString(),
          loginNameCheckStatus: FormzSubmissionStatus.failure));
    }
  }
}
