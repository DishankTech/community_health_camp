import 'dart:async';

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
            registerStakeholderStatus: FormzSubmissionStatus.initial)) {
    on<GetAllStakeholder>(_onGetAllStakeholder);
    on<RegisterStakeholder>(_onRegisterStakeholder);
  }

  FutureOr<void> _onGetAllStakeholder(
      GetAllStakeholder event, Emitter<StakeholderMasterState> emit) async {
    try {
      emit(state.copyWith(
          getAllStakeholderResponse: '',
          registerStakeholderResponse: '',
          registerStakeholderStatus: FormzSubmissionStatus.initial,
          getAllStakeholderStatus: FormzSubmissionStatus.inProgress));

      http.Response res = await stakeholderRepository.getAll(event.payload);
      if (res.statusCode == 200) {
        emit(state.copyWith(
            getAllStakeholderResponse: res.body,
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
          getAllStakeholderStatus: FormzSubmissionStatus.initial));

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
}
