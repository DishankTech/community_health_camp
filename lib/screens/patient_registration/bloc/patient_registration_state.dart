part of 'patient_registration_bloc.dart';

class PatientRegistrationState extends Equatable {
  const PatientRegistrationState({
    required this.patientRegistrationResponse,
    required this.patientRegistrationStatus,
    required this.patientListResponse,
    required this.patientListStatus,
    required this.patientSearchListResponse,
    required this.patientSearchListStatus,
  });
  final FormzSubmissionStatus patientRegistrationStatus;
  final String patientRegistrationResponse;

  final FormzSubmissionStatus patientListStatus;
  final String patientListResponse;

  final FormzSubmissionStatus patientSearchListStatus;
  final String patientSearchListResponse;

  PatientRegistrationState copyWith({
    FormzSubmissionStatus? patientRegistrationStatus,
    String? patientRegistrationResponse,
    FormzSubmissionStatus? patientListStatus,
    String? patientListResponse,
    FormzSubmissionStatus? patientSearchListStatus,
    String? patientSearchListResponse,
  }) {
    return PatientRegistrationState(
      patientRegistrationResponse:
          patientRegistrationResponse ?? this.patientRegistrationResponse,
      patientRegistrationStatus:
          patientRegistrationStatus ?? this.patientRegistrationStatus,
      patientListResponse: patientListResponse ?? this.patientListResponse,
      patientListStatus: patientListStatus ?? this.patientListStatus,
      patientSearchListResponse:
          patientSearchListResponse ?? this.patientSearchListResponse,
      patientSearchListStatus:
          patientSearchListStatus ?? this.patientSearchListStatus,
    );
  }

  @override
  List<Object> get props => [
        patientRegistrationResponse,
        patientRegistrationStatus,
        patientListResponse,
        patientListStatus,
        patientSearchListStatus,
        patientSearchListResponse
      ];
}
