part of 'dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class GetCount extends DashboardEvent {
  Map payload;
  GetCount({required this.payload});

  @override
  List<Object> get props => [payload];
}

class GetDateWiseDistrictCount extends DashboardEvent {
  Map payload;
  GetDateWiseDistrictCount({required this.payload});

  @override
  List<Object> get props => [payload];
}

class GetExcelData extends DashboardEvent {
  Map payload;
  GetExcelData({required this.payload});

  @override
  List<Object> get props => [payload];
}

class ResetDashboardState extends DashboardEvent {}
