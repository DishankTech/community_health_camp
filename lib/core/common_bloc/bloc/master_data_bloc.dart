import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart' as http;
import 'package:community_health_app/core/common_bloc/repository/master_repository.dart';

part 'master_data_event.dart';
part 'master_data_state.dart';

class MasterDataBloc extends Bloc<MasterDataEvent, MasterDataState> {
  MasterDataRepository masterDataRepository;
  MasterDataBloc({required this.masterDataRepository})
      : super(const MasterDataState(
          getUnitListStatus: FormzSubmissionStatus.initial,
          getUnitListResponse: '',
          getIDProofListResponse: '',
          getIDProofListStatus: FormzSubmissionStatus.initial,
          getSlotListResponse: '',
          getSlotListStatus: FormzSubmissionStatus.initial,
          getViralLoadStatusResponse: '',
          getViralLoadStatusStatus: FormzSubmissionStatus.initial,
          schemeAdoptedResponse: '',
          schemeAdoptedStatus: FormzSubmissionStatus.initial,
          prefixResponse: '',
          prefixStatus: FormzSubmissionStatus.initial,
          getMaritalStatusResponse: '',
          getMaritalStatusStatus: FormzSubmissionStatus.initial,
          getRelationResponse: '',
          getRelationStatus: FormzSubmissionStatus.initial,
          getDistrictListResponse: '',
          getDistrictListStatus: FormzSubmissionStatus.initial,
          getDivisionListResponse: '',
          getDivisionListStatus: FormzSubmissionStatus.initial,
          getStateListResponse: '',
          getStateListStatus: FormzSubmissionStatus.initial,
          getTalukaListResponse: '',
          getTalukaListStatus: FormzSubmissionStatus.initial,
          getTownListResponse: '',
          getTownListStatus: FormzSubmissionStatus.initial,
          getSchemAdoptedListResponse: '',
          getSchemAdoptedListStatus: FormzSubmissionStatus.initial,
          getBloodGroupResponse: '',
          getBloodGroupStatus: FormzSubmissionStatus.initial,
          getDialysisModeListResponse: '',
          getDialysisModeListStatus: FormzSubmissionStatus.initial,
          getRefferedByResponse: '',
          getRefferedByStatus: FormzSubmissionStatus.initial,
          getAddressByPincodeResponse: '',
          getAddressByPincodeStatus: FormzSubmissionStatus.initial,
          getMasterResponse: '',
          getMasterStatus: FormzSubmissionStatus.initial,
          getMasterDesignationTypeResponse: '',
          getMasterDesignationTypeStatus: FormzSubmissionStatus.initial,
          getGenderResponse: '',
          getGenderStatus: FormzSubmissionStatus.initial,
          getStakeholderSubTypeResponse: '',
          getStakeholderSubTypeStatus: FormzSubmissionStatus.initial,
          getCampDropdownListResponse: '',
          getCampDropdownListStatus: FormzSubmissionStatus.initial,
          getSectorTypeResponse: '',
          getSectorTypeStatus: FormzSubmissionStatus.initial,
        )) {
    on<GetUnitList>(_onGetUnitList);
    on<GetViralLoadStatus>(_onGetViralLoadStatus);
    on<GetIDProofList>(_onGetIDProofList);
    on<SchemeAdopted>(_onSchemeAdopted);
    on<GetSlotList>(_onGetSlotList);
    on<GetPrefix>(_onGetPrefix);
    on<GetMaritalStatus>(_onGetMaritalStatus);
    on<GetRelation>(_onGetRelation);
    on<GetDivisionList>(_onGetDivisionList);
    on<GetDistrictList>(_onGetDistrictList);
    on<GetStateList>(_onGetStateList);
    on<GetTownList>(_onGetTownList);
    on<GetTalukaList>(_onGetTalukaList);
    on<GetSchemeAdopted>(_onGetSchemeAdopted);
    on<GetBloodGroup>(_onGetBloodGroup);
    on<GetDialysisModeList>(_onGetDialysisModeList);
    on<GetRefferedBy>(_onGetRefferedBy);
    on<GetAddressByPincode>(_onGetAddressByPincode);
    on<GetMasters>(_onGetMasters);
    on<GetMastersDesignationType>(_onGetMastersDesignationType);
    on<GetGenderRequest>(_onGetGenderRequest);
    on<GetStakeholderSubType>(_onGetStakeholderSubType);
    on<ResetMasterState>(_onResetMasterState);
    on<GetCampListDropdown>(_onGetCampListDropdown);
    on<GetDistrictOnDivision>(_onGetDistrictOnDivision);
    on<GetSectorType>(_onGetSectorType);
  }

