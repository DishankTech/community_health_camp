part of 'patient_registration_bloc.dart';

class PatientRegistrationState extends Equatable {
  const PatientRegistrationState(
      {required this.patientRegistrationResponse,
      required this.patientRegistrationStatus,
      required this.patientListResponse,
      required this.patientListStatus});
  final FormzSubmissionStatus patientRegistrationStatus;
  final String patientRegistrationResponse;

  final FormzSubmissionStatus patientListStatus;
  final String patientListResponse;

  PatientRegistrationState copyWith({
    FormzSubmissionStatus? patientRegistrationStatus,
    String? patientRegistrationResponse,
    FormzSubmissionStatus? patientListStatus,
    String? patientListResponse,
  }) {
    return PatientRegistrationState(
      patientRegistrationResponse:
          patientRegistrationResponse ?? this.patientRegistrationResponse,
      patientRegistrationStatus:
          patientRegistrationStatus ?? this.patientRegistrationStatus,
      patientListResponse: patientListResponse ?? this.patientListResponse,
      patientListStatus: patientListStatus ?? this.patientListStatus,
    );
  }

  @override
  List<Object> get props => [
        patientRegistrationResponse,
        patientRegistrationStatus,
        patientListResponse,
        patientListStatus
      ];
}
