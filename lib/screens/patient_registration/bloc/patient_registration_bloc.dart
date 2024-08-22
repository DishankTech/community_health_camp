import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'patient_registration_event.dart';
part 'patient_registration_state.dart';

class PatientRegistrationBloc extends Bloc<PatientRegistrationEvent, PatientRegistrationState> {
  PatientRegistrationBloc() : super(PatientRegistrationInitial()) {
    on<PatientRegistrationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