  FutureOr<void> _onGetPrefix(GetPrefix event, Emitter<dynamic> emit) async {
    emit(state.copyWith(
        prefixStatus: FormzSubmissionStatus.inProgress,
        prefixResponse: "",
        getMaritalStatusStatus: FormzSubmissionStatus.initial,
        getUnitListStatus: FormzSubmissionStatus.initial,
        getIDProofListStatus: FormzSubmissionStatus.initial,
        getSlotListStatus: FormzSubmissionStatus.initial,
        getViralLoadStatusStatus: FormzSubmissionStatus.initial,
        schemeAdoptedStatus: FormzSubmissionStatus.initial,
        getRelationStatus: FormzSubmissionStatus.initial,
        getTalukaListStatus: FormzSubmissionStatus.initial,
        getTownListStatus: FormzSubmissionStatus.initial,
        getStateListStatus: FormzSubmissionStatus.initial,
        getDistrictListStatus: FormzSubmissionStatus.initial,
        getDivisionListStatus: FormzSubmissionStatus.initial,
        getSchemAdoptedListStatus: FormzSubmissionStatus.initial,
        getBloodGroupStatus: FormzSubmissionStatus.initial,
        getDialysisModeListStatus: FormzSubmissionStatus.initial,
        getRefferedByStatus: FormzSubmissionStatus.initial,
        getAddressByPincodeStatus: FormzSubmissionStatus.initial));
    try {
      http.Response res = await masterDataRepository.getPrefix();

      if (res.statusCode == 200) {
        emit(state.copyWith(
            prefixStatus: FormzSubmissionStatus.success,
            prefixResponse: res.body));
      } else {
        emit(state.copyWith(
            prefixStatus: FormzSubmissionStatus.failure,
            prefixResponse: res.reasonPhrase));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
          prefixStatus: FormzSubmissionStatus.failure,
          prefixResponse: e.toString()));
    }
  }

  FutureOr<void> _onGetUnitList(
      GetUnitList event, Emitter<MasterDataState> emit) async {
    try {
      emit(state.copyWith(
          getUnitListResponse: "",
          getUnitListStatus: FormzSubmissionStatus.inProgress,
          prefixStatus: FormzSubmissionStatus.initial,
          getMaritalStatusStatus: FormzSubmissionStatus.initial,
          getIDProofListStatus: FormzSubmissionStatus.initial,
          getSlotListStatus: FormzSubmissionStatus.initial,
          getViralLoadStatusStatus: FormzSubmissionStatus.initial,
          schemeAdoptedStatus: FormzSubmissionStatus.initial,
          getRelationStatus: FormzSubmissionStatus.initial,
          getTalukaListStatus: FormzSubmissionStatus.initial,
          getTownListStatus: FormzSubmissionStatus.initial,
          getStateListStatus: FormzSubmissionStatus.initial,
          getDistrictListStatus: FormzSubmissionStatus.initial,
          getDivisionListStatus: FormzSubmissionStatus.initial,
          getSchemAdoptedListStatus: FormzSubmissionStatus.initial,
          getBloodGroupStatus: FormzSubmissionStatus.initial,
          getDialysisModeListStatus: FormzSubmissionStatus.initial,
          getRefferedByStatus: FormzSubmissionStatus.initial,
          getAddressByPincodeStatus: FormzSubmissionStatus.initial));
      http.Response res = await masterDataRepository.getUnitNameList();

      if (res.statusCode == 200) {
        emit(state.copyWith(
            getUnitListResponse: res.body,
            getUnitListStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getUnitListResponse: res.body,
            getUnitListStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
          getUnitListResponse: e.toString(),
          getUnitListStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onGetViralLoadStatus(
      GetViralLoadStatus event, Emitter<MasterDataState> emit) async {
    try {
      emit(state.copyWith(
          getViralLoadStatusResponse: "",
          getViralLoadStatusStatus: FormzSubmissionStatus.inProgress,
          getUnitListStatus: FormzSubmissionStatus.initial,
          prefixStatus: FormzSubmissionStatus.initial,
          getMaritalStatusStatus: FormzSubmissionStatus.initial,
          getIDProofListStatus: FormzSubmissionStatus.initial,
          getSlotListStatus: FormzSubmissionStatus.initial,
          schemeAdoptedStatus: FormzSubmissionStatus.initial,
          getRelationStatus: FormzSubmissionStatus.initial,
          getTalukaListStatus: FormzSubmissionStatus.initial,
          getTownListStatus: FormzSubmissionStatus.initial,
          getStateListStatus: FormzSubmissionStatus.initial,
          getDistrictListStatus: FormzSubmissionStatus.initial,
          getDivisionListStatus: FormzSubmissionStatus.initial,
          getSchemAdoptedListStatus: FormzSubmissionStatus.initial,
          getBloodGroupStatus: FormzSubmissionStatus.initial,
          getDialysisModeListStatus: FormzSubmissionStatus.initial,
          getRefferedByStatus: FormzSubmissionStatus.initial,
          getAddressByPincodeStatus: FormzSubmissionStatus.initial));
      http.Response res = await masterDataRepository.getViralLoadStatus();

      if (res.statusCode == 200) {
        emit(state.copyWith(
            getViralLoadStatusResponse: res.body,
            getViralLoadStatusStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getViralLoadStatusResponse: res.body,
            getViralLoadStatusStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
          getViralLoadStatusResponse: e.toString(),
          getViralLoadStatusStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onGetIDProofList(
      GetIDProofList event, Emitter<MasterDataState> emit) async {
    try {
      emit(state.copyWith(
          getIDProofListResponse: "",
          getIDProofListStatus: FormzSubmissionStatus.inProgress,
          prefixStatus: FormzSubmissionStatus.initial,
          getMaritalStatusStatus: FormzSubmissionStatus.initial,
          getUnitListStatus: FormzSubmissionStatus.initial,
          getSlotListStatus: FormzSubmissionStatus.initial,
          getViralLoadStatusStatus: FormzSubmissionStatus.initial,
          schemeAdoptedStatus: FormzSubmissionStatus.initial,
          getRelationStatus: FormzSubmissionStatus.initial,
          getTalukaListStatus: FormzSubmissionStatus.initial,
          getTownListStatus: FormzSubmissionStatus.initial,
          getStateListStatus: FormzSubmissionStatus.initial,
          getDistrictListStatus: FormzSubmissionStatus.initial,
          getDivisionListStatus: FormzSubmissionStatus.initial,
          getSchemAdoptedListStatus: FormzSubmissionStatus.initial,
          getBloodGroupStatus: FormzSubmissionStatus.initial,
          getDialysisModeListStatus: FormzSubmissionStatus.initial,
          getRefferedByStatus: FormzSubmissionStatus.initial,
          getAddressByPincodeStatus: FormzSubmissionStatus.initial));
      http.Response res = await masterDataRepository.getIDProofList();

      if (res.statusCode == 200) {
        emit(state.copyWith(
            getIDProofListResponse: res.body,
            getIDProofListStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getIDProofListResponse: res.body,
            getIDProofListStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
          getIDProofListResponse: e.toString(),
          getIDProofListStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onSchemeAdopted(
      SchemeAdopted event, Emitter<MasterDataState> emit) async {
    try {
      emit(state.copyWith(
          schemeAdoptedResponse: "",
          schemeAdoptedStatus: FormzSubmissionStatus.inProgress,
          prefixStatus: FormzSubmissionStatus.initial,
          getMaritalStatusStatus: FormzSubmissionStatus.initial,
          getUnitListStatus: FormzSubmissionStatus.initial,
          getIDProofListStatus: FormzSubmissionStatus.initial,
          getSlotListStatus: FormzSubmissionStatus.initial,
          getViralLoadStatusStatus: FormzSubmissionStatus.initial,
          getRelationStatus: FormzSubmissionStatus.initial,
          getTalukaListStatus: FormzSubmissionStatus.initial,
          getTownListStatus: FormzSubmissionStatus.initial,
          getStateListStatus: FormzSubmissionStatus.initial,
          getDistrictListStatus: FormzSubmissionStatus.initial,
          getDivisionListStatus: FormzSubmissionStatus.initial,
          getSchemAdoptedListStatus: FormzSubmissionStatus.initial,
          getBloodGroupStatus: FormzSubmissionStatus.initial,
          getDialysisModeListStatus: FormzSubmissionStatus.initial,
          getRefferedByStatus: FormzSubmissionStatus.initial,
          getAddressByPincodeStatus: FormzSubmissionStatus.initial));
      http.Response res = await masterDataRepository.getSchemeAdoted();

      if (res.statusCode == 200) {
        emit(state.copyWith(
            schemeAdoptedResponse: res.body,
            schemeAdoptedStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            schemeAdoptedResponse: res.body,
            schemeAdoptedStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(
          schemeAdoptedResponse: e.toString(),
          schemeAdoptedStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onGetSlotList(
      GetSlotList event, Emitter<MasterDataState> emit) async {
    try {
      emit(state.copyWith(
          getSlotListResponse: "",
          getSlotListStatus: FormzSubmissionStatus.inProgress,
          getUnitListStatus: FormzSubmissionStatus.initial,
          prefixStatus: FormzSubmissionStatus.initial,
          getMaritalStatusStatus: FormzSubmissionStatus.initial,
          getIDProofListStatus: FormzSubmissionStatus.initial,
          getViralLoadStatusStatus: FormzSubmissionStatus.initial,
          schemeAdoptedStatus: FormzSubmissionStatus.initial,
          getRelationStatus: FormzSubmissionStatus.initial,
          getTalukaListStatus: FormzSubmissionStatus.initial,
          getTownListStatus: FormzSubmissionStatus.initial,
          getStateListStatus: FormzSubmissionStatus.initial,
          getDistrictListStatus: FormzSubmissionStatus.initial,
          getDivisionListStatus: FormzSubmissionStatus.initial,
          getSchemAdoptedListStatus: FormzSubmissionStatus.initial,
          getBloodGroupStatus: FormzSubmissionStatus.initial,
          getDialysisModeListStatus: FormzSubmissionStatus.initial,
          getRefferedByStatus: FormzSubmissionStatus.initial,
          getAddressByPincodeStatus: FormzSubmissionStatus.initial));
      http.Response res = await masterDataRepository.getSlotList(event.unitId);

      if (res.statusCode == 200) {
        emit(state.copyWith(
            getSlotListResponse: res.body,
            getSlotListStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getSlotListResponse: res.body,
            getSlotListStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(
          getSlotListResponse: e.toString(),
          getSlotListStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onGetMaritalStatus(
      GetMaritalStatus event, Emitter<MasterDataState> emit) async {
    try {
      emit(state.copyWith(
          getMaritalStatusResponse: '',
          getMaritalStatusStatus: FormzSubmissionStatus.inProgress,
          getUnitListStatus: FormzSubmissionStatus.initial,
          getIDProofListStatus: FormzSubmissionStatus.initial,
          getSlotListStatus: FormzSubmissionStatus.initial,
          getViralLoadStatusStatus: FormzSubmissionStatus.initial,
          schemeAdoptedStatus: FormzSubmissionStatus.initial,
          prefixStatus: FormzSubmissionStatus.initial,
          getRelationStatus: FormzSubmissionStatus.initial,
          getTalukaListStatus: FormzSubmissionStatus.initial,
          getTownListStatus: FormzSubmissionStatus.initial,
          getStateListStatus: FormzSubmissionStatus.initial,
          getDistrictListStatus: FormzSubmissionStatus.initial,
          getDivisionListStatus: FormzSubmissionStatus.initial,
          getSchemAdoptedListStatus: FormzSubmissionStatus.initial,
          getBloodGroupStatus: FormzSubmissionStatus.initial,
          getDialysisModeListStatus: FormzSubmissionStatus.initial,
          getRefferedByStatus: FormzSubmissionStatus.initial,
          getAddressByPincodeStatus: FormzSubmissionStatus.initial));
      http.Response res = await masterDataRepository.getMaritalStatus();
      if (res.statusCode == 200) {
        emit(state.copyWith(
          getMaritalStatusResponse: res.body,
          getMaritalStatusStatus: FormzSubmissionStatus.success,
        ));
      } else {
        emit(state.copyWith(
          getMaritalStatusResponse: res.body,
          getMaritalStatusStatus: FormzSubmissionStatus.failure,
        ));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
        getMaritalStatusResponse: e.toString(),
        getMaritalStatusStatus: FormzSubmissionStatus.failure,
      ));
    }
  }

  FutureOr<void> _onGetRelation(
      GetRelation event, Emitter<MasterDataState> emit) async {
    try {
      emit(state.copyWith(
          getRelationResponse: '',
          getRelationStatus: FormzSubmissionStatus.inProgress,
          getUnitListStatus: FormzSubmissionStatus.initial,
          getIDProofListStatus: FormzSubmissionStatus.initial,
          getSlotListStatus: FormzSubmissionStatus.initial,
          getViralLoadStatusStatus: FormzSubmissionStatus.initial,
          schemeAdoptedStatus: FormzSubmissionStatus.initial,
          prefixStatus: FormzSubmissionStatus.initial,
          getMaritalStatusStatus: FormzSubmissionStatus.initial,
          getTalukaListStatus: FormzSubmissionStatus.initial,
          getTownListStatus: FormzSubmissionStatus.initial,
          getStateListStatus: FormzSubmissionStatus.initial,
          getDistrictListStatus: FormzSubmissionStatus.initial,
          getDivisionListStatus: FormzSubmissionStatus.initial,
          getSchemAdoptedListStatus: FormzSubmissionStatus.initial,
          getBloodGroupStatus: FormzSubmissionStatus.initial,
          getDialysisModeListStatus: FormzSubmissionStatus.initial,
          getRefferedByStatus: FormzSubmissionStatus.initial,
          getAddressByPincodeStatus: FormzSubmissionStatus.initial));

      http.Response res = await masterDataRepository.getRelation();
      if (res.statusCode == 200) {
        emit(state.copyWith(
            getRelationResponse: res.body,
            getRelationStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getRelationResponse: res.body,
            getRelationStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
          getRelationResponse: e.toString(),
          getRelationStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onGetDivisionList(
      GetDivisionList event, Emitter<MasterDataState> emit) async {
    try {
      emit(state.copyWith(
        getDivisionListResponse: '',
        getDivisionListStatus: FormzSubmissionStatus.inProgress,
        getSlotListStatus: FormzSubmissionStatus.initial,
        getUnitListStatus: FormzSubmissionStatus.initial,
        getIDProofListStatus: FormzSubmissionStatus.initial,
        getViralLoadStatusStatus: FormzSubmissionStatus.initial,
        schemeAdoptedStatus: FormzSubmissionStatus.initial,
        prefixStatus: FormzSubmissionStatus.initial,
        getMaritalStatusStatus: FormzSubmissionStatus.initial,
        getRelationStatus: FormzSubmissionStatus.initial,
        getDistrictListStatus: FormzSubmissionStatus.initial,
        getStateListStatus: FormzSubmissionStatus.initial,
        getTalukaListStatus: FormzSubmissionStatus.initial,
        getTownListStatus: FormzSubmissionStatus.initial,
        getSchemAdoptedListStatus: FormzSubmissionStatus.initial,
        getBloodGroupStatus: FormzSubmissionStatus.initial,
        getDialysisModeListStatus: FormzSubmissionStatus.initial,
        getRefferedByStatus: FormzSubmissionStatus.initial,
        getAddressByPincodeStatus: FormzSubmissionStatus.initial,
        getGenderStatus: FormzSubmissionStatus.initial,
        getStakeholderSubTypeStatus: FormzSubmissionStatus.initial,
      ));
      http.Response res =
          await masterDataRepository.getMasterDesignationType(event.payload);
      if (res.statusCode == 200) {
        emit(state.copyWith(
            getDivisionListResponse: res.body,
            getDivisionListStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getDivisionListResponse: res.body,
            getDivisionListStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
          getDivisionListResponse: e.toString(),
          getDivisionListStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onGetDistrictList(
      GetDistrictList event, Emitter<MasterDataState> emit) async {
    try {
      emit(state.copyWith(
        getDistrictListResponse: '',
        getDistrictListStatus: FormzSubmissionStatus.inProgress,
        getDivisionListStatus: FormzSubmissionStatus.initial,
        getSlotListStatus: FormzSubmissionStatus.initial,
        getUnitListStatus: FormzSubmissionStatus.initial,
        getIDProofListStatus: FormzSubmissionStatus.initial,
        getViralLoadStatusStatus: FormzSubmissionStatus.initial,
        schemeAdoptedStatus: FormzSubmissionStatus.initial,
        prefixStatus: FormzSubmissionStatus.initial,
        getMaritalStatusStatus: FormzSubmissionStatus.initial,
        getRelationStatus: FormzSubmissionStatus.initial,
        getStateListStatus: FormzSubmissionStatus.initial,
        getTalukaListStatus: FormzSubmissionStatus.initial,
        getTownListStatus: FormzSubmissionStatus.initial,
        getSchemAdoptedListStatus: FormzSubmissionStatus.initial,
        getBloodGroupStatus: FormzSubmissionStatus.initial,
        getDialysisModeListStatus: FormzSubmissionStatus.initial,
        getRefferedByStatus: FormzSubmissionStatus.initial,
        getAddressByPincodeStatus: FormzSubmissionStatus.initial,
        getGenderStatus: FormzSubmissionStatus.initial,
        getStakeholderSubTypeStatus: FormzSubmissionStatus.initial,
        getCampDropdownListStatus: FormzSubmissionStatus.initial,
        getMasterStatus: FormzSubmissionStatus.initial,
      ));
      http.Response res = await masterDataRepository.getMaster(event.payload);
      if (res.statusCode == 200) {
        emit(state.copyWith(
            getDistrictListResponse: res.body,
            getDistrictListStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getDistrictListResponse: res.body,
            getDistrictListStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
          getDistrictListResponse: e.toString(),
          getDistrictListStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onGetDistrictOnDivision(
      GetDistrictOnDivision event, Emitter<MasterDataState> emit) async {
    try {
      emit(state.copyWith(
        getDistrictListResponse: '',
        getDistrictListStatus: FormzSubmissionStatus.inProgress,
        getDivisionListStatus: FormzSubmissionStatus.initial,
        getSlotListStatus: FormzSubmissionStatus.initial,
        getUnitListStatus: FormzSubmissionStatus.initial,
        getIDProofListStatus: FormzSubmissionStatus.initial,
        getViralLoadStatusStatus: FormzSubmissionStatus.initial,
        schemeAdoptedStatus: FormzSubmissionStatus.initial,
        prefixStatus: FormzSubmissionStatus.initial,
        getMaritalStatusStatus: FormzSubmissionStatus.initial,
        getRelationStatus: FormzSubmissionStatus.initial,
        getStateListStatus: FormzSubmissionStatus.initial,
        getTalukaListStatus: FormzSubmissionStatus.initial,
        getTownListStatus: FormzSubmissionStatus.initial,
        getSchemAdoptedListStatus: FormzSubmissionStatus.initial,
        getBloodGroupStatus: FormzSubmissionStatus.initial,
        getDialysisModeListStatus: FormzSubmissionStatus.initial,
        getRefferedByStatus: FormzSubmissionStatus.initial,
        getAddressByPincodeStatus: FormzSubmissionStatus.initial,
        getGenderStatus: FormzSubmissionStatus.initial,
        getStakeholderSubTypeStatus: FormzSubmissionStatus.initial,
        getCampDropdownListStatus: FormzSubmissionStatus.initial,
        getMasterStatus: FormzSubmissionStatus.initial,
      ));
      http.Response res =
          await masterDataRepository.getDistrictOnDivision(event.payload);
      if (res.statusCode == 200) {
        emit(state.copyWith(
            getDistrictListResponse: res.body,
            getDistrictListStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getDistrictListResponse: res.body,
            getDistrictListStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
          getDistrictListResponse: e.toString(),
          getDistrictListStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onGetStateList(
      GetStateList event, Emitter<MasterDataState> emit) async {
    try {
      emit(state.copyWith(
        getStateListResponse: '',
        getStateListStatus: FormzSubmissionStatus.inProgress,
        getDistrictListStatus: FormzSubmissionStatus.initial,
        getDivisionListStatus: FormzSubmissionStatus.initial,
        getSlotListStatus: FormzSubmissionStatus.initial,
        getUnitListStatus: FormzSubmissionStatus.initial,
        getIDProofListStatus: FormzSubmissionStatus.initial,
        getViralLoadStatusStatus: FormzSubmissionStatus.initial,
        schemeAdoptedStatus: FormzSubmissionStatus.initial,
        prefixStatus: FormzSubmissionStatus.initial,
        getMaritalStatusStatus: FormzSubmissionStatus.initial,
        getRelationStatus: FormzSubmissionStatus.initial,
        getTalukaListStatus: FormzSubmissionStatus.initial,
        getTownListStatus: FormzSubmissionStatus.initial,
        getSchemAdoptedListStatus: FormzSubmissionStatus.initial,
        getBloodGroupStatus: FormzSubmissionStatus.initial,
        getDialysisModeListStatus: FormzSubmissionStatus.initial,
        getRefferedByStatus: FormzSubmissionStatus.initial,
        getAddressByPincodeStatus: FormzSubmissionStatus.initial,
        getStakeholderSubTypeStatus: FormzSubmissionStatus.initial,
      ));
      http.Response res = await masterDataRepository.getStateList();
      if (res.statusCode == 200) {
        emit(state.copyWith(
            getStateListResponse: res.body,
            getStateListStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getStateListResponse: res.body,
            getStateListStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
          getStateListResponse: e.toString(),
          getStateListStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onGetTownList(
      GetTownList event, Emitter<MasterDataState> emit) async {
    try {
      emit(state.copyWith(
        getTownListResponse: '',
        getTownListStatus: FormzSubmissionStatus.inProgress,
        getStateListStatus: FormzSubmissionStatus.initial,
        getDistrictListStatus: FormzSubmissionStatus.initial,
        getDivisionListStatus: FormzSubmissionStatus.initial,
        getSlotListStatus: FormzSubmissionStatus.initial,
        getUnitListStatus: FormzSubmissionStatus.initial,
        getIDProofListStatus: FormzSubmissionStatus.initial,
        getViralLoadStatusStatus: FormzSubmissionStatus.initial,
        schemeAdoptedStatus: FormzSubmissionStatus.initial,
        prefixStatus: FormzSubmissionStatus.initial,
        getMaritalStatusStatus: FormzSubmissionStatus.initial,
        getRelationStatus: FormzSubmissionStatus.initial,
        getTalukaListStatus: FormzSubmissionStatus.initial,
        getSchemAdoptedListStatus: FormzSubmissionStatus.initial,
        getBloodGroupStatus: FormzSubmissionStatus.initial,
        getDialysisModeListStatus: FormzSubmissionStatus.initial,
        getRefferedByStatus: FormzSubmissionStatus.initial,
        getAddressByPincodeStatus: FormzSubmissionStatus.initial,
        getGenderStatus: FormzSubmissionStatus.initial,
        getStakeholderSubTypeStatus: FormzSubmissionStatus.initial,
        getMasterStatus: FormzSubmissionStatus.initial,
      ));
      http.Response res =
          await masterDataRepository.getMasterLookupDetId(event.payload);
      if (res.statusCode == 200) {
        emit(state.copyWith(
            getTownListResponse: res.body,
            getTownListStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getTownListResponse: res.body,
            getTownListStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
          getTownListResponse: e.toString(),
          getTownListStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onGetTalukaList(
      GetTalukaList event, Emitter<MasterDataState> emit) async {
    try {
      emit(state.copyWith(
        getTalukaListResponse: '',
        getTalukaListStatus: FormzSubmissionStatus.inProgress,
        getMasterStatus: FormzSubmissionStatus.initial,
        getTownListStatus: FormzSubmissionStatus.initial,
        getStateListStatus: FormzSubmissionStatus.initial,
        getDistrictListStatus: FormzSubmissionStatus.initial,
        getDivisionListStatus: FormzSubmissionStatus.initial,
        getSlotListStatus: FormzSubmissionStatus.initial,
        getUnitListStatus: FormzSubmissionStatus.initial,
        getIDProofListStatus: FormzSubmissionStatus.initial,
        getViralLoadStatusStatus: FormzSubmissionStatus.initial,
        schemeAdoptedStatus: FormzSubmissionStatus.initial,
        prefixStatus: FormzSubmissionStatus.initial,
        getMaritalStatusStatus: FormzSubmissionStatus.initial,
        getRelationStatus: FormzSubmissionStatus.initial,
        getSchemAdoptedListStatus: FormzSubmissionStatus.initial,
        getBloodGroupStatus: FormzSubmissionStatus.initial,
        getDialysisModeListStatus: FormzSubmissionStatus.initial,
        getRefferedByStatus: FormzSubmissionStatus.initial,
        getAddressByPincodeStatus: FormzSubmissionStatus.initial,
        getGenderStatus: FormzSubmissionStatus.initial,
        getStakeholderSubTypeStatus: FormzSubmissionStatus.initial,
      ));
      http.Response res =
          await masterDataRepository.getMasterLookupDetId(event.payload);
      if (res.statusCode == 200) {
        emit(state.copyWith(
            getTalukaListResponse: res.body,
            getTalukaListStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getTalukaListResponse: res.body,
            getTalukaListStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
          getTalukaListResponse: e.toString(),
          getTalukaListStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onGetSchemeAdopted(
      GetSchemeAdopted event, Emitter<MasterDataState> emit) async {
    try {
      emit(state.copyWith(
          getSchemAdoptedListResponse: '',
          getSchemAdoptedListStatus: FormzSubmissionStatus.inProgress,
          getTalukaListStatus: FormzSubmissionStatus.initial,
          getTownListStatus: FormzSubmissionStatus.initial,
          getStateListStatus: FormzSubmissionStatus.initial,
          getDistrictListStatus: FormzSubmissionStatus.initial,
          getDivisionListStatus: FormzSubmissionStatus.initial,
          getSlotListStatus: FormzSubmissionStatus.initial,
          getUnitListStatus: FormzSubmissionStatus.initial,
          getIDProofListStatus: FormzSubmissionStatus.initial,
          getViralLoadStatusStatus: FormzSubmissionStatus.initial,
          schemeAdoptedStatus: FormzSubmissionStatus.initial,
          prefixStatus: FormzSubmissionStatus.initial,
          getMaritalStatusStatus: FormzSubmissionStatus.initial,
          getRelationStatus: FormzSubmissionStatus.initial,
          getBloodGroupStatus: FormzSubmissionStatus.initial,
          getDialysisModeListStatus: FormzSubmissionStatus.initial,
          getRefferedByStatus: FormzSubmissionStatus.initial,
          getAddressByPincodeStatus: FormzSubmissionStatus.initial));
      http.Response res = await masterDataRepository.getSchemeAdoted();
      if (res.statusCode == 200) {
        emit(state.copyWith(
            getSchemAdoptedListResponse: res.body,
            getSchemAdoptedListStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getSchemAdoptedListResponse: res.body,
            getSchemAdoptedListStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(
          getSchemAdoptedListResponse: e.toString(),
          getSchemAdoptedListStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onGetBloodGroup(
      GetBloodGroup event, Emitter<MasterDataState> emit) async {
    try {
      emit(state.copyWith(
          getBloodGroupResponse: "",
          getBloodGroupStatus: FormzSubmissionStatus.inProgress,
          getTalukaListStatus: FormzSubmissionStatus.initial,
          getTownListStatus: FormzSubmissionStatus.initial,
          getStateListStatus: FormzSubmissionStatus.initial,
          getDistrictListStatus: FormzSubmissionStatus.initial,
          getDivisionListStatus: FormzSubmissionStatus.initial,
          getSlotListStatus: FormzSubmissionStatus.initial,
          getUnitListStatus: FormzSubmissionStatus.initial,
          getIDProofListStatus: FormzSubmissionStatus.initial,
          getViralLoadStatusStatus: FormzSubmissionStatus.initial,
          schemeAdoptedStatus: FormzSubmissionStatus.initial,
          prefixStatus: FormzSubmissionStatus.initial,
          getMaritalStatusStatus: FormzSubmissionStatus.initial,
          getRelationStatus: FormzSubmissionStatus.initial,
          getDialysisModeListStatus: FormzSubmissionStatus.initial,
          getRefferedByStatus: FormzSubmissionStatus.initial,
          getSchemAdoptedListStatus: FormzSubmissionStatus.initial,
          getAddressByPincodeStatus: FormzSubmissionStatus.initial));

      http.Response res = await masterDataRepository.getBloodGroup();
      if (res.statusCode == 200) {
        emit(state.copyWith(
            getBloodGroupResponse: res.body,
            getBloodGroupStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getBloodGroupResponse: res.body,
            getBloodGroupStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(
          getBloodGroupResponse: e.toString(),
          getBloodGroupStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onGetDialysisModeList(
      GetDialysisModeList event, Emitter<MasterDataState> emit) async {
    try {
      emit(state.copyWith(
        getDialysisModeListResponse: "",
        getDialysisModeListStatus: FormzSubmissionStatus.inProgress,
        getTalukaListStatus: FormzSubmissionStatus.initial,
        getTownListStatus: FormzSubmissionStatus.initial,
        getStateListStatus: FormzSubmissionStatus.initial,
        getDistrictListStatus: FormzSubmissionStatus.initial,
        getDivisionListStatus: FormzSubmissionStatus.initial,
        getSlotListStatus: FormzSubmissionStatus.initial,
        getUnitListStatus: FormzSubmissionStatus.initial,
        getIDProofListStatus: FormzSubmissionStatus.initial,
        getViralLoadStatusStatus: FormzSubmissionStatus.initial,
        schemeAdoptedStatus: FormzSubmissionStatus.initial,
        prefixStatus: FormzSubmissionStatus.initial,
        getMaritalStatusStatus: FormzSubmissionStatus.initial,
        getRelationStatus: FormzSubmissionStatus.initial,
        getBloodGroupStatus: FormzSubmissionStatus.initial,
        getRefferedByStatus: FormzSubmissionStatus.initial,
        getSchemAdoptedListStatus: FormzSubmissionStatus.initial,
        getAddressByPincodeStatus: FormzSubmissionStatus.initial,
        getGenderStatus: FormzSubmissionStatus.initial,
      ));

      http.Response res = await masterDataRepository.getDialysisModeList();
      if (res.statusCode == 200) {
        emit(state.copyWith(
            getDialysisModeListResponse: res.body,
            getDialysisModeListStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getDialysisModeListResponse: res.body,
            getDialysisModeListStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(
          getDialysisModeListResponse: e.toString(),
          getDialysisModeListStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onGetRefferedBy(
      GetRefferedBy event, Emitter<MasterDataState> emit) async {
    try {
      emit(state.copyWith(
        getRefferedByResponse: "",
        getRefferedByStatus: FormzSubmissionStatus.inProgress,
        getTalukaListStatus: FormzSubmissionStatus.initial,
        getTownListStatus: FormzSubmissionStatus.initial,
        getStateListStatus: FormzSubmissionStatus.initial,
        getDistrictListStatus: FormzSubmissionStatus.initial,
        getDivisionListStatus: FormzSubmissionStatus.initial,
        getSlotListStatus: FormzSubmissionStatus.initial,
        getUnitListStatus: FormzSubmissionStatus.initial,
        getIDProofListStatus: FormzSubmissionStatus.initial,
        getViralLoadStatusStatus: FormzSubmissionStatus.initial,
        schemeAdoptedStatus: FormzSubmissionStatus.initial,
        prefixStatus: FormzSubmissionStatus.initial,
        getGenderStatus: FormzSubmissionStatus.initial,
        getMaritalStatusStatus: FormzSubmissionStatus.initial,
        getRelationStatus: FormzSubmissionStatus.initial,
        getBloodGroupStatus: FormzSubmissionStatus.initial,
        getDialysisModeListStatus: FormzSubmissionStatus.initial,
        getSchemAdoptedListStatus: FormzSubmissionStatus.initial,
        getAddressByPincodeStatus: FormzSubmissionStatus.initial,
        getStakeholderSubTypeStatus: FormzSubmissionStatus.initial,
      ));

      http.Response res = await masterDataRepository.getRefferedBy();
      if (res.statusCode == 200) {
        emit(state.copyWith(
            getRefferedByResponse: res.body,
            getRefferedByStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getRefferedByResponse: res.body,
            getRefferedByStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(
          getRefferedByResponse: e.toString(),
          getRefferedByStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onGetAddressByPincode(
      GetAddressByPincode event, Emitter<MasterDataState> emit) async {
    try {
      emit(state.copyWith(
        getAddressByPincodeResponse: "",
        getAddressByPincodeStatus: FormzSubmissionStatus.inProgress,
        getTalukaListStatus: FormzSubmissionStatus.initial,
        getGenderStatus: FormzSubmissionStatus.initial,
        getTownListStatus: FormzSubmissionStatus.initial,
        getStateListStatus: FormzSubmissionStatus.initial,
        getDistrictListStatus: FormzSubmissionStatus.initial,
        getDivisionListStatus: FormzSubmissionStatus.initial,
        getSlotListStatus: FormzSubmissionStatus.initial,
        getUnitListStatus: FormzSubmissionStatus.initial,
        getIDProofListStatus: FormzSubmissionStatus.initial,
        getViralLoadStatusStatus: FormzSubmissionStatus.initial,
        schemeAdoptedStatus: FormzSubmissionStatus.initial,
        prefixStatus: FormzSubmissionStatus.initial,
        getMaritalStatusStatus: FormzSubmissionStatus.initial,
        getRelationStatus: FormzSubmissionStatus.initial,
        getBloodGroupStatus: FormzSubmissionStatus.initial,
        getDialysisModeListStatus: FormzSubmissionStatus.initial,
        getSchemAdoptedListStatus: FormzSubmissionStatus.initial,
        getRefferedByStatus: FormzSubmissionStatus.initial,
        getStakeholderSubTypeStatus: FormzSubmissionStatus.initial,
      ));

      http.Response res =
          await masterDataRepository.GetAddressByPincode(event.pincode);

      if (res.statusCode == 200) {
        emit(state.copyWith(
            getAddressByPincodeResponse: res.body,
            getAddressByPincodeStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getAddressByPincodeResponse: res.body,
            getAddressByPincodeStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(
          getAddressByPincodeResponse: e.toString(),
          getAddressByPincodeStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onGetMasters(
      GetMasters event, Emitter<MasterDataState> emit) async {
    try {
      emit(state.copyWith(
        getMasterResponse: "",
        getMasterStatus: FormzSubmissionStatus.inProgress,
        getGenderStatus: FormzSubmissionStatus.initial,
        getMasterDesignationTypeStatus: FormzSubmissionStatus.initial,
        getAddressByPincodeStatus: FormzSubmissionStatus.initial,
        getTalukaListStatus: FormzSubmissionStatus.initial,
        getTownListStatus: FormzSubmissionStatus.initial,
        getStateListStatus: FormzSubmissionStatus.initial,
        getDistrictListStatus: FormzSubmissionStatus.initial,
        getDivisionListStatus: FormzSubmissionStatus.initial,
        getSlotListStatus: FormzSubmissionStatus.initial,
        getUnitListStatus: FormzSubmissionStatus.initial,
        getIDProofListStatus: FormzSubmissionStatus.initial,
        getViralLoadStatusStatus: FormzSubmissionStatus.initial,
        schemeAdoptedStatus: FormzSubmissionStatus.initial,
        prefixStatus: FormzSubmissionStatus.initial,
        getMaritalStatusStatus: FormzSubmissionStatus.initial,
        getRelationStatus: FormzSubmissionStatus.initial,
        getBloodGroupStatus: FormzSubmissionStatus.initial,
        getDialysisModeListStatus: FormzSubmissionStatus.initial,
        getSchemAdoptedListStatus: FormzSubmissionStatus.initial,
        getRefferedByStatus: FormzSubmissionStatus.initial,
        getStakeholderSubTypeStatus: FormzSubmissionStatus.initial,
      ));

      http.Response res = await masterDataRepository.getMaster(event.payload);

      if (res.statusCode == 200) {
        emit(state.copyWith(
            getMasterResponse: res.body,
            getMasterStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getMasterResponse: res.body,
            getMasterStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(
          getMasterResponse: e.toString(),
          getMasterStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onGetMastersDesignationType(
      GetMastersDesignationType event, Emitter<MasterDataState> emit) async {
    try {
      emit(state.copyWith(
        getMasterDesignationTypeResponse: "",
        getMasterDesignationTypeStatus: FormzSubmissionStatus.inProgress,
        getMasterStatus: FormzSubmissionStatus.initial,
        getAddressByPincodeStatus: FormzSubmissionStatus.initial,
        getTalukaListStatus: FormzSubmissionStatus.initial,
        getTownListStatus: FormzSubmissionStatus.initial,
        getStateListStatus: FormzSubmissionStatus.initial,
        getDistrictListStatus: FormzSubmissionStatus.initial,
        getDivisionListStatus: FormzSubmissionStatus.initial,
        getSlotListStatus: FormzSubmissionStatus.initial,
        getUnitListStatus: FormzSubmissionStatus.initial,
        getIDProofListStatus: FormzSubmissionStatus.initial,
        getViralLoadStatusStatus: FormzSubmissionStatus.initial,
        schemeAdoptedStatus: FormzSubmissionStatus.initial,
        prefixStatus: FormzSubmissionStatus.initial,
        getMaritalStatusStatus: FormzSubmissionStatus.initial,
        getRelationStatus: FormzSubmissionStatus.initial,
        getBloodGroupStatus: FormzSubmissionStatus.initial,
        getDialysisModeListStatus: FormzSubmissionStatus.initial,
        getSchemAdoptedListStatus: FormzSubmissionStatus.initial,
        getRefferedByStatus: FormzSubmissionStatus.initial,
        getGenderStatus: FormzSubmissionStatus.initial,
        getStakeholderSubTypeStatus: FormzSubmissionStatus.initial,
      ));

      http.Response res =
          await masterDataRepository.getMasterDesignationType(event.payload);

      if (res.statusCode == 200) {
        emit(state.copyWith(
            getMasterDesignationTypeResponse: res.body,
            getMasterDesignationTypeStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getMasterDesignationTypeResponse: res.body,
            getMasterDesignationTypeStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(
          getMasterDesignationTypeResponse: e.toString(),
          getMasterDesignationTypeStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onGetGenderRequest(
      GetGenderRequest event, Emitter<MasterDataState> emit) async {
    try {
      emit(state.copyWith(
        getGenderResponse: "",
        getGenderStatus: FormzSubmissionStatus.inProgress,
        getMasterDesignationTypeStatus: FormzSubmissionStatus.initial,
        getMasterStatus: FormzSubmissionStatus.initial,
        getAddressByPincodeStatus: FormzSubmissionStatus.initial,
        getTalukaListStatus: FormzSubmissionStatus.initial,
        getTownListStatus: FormzSubmissionStatus.initial,
        getStateListStatus: FormzSubmissionStatus.initial,
        getDistrictListStatus: FormzSubmissionStatus.initial,
        getDivisionListStatus: FormzSubmissionStatus.initial,
        getSlotListStatus: FormzSubmissionStatus.initial,
        getUnitListStatus: FormzSubmissionStatus.initial,
        getIDProofListStatus: FormzSubmissionStatus.initial,
        getViralLoadStatusStatus: FormzSubmissionStatus.initial,
        schemeAdoptedStatus: FormzSubmissionStatus.initial,
        prefixStatus: FormzSubmissionStatus.initial,
        getMaritalStatusStatus: FormzSubmissionStatus.initial,
        getRelationStatus: FormzSubmissionStatus.initial,
        getBloodGroupStatus: FormzSubmissionStatus.initial,
        getDialysisModeListStatus: FormzSubmissionStatus.initial,
        getSchemAdoptedListStatus: FormzSubmissionStatus.initial,
        getRefferedByStatus: FormzSubmissionStatus.initial,
        getStakeholderSubTypeStatus: FormzSubmissionStatus.initial,
      ));

      http.Response res =
          await masterDataRepository.getMasterDesignationType(event.payload);

      if (res.statusCode == 200) {
        emit(state.copyWith(
            getGenderResponse: res.body,
            getGenderStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getGenderResponse: res.body,
            getGenderStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(
          getGenderResponse: e.toString(),
          getGenderStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onGetStakeholderSubType(
      GetStakeholderSubType event, Emitter<MasterDataState> emit) async {
    try {
      emit(state.copyWith(
        getStakeholderSubTypeResponse: "",
        getStakeholderSubTypeStatus: FormzSubmissionStatus.inProgress,
        getGenderStatus: FormzSubmissionStatus.initial,
        getMasterDesignationTypeStatus: FormzSubmissionStatus.initial,
        getMasterStatus: FormzSubmissionStatus.initial,
        getAddressByPincodeStatus: FormzSubmissionStatus.initial,
        getTalukaListStatus: FormzSubmissionStatus.initial,
        getTownListStatus: FormzSubmissionStatus.initial,
        getStateListStatus: FormzSubmissionStatus.initial,
        getDistrictListStatus: FormzSubmissionStatus.initial,
        getDivisionListStatus: FormzSubmissionStatus.initial,
        getSlotListStatus: FormzSubmissionStatus.initial,
        getUnitListStatus: FormzSubmissionStatus.initial,
        getIDProofListStatus: FormzSubmissionStatus.initial,
        getViralLoadStatusStatus: FormzSubmissionStatus.initial,
        schemeAdoptedStatus: FormzSubmissionStatus.initial,
        prefixStatus: FormzSubmissionStatus.initial,
        getMaritalStatusStatus: FormzSubmissionStatus.initial,
        getRelationStatus: FormzSubmissionStatus.initial,
        getBloodGroupStatus: FormzSubmissionStatus.initial,
        getDialysisModeListStatus: FormzSubmissionStatus.initial,
        getSchemAdoptedListStatus: FormzSubmissionStatus.initial,
        getRefferedByStatus: FormzSubmissionStatus.initial,
      ));

      http.Response res = await masterDataRepository.getMaster(event.payload);

      if (res.statusCode == 200) {
        emit(state.copyWith(
            getStakeholderSubTypeResponse: res.body,
            getStakeholderSubTypeStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getStakeholderSubTypeResponse: res.body,
            getStakeholderSubTypeStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      print(e);

      emit(state.copyWith(
          getStakeholderSubTypeResponse: e.toString(),
          getStakeholderSubTypeStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onGetCampListDropdown(
      GetCampListDropdown event, Emitter<MasterDataState> emit) async {
    try {
      emit(state.copyWith(
        getCampDropdownListResponse: "",
        getCampDropdownListStatus: FormzSubmissionStatus.inProgress,
        getStakeholderSubTypeStatus: FormzSubmissionStatus.initial,
        getGenderStatus: FormzSubmissionStatus.initial,
        getMasterDesignationTypeStatus: FormzSubmissionStatus.initial,
        getMasterStatus: FormzSubmissionStatus.initial,
        getAddressByPincodeStatus: FormzSubmissionStatus.initial,
        getTalukaListStatus: FormzSubmissionStatus.initial,
        getTownListStatus: FormzSubmissionStatus.initial,
        getStateListStatus: FormzSubmissionStatus.initial,
        getDistrictListStatus: FormzSubmissionStatus.initial,
        getDivisionListStatus: FormzSubmissionStatus.initial,
        getSlotListStatus: FormzSubmissionStatus.initial,
        getUnitListStatus: FormzSubmissionStatus.initial,
        getIDProofListStatus: FormzSubmissionStatus.initial,
        getViralLoadStatusStatus: FormzSubmissionStatus.initial,
        schemeAdoptedStatus: FormzSubmissionStatus.initial,
        prefixStatus: FormzSubmissionStatus.initial,
        getMaritalStatusStatus: FormzSubmissionStatus.initial,
        getRelationStatus: FormzSubmissionStatus.initial,
        getBloodGroupStatus: FormzSubmissionStatus.initial,
        getDialysisModeListStatus: FormzSubmissionStatus.initial,
        getSchemAdoptedListStatus: FormzSubmissionStatus.initial,
        getRefferedByStatus: FormzSubmissionStatus.initial,
      ));

      http.Response res =
          await masterDataRepository.getCampListDropdown(event.locationId);

      if (res.statusCode == 200) {
        print(res.body);
        emit(state.copyWith(
            getCampDropdownListResponse: res.body,
            getCampDropdownListStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getCampDropdownListResponse: res.body,
            getCampDropdownListStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      print(e);

      emit(state.copyWith(
          getCampDropdownListResponse: e.toString(),
          getCampDropdownListStatus: FormzSubmissionStatus.failure));
    }
  }

  FutureOr<void> _onResetMasterState(
      ResetMasterState event, Emitter<MasterDataState> emit) async {
    try {
      emit(state.copyWith(
        getUnitListStatus: FormzSubmissionStatus.initial,
        getIDProofListStatus: FormzSubmissionStatus.initial,
        getSlotListStatus: FormzSubmissionStatus.initial,
        getViralLoadStatusStatus: FormzSubmissionStatus.initial,
        schemeAdoptedStatus: FormzSubmissionStatus.initial,
        prefixStatus: FormzSubmissionStatus.initial,
        getMaritalStatusStatus: FormzSubmissionStatus.initial,
        getRelationStatus: FormzSubmissionStatus.initial,
        getDistrictListStatus: FormzSubmissionStatus.initial,
        getDivisionListStatus: FormzSubmissionStatus.initial,
        getStateListStatus: FormzSubmissionStatus.initial,
        getTalukaListStatus: FormzSubmissionStatus.initial,
        getTownListStatus: FormzSubmissionStatus.initial,
        getSchemAdoptedListStatus: FormzSubmissionStatus.initial,
        getBloodGroupStatus: FormzSubmissionStatus.initial,
        getDialysisModeListStatus: FormzSubmissionStatus.initial,
        getRefferedByStatus: FormzSubmissionStatus.initial,
        getAddressByPincodeStatus: FormzSubmissionStatus.initial,
        getMasterStatus: FormzSubmissionStatus.initial,
        getMasterDesignationTypeStatus: FormzSubmissionStatus.initial,
        getGenderStatus: FormzSubmissionStatus.initial,
        getStakeholderSubTypeStatus: FormzSubmissionStatus.initial,
        getSectorTypeStatus: FormzSubmissionStatus.initial,
        getCampDropdownListStatus: FormzSubmissionStatus.initial,
      ));
    } catch (e) {}
  }

  FutureOr<void> _onGetSectorType(
      GetSectorType event, Emitter<MasterDataState> emit) async {
    try {
      emit(state.copyWith(
        getUnitListStatus: FormzSubmissionStatus.initial,
        getUnitListResponse: '',
        getIDProofListResponse: '',
        getIDProofListStatus: FormzSubmissionStatus.initial,
        getSlotListResponse: '',
        getSlotListStatus: FormzSubmissionStatus.initial,
        getViralLoadStatusResponse: '',
        getViralLoadStatusStatus: FormzSubmissionStatus.initial,
        schemeAdoptedResponse: '',
        schemeAdoptedStatus: FormzSubmissionStatus.initial,
        prefixResponse: '',
        prefixStatus: FormzSubmissionStatus.initial,
        getMaritalStatusResponse: '',
        getMaritalStatusStatus: FormzSubmissionStatus.initial,
        getRelationResponse: '',
        getRelationStatus: FormzSubmissionStatus.initial,
        getDistrictListResponse: '',
        getDistrictListStatus: FormzSubmissionStatus.initial,
        getDivisionListResponse: '',
        getDivisionListStatus: FormzSubmissionStatus.initial,
        getStateListResponse: '',
        getStateListStatus: FormzSubmissionStatus.initial,
        getTalukaListResponse: '',
        getTalukaListStatus: FormzSubmissionStatus.initial,
        getTownListResponse: '',
        getTownListStatus: FormzSubmissionStatus.initial,
        getSchemAdoptedListResponse: '',
        getSchemAdoptedListStatus: FormzSubmissionStatus.initial,
        getBloodGroupResponse: '',
        getBloodGroupStatus: FormzSubmissionStatus.initial,
        getDialysisModeListResponse: '',
        getDialysisModeListStatus: FormzSubmissionStatus.initial,
        getRefferedByResponse: '',
        getRefferedByStatus: FormzSubmissionStatus.initial,
        getAddressByPincodeResponse: '',
        getAddressByPincodeStatus: FormzSubmissionStatus.initial,
        getMasterResponse: '',
        getMasterStatus: FormzSubmissionStatus.initial,
        getMasterDesignationTypeResponse: '',
        getMasterDesignationTypeStatus: FormzSubmissionStatus.initial,
        getGenderResponse: '',
        getGenderStatus: FormzSubmissionStatus.initial,
        getStakeholderSubTypeResponse: '',
        getStakeholderSubTypeStatus: FormzSubmissionStatus.initial,
        getCampDropdownListResponse: '',
        getCampDropdownListStatus: FormzSubmissionStatus.initial,
        getSectorTypeResponse: '',
        getSectorTypeStatus: FormzSubmissionStatus.inProgress,
      ));
      http.Response res =
          await masterDataRepository.getMasterDesignationType(event.payload);

      if (res.statusCode == 200) {
        emit(state.copyWith(
            getSectorTypeResponse: res.body,
            getSectorTypeStatus: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(
            getSectorTypeResponse: res.body,
            getSectorTypeStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(
          getSectorTypeResponse: e.toString(),
          getSectorTypeStatus: FormzSubmissionStatus.failure));
    }
  }
}
