part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  const DashboardState({
    required this.getCountResponse,
    required this.getCountStatus,
    required this.getDateWiseDistrictCountStatus,
    required this.getDateWiseDistrictCountResponse,
    required this.getExcelDataResponse,
    required this.getExcelDataStatus,
  });
  final FormzSubmissionStatus getCountStatus;
  final String getCountResponse;

  final FormzSubmissionStatus getDateWiseDistrictCountStatus;
  final String getDateWiseDistrictCountResponse;

  final FormzSubmissionStatus getExcelDataStatus;
  final String getExcelDataResponse;

  DashboardState copyWith({
    FormzSubmissionStatus? getCountStatus,
    String? getCountResponse,
    FormzSubmissionStatus? getDateWiseDistrictCountStatus,
    String? getDateWiseDistrictCountResponse,
    FormzSubmissionStatus? getExcelDataStatus,
    String? getExcelDataResponse,
  }) {
    return DashboardState(
      getCountResponse: getCountResponse ?? this.getCountResponse,
      getCountStatus: getCountStatus ?? this.getCountStatus,
      getDateWiseDistrictCountStatus:
          getDateWiseDistrictCountStatus ?? this.getDateWiseDistrictCountStatus,
      getDateWiseDistrictCountResponse: getDateWiseDistrictCountResponse ??
          this.getDateWiseDistrictCountResponse,
      getExcelDataResponse: getExcelDataResponse ?? this.getExcelDataResponse,
      getExcelDataStatus: getExcelDataStatus ?? this.getExcelDataStatus,
    );
  }

  @override
  List<Object> get props => [
        getCountResponse,
        getCountStatus,
        getDateWiseDistrictCountResponse,
        getDateWiseDistrictCountStatus,
        getExcelDataResponse,
        getExcelDataStatus,
      ];
}
