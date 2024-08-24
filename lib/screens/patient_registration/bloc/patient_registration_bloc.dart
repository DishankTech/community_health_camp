import 'dart:async';

import 'package:bloc/bloc.dart';
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
            patientListStatus: FormzSubmissionStatus.initial)) {
    on<PatientRegistrationRequest>(_onPatientRegistrationRequest);
    on<GetPatientListRequest>(_onGetPatientListRequest);
  }

  FutureOr<void> _onPatientRegistrationRequest(PatientRegistrationRequest event,
      Emitter<PatientRegistrationState> emit) async {
    try {
      emit(state.copyWith(
          patientRegistrationResponse: '',
          patientRegistrationStatus: FormzSubmissionStatus.inProgress));
      http.Response res =
          await patientRegistrationRepository.registerPatient(event.payload);

      if (res.statusCode == 200) {
        emit(state.copyWith(
            patientRegistrationResponse: res.body,
            patientListStatus: FormzSubmissionStatus.success));
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
}
