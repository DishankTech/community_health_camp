import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:community_health_app/screens/patient_registration/models/patient_search_response_model.dart';
import 'package:community_health_app/screens/patient_registration/repository/patient_registration_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart' as http;
part 'patient_registration_event.dart';
part 'patient_registration_state.dart';

class PatientRegistrationBloc
    extends Bloc<PatientRegistrationEvent, PatientRegistrationState> {
  final PatientRegistrationRepository patientRegistrationRepository;
  PatientRegistrationBloc({required this.patientRegistrationRepository})
      : super(const PatientRegistrationState(
            patientRegistrationResponse: '',
            patientRegistrationStatus: FormzSubmissionStatus.initial,
            patientListResponse: '',
            patientListStatus: FormzSubmissionStatus.initial,
            patientSearchListResponse: '',
            patientSearchListStatus: FormzSubmissionStatus.initial)) {
    on<PatientRegistrationRequest>(_onPatientRegistrationRequest);
    on<GetPatientListRequest>(_onGetPatientListRequest);
    on<ResetPatientRegistrationState>(_onResetPatientRegistrationState);
    on<SearchPatientRequest>(_onSearchPatientRequest);
  }

  FutureOr<void> _onPatientRegistrationRequest(PatientRegistrationRequest event,
      Emitter<PatientRegistrationState> emit) async {
    try {
      emit(state.copyWith(
          patientRegistrationResponse: '',
          patientRegistrationStatus: FormzSubmissionStatus.inProgress,
          patientListStatus: FormzSubmissionStatus.initial));
      http.Response res =
          await patientRegistrationRepository.registerPatient(event.payload);

      if (res.statusCode == 200) {
        emit(state.copyWith(
            patientRegistrationResponse: res.body,
            patientRegistrationStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            patientRegistrationResponse: res.reasonPhrase,
            patientRegistrationStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
          patientRegistrationResponse: e.toString(),
          patientRegistrationStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onGetPatientListRequest(GetPatientListRequest event,
      Emitter<PatientRegistrationState> emit) async {
    try {
      emit(state.copyWith(
          patientListResponse: '',
          patientRegistrationStatus: FormzSubmissionStatus.initial,
          patientRegistrationResponse: '',
          patientListStatus: FormzSubmissionStatus.inProgress));

      http.Response res =
          await patientRegistrationRepository.getAll(event.payload);

      if (res.statusCode == 200) {
        emit(state.copyWith(
            patientListResponse: res.body,
            patientListStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            patientListResponse: res.reasonPhrase,
            patientListStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
          patientListResponse: e.toString(),
          patientListStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onResetPatientRegistrationState(
      ResetPatientRegistrationState event,
      Emitter<PatientRegistrationState> emit) {
    try {
      emit(state.copyWith(
          patientListStatus: FormzSubmissionStatus.initial,
          patientRegistrationStatus: FormzSubmissionStatus.initial,
          patientSearchListStatus: FormzSubmissionStatus.initial,
          patientSearchListResponse: ''));
    } catch (e) {}
  }

  FutureOr<void> _onSearchPatientRequest(SearchPatientRequest event,
      Emitter<PatientRegistrationState> emit) async {
    try {
      emit(state.copyWith(
          patientRegistrationResponse: '',
          patientRegistrationStatus: FormzSubmissionStatus.initial,
          patientSearchListResponse: '',
          patientSearchListStatus: FormzSubmissionStatus.inProgress));

      http.Response res =
          await patientRegistrationRepository.searchPatient(event.name);

      if (res.statusCode == 200) {
        emit(state.copyWith(
            patientSearchListResponse: res.body,
            patientSearchListStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            patientSearchListResponse: res.reasonPhrase,
            patientSearchListStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
          patientSearchListResponse: e.toString(),
          patientSearchListStatus: FormzSubmissionStatus.failure));
    }
  }
}
