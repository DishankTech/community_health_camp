import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:community_health_app/screens/dashboard_patient_registration/repository/dashboard_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository dashboardRepository;
  DashboardBloc({required this.dashboardRepository})
      : super(const DashboardState(
            getCountResponse: '',
            getCountStatus: FormzSubmissionStatus.initial,
            getDateWiseDistrictCountResponse: '',
            getDateWiseDistrictCountStatus: FormzSubmissionStatus.initial,
            getExcelDataResponse: '',
            getExcelDataStatus: FormzSubmissionStatus.initial,
            getDistrictWisePatientResponse: '',
            getDistrictWisePatientStatus: FormzSubmissionStatus.initial)) {
    on<GetCount>(_onGetCount);
    on<GetDateWiseDistrictCount>(_onGetDateWiseDistrictCount);
    on<GetExcelData>(_onGetExcelData);
    on<ResetDashboardState>(_onResetDashboardState);
    on<GetDistrictWisePatientsCount>(_onGetDistrictWisePatientsCount);
  }

  FutureOr<void> _onGetCount(
      GetCount event, Emitter<DashboardState> emit) async {
    try {
      emit(state.copyWith(
          // getExcelDataStatus: FormzSubmissionStatus.initial,
          // getExcelDataResponse: '',
          getCountResponse: '',
          getCountStatus: FormzSubmissionStatus.inProgress));
      http.Response res = await dashboardRepository.getCount(event.payload);
      if (res.statusCode == 200) {
        emit(state.copyWith(
            getCountResponse: res.body,
            getCountStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getCountResponse: res.reasonPhrase,
            getCountStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
          getCountResponse: e.toString(),
          getCountStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onGetDateWiseDistrictCount(
      GetDateWiseDistrictCount event, Emitter<DashboardState> emit) async {
    try {
      emit(state.copyWith(
        getDateWiseDistrictCountResponse: '',
        // getExcelDataStatus: FormzSubmissionStatus.initial,
        // getExcelDataResponse: '',
        // getCountStatus: FormzSubmissionStatus.initial,
        getDateWiseDistrictCountStatus: FormzSubmissionStatus.inProgress,
      ));
      http.Response res =
          await dashboardRepository.getDateWiseDistrictCount(event.payload);
      if (res.statusCode == 200) {
        emit(state.copyWith(
            getDateWiseDistrictCountResponse: res.body,
            getDateWiseDistrictCountStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getDateWiseDistrictCountResponse: res.reasonPhrase,
            getDateWiseDistrictCountStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
          getDateWiseDistrictCountResponse: e.toString(),
          getDateWiseDistrictCountStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onGetExcelData(
      GetExcelData event, Emitter<DashboardState> emit) async {
    try {
      emit(state.copyWith(
          getExcelDataStatus: FormzSubmissionStatus.inProgress,
          getExcelDataResponse: ''));
      http.Response res = await dashboardRepository.getExcelData(event.payload);
      if (res.statusCode == 200) {
        if (res.headers['content-type'] == 'application/json') {
          var parsedResponse = jsonDecode(res.body);
          emit(state.copyWith(
              getExcelDataResponse: parsedResponse['message'],
              getExcelDataStatus: FormzSubmissionStatus.success));
        } else {
          // Get the filename from the headers if needed
          final contentDisposition = res.headers['content-disposition'];
          final filename = contentDisposition?.split('filename=')?.last ??
              '${event.payload['start_date']}_${event.payload['end_date']}.xlsx';

          // Get the application's documents directory
          // final directory = await getDownloadsDirectory();
          // final directory = Directory('/storage/emulated/0/Download');
          final directory = await getApplicationDocumentsDirectory();

          // Create the file
          final file = File('${directory.path}/$filename');

          // Write the file
          await file.writeAsBytes(res.bodyBytes);
          emit(state.copyWith(
              getExcelDataResponse: "File Downloaded Successfully",
              getExcelDataStatus: FormzSubmissionStatus.success));
          final result = await Share.shareXFiles(
              [XFile('${directory?.path}/$filename')],
              text: 'Community Health Report');

          if (result.status == ShareResultStatus.success) {
            print('Thank you for sharing the picture!');
          }
          print('File saved to ${file.path}');
        }
      } else {
        emit(state.copyWith(
            getExcelDataResponse: res.reasonPhrase,
            getExcelDataStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
          getExcelDataResponse: e.toString(),
          getExcelDataStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onResetDashboardState(
      ResetDashboardState event, Emitter<DashboardState> emit) {
    try {
      emit(state.copyWith(
          getCountStatus: FormzSubmissionStatus.initial,
          getExcelDataStatus: FormzSubmissionStatus.initial,
          getDateWiseDistrictCountStatus: FormzSubmissionStatus.initial));
    } catch (e) {
      print(e);
    }
  }

  FutureOr<void> _onGetDistrictWisePatientsCount(
      GetDistrictWisePatientsCount event, Emitter<DashboardState> emit) async {
    try {
      emit(state.copyWith(
          // getCountStatus: FormzSubmissionStatus.initial,
          // getExcelDataStatus: FormzSubmissionStatus.initial,
          // getDateWiseDistrictCountStatus: FormzSubmissionStatus.initial,
          getDistrictWisePatientStatus: FormzSubmissionStatus.inProgress));
      http.Response res =
          await dashboardRepository.getDistrictWisePatientCount(event.payload);
      if (res.statusCode == 200) {
        emit(state.copyWith(
            getDistrictWisePatientResponse: res.body,
            getDistrictWisePatientStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getDistrictWisePatientResponse: res.reasonPhrase,
            getDistrictWisePatientStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(
          getDistrictWisePatientResponse: e.toString(),
          getDistrictWisePatientStatus: FormzSubmissionStatus.failure));
    }
  }
}
