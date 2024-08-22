part of 'patient_registration_bloc.dart';

sealed class PatientRegistrationState extends Equatable {
  const PatientRegistrationState();
  
  @override
  List<Object> get props => [];
}

final class PatientRegistrationInitial extends PatientRegistrationState {}
