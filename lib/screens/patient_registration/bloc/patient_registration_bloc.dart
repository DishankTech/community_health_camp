import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
part 'patient_registration_event.dart';
part 'patient_registration_state.dart';

class PatientRegistrationBloc
    extends Bloc<PatientRegistrationEvent, PatientRegistrationState> {
  PatientRegistrationBloc()
      : super(const PatientRegistrationState(
            patientRegistrationResponse: '',
            patientRegistrationStatus: FormzSubmissionStatus.initial)) {
    on<PatientRegistrationRequest>(_onPatientRegistrationRequest);
  }

  FutureOr<void> _onPatientRegistrationRequest(PatientRegistrationRequest event,
      Emitter<PatientRegistrationState> emit) async {
    try {
      emit(state.copyWith(
          patientRegistrationResponse: '',
          patientRegistrationStatus: FormzSubmissionStatus.inProgress));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
