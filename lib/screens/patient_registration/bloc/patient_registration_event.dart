part of 'patient_registration_bloc.dart';

sealed class PatientRegistrationEvent extends Equatable {
  const PatientRegistrationEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class PatientRegistrationRequest extends PatientRegistrationEvent {
  Map payload;
  PatientRegistrationRequest({required this.payload});

  @override
  List<Object> get props => [payload];
}

class GetPatientListRequest extends PatientRegistrationEvent {
  Map payload;
  GetPatientListRequest({required this.payload});

  @override
  List<Object> get props => [payload];
}
