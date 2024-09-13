import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:community_health_app/screens/stakeholder/repository/stakeholder_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart' as http;

part 'stakeholder_master_event.dart';
part 'stakeholder_master_state.dart';

class StakeholderMasterBloc
    extends Bloc<StakeholderMasterEvent, StakeholderMasterState> {
  StakeholderRepository stakeholderRepository;

  StakeholderMasterBloc({required this.stakeholderRepository})
      : super(const StakeholderMasterState(
            getAllStakeholderResponse: '',
            getAllStakeholderStatus: FormzSubmissionStatus.initial,
            registerStakeholderResponse: '',
            registerStakeholderStatus: FormzSubmissionStatus.initial,
            getStakeholderNameResponse: '',
            getStakeholderNameStatus: FormzSubmissionStatus.initial,)) {
    on<GetAllStakeholder>(_onGetAllStakeholder);
    on<RegisterStakeholder>(_onRegisterStakeholder);
    on<GetStakeholderName>(_onGetStakeholderName);
    on<ResetStakeholderMasterState>(_onResetStakeholderMasterState);
  }

  FutureOr<void> _onGetAllStakeholder(
      GetAllStakeholder event, Emitter<StakeholderMasterState> emit) async {
    try {
      emit(state.copyWith(
          getAllStakeholderResponse: '',
          registerStakeholderResponse: '',
          registerStakeholderStatus: FormzSubmissionStatus.initial,
          getAllStakeholderStatus: FormzSubmissionStatus.inProgress,
          getStakeholderNameStatus: FormzSubmissionStatus.initial));

      http.Response res = await stakeholderRepository.getAll(event.payload);
      if (res.statusCode == 200) {
        emit(state.copyWith(
            getAllStakeholderResponse: utf8.decode(res.bodyBytes),
            getAllStakeholderStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getAllStakeholderResponse: res.reasonPhrase,
            getAllStakeholderStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
          getAllStakeholderResponse: e.toString(),
          getAllStakeholderStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onRegisterStakeholder(
      RegisterStakeholder event, Emitter<StakeholderMasterState> emit) async {
    try {
      emit(state.copyWith(
          registerStakeholderResponse: '',
          registerStakeholderStatus: FormzSubmissionStatus.inProgress,
          getAllStakeholderStatus: FormzSubmissionStatus.initial,
          getStakeholderNameStatus: FormzSubmissionStatus.initial));

      http.Response res = await stakeholderRepository.register(event.payload);
      if (res.statusCode == 200) {
        emit(state.copyWith(
            registerStakeholderResponse: res.body,
            registerStakeholderStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            registerStakeholderResponse: res.reasonPhrase,
            registerStakeholderStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
          registerStakeholderResponse: e.toString(),
          registerStakeholderStatus: FormzSubmissionStatus.failure));
    }
  }



  FutureOr<void> _onGetStakeholderName(
      GetStakeholderName event, Emitter<StakeholderMasterState> emit) async {
    try {
      emit(state.copyWith(
          registerStakeholderResponse: '',
          registerStakeholderStatus: FormzSubmissionStatus.initial,
          getAllStakeholderStatus: FormzSubmissionStatus.initial,
          getStakeholderNameResponse: '',
          getStakeholderNameStatus: FormzSubmissionStatus.inProgress));

      http.Response res =
          await stakeholderRepository.getStakeholderName(event.payload);
      if (res.statusCode == 200) {
        emit(state.copyWith(
            getStakeholderNameResponse: res.body,
            getStakeholderNameStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getStakeholderNameResponse: res.reasonPhrase,
            getStakeholderNameStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      emit(state.copyWith(
          getStakeholderNameResponse: e.toString(),
          getStakeholderNameStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onResetStakeholderMasterState(
      ResetStakeholderMasterState event,
      Emitter<StakeholderMasterState> emit) async {
    try {
      emit(state.copyWith(
          getAllStakeholderResponse: '',
          getAllStakeholderStatus: FormzSubmissionStatus.initial,
          registerStakeholderResponse: '',
          registerStakeholderStatus: FormzSubmissionStatus.initial,
          getStakeholderNameStatus: FormzSubmissionStatus.initial));
    } catch (e) {
      print(e);
    }
  }
}
