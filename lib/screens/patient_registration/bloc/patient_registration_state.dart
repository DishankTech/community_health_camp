part of 'patient_registration_bloc.dart';

class PatientRegistrationState extends Equatable {
  const PatientRegistrationState(
      {required this.patientRegistrationResponse,
      required this.patientRegistrationStatus});
  final FormzSubmissionStatus patientRegistrationStatus;
  final String patientRegistrationResponse;

  PatientRegistrationState copyWith({
    FormzSubmissionStatus? patientRegistrationStatus,
    String? patientRegistrationResponse,
  }) {
    return PatientRegistrationState(
        patientRegistrationResponse:
            patientRegistrationResponse ?? this.patientRegistrationResponse,
        patientRegistrationStatus:
            patientRegistrationStatus ?? this.patientRegistrationStatus);
  }

  @override
  List<Object> get props =>
      [patientRegistrationResponse, patientRegistrationStatus];
}
