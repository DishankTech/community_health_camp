part of 'master_data_bloc.dart';

class MasterDataState extends Equatable {
  const MasterDataState({
    required this.getUnitListStatus,
    required this.getUnitListResponse,
    required this.getViralLoadStatusStatus,
    required this.getViralLoadStatusResponse,
    required this.getIDProofListStatus,
    required this.getIDProofListResponse,
    required this.schemeAdoptedStatus,
    required this.schemeAdoptedResponse,
    required this.getSlotListStatus,
    required this.getSlotListResponse,
    required this.prefixResponse,
    required this.prefixStatus,
    required this.getMaritalStatusResponse,
    required this.getMaritalStatusStatus,
    required this.getRelationStatus,
    required this.getRelationResponse,
    required this.getDistrictListResponse,
    required this.getDistrictListStatus,
    required this.getDivisionListResponse,
    required this.getDivisionListStatus,
    required this.getStateListResponse,
    required this.getStateListStatus,
    required this.getTalukaListResponse,
    required this.getTalukaListStatus,
    required this.getTownListResponse,
    required this.getTownListStatus,
    required this.getSchemAdoptedListResponse,
    required this.getSchemAdoptedListStatus,
    required this.getBloodGroupStatus,
    required this.getBloodGroupResponse,
    required this.getDialysisModeListStatus,
    required this.getDialysisModeListResponse,
    required this.getRefferedByStatus,
    required this.getRefferedByResponse,
    required this.getAddressByPincodeResponse,
    required this.getAddressByPincodeStatus,
    required this.getMasterResponse,
    required this.getMasterStatus,
    required this.getMasterDesignationTypeResponse,
    required this.getMasterDesignationTypeStatus,
    required this.getGenderResponse,
    required this.getGenderStatus,
    required this.getStakeholderSubTypeResponse,
    required this.getStakeholderSubTypeStatus,
    required this.getCampDropdownListResponse,
    required this.getCampDropdownListStatus,
    required this.getSectorTypeResponse,
    required this.getSectorTypeStatus,
  });

  final FormzSubmissionStatus prefixStatus;
  final String prefixResponse;

  final FormzSubmissionStatus getUnitListStatus;
  final String getUnitListResponse;

  final FormzSubmissionStatus getViralLoadStatusStatus;
  final String getViralLoadStatusResponse;

  final FormzSubmissionStatus getIDProofListStatus;
  final String getIDProofListResponse;

  final FormzSubmissionStatus schemeAdoptedStatus;
  final String schemeAdoptedResponse;

  final FormzSubmissionStatus getSlotListStatus;
  final String getSlotListResponse;

  final FormzSubmissionStatus getMaritalStatusStatus;
  final String getMaritalStatusResponse;

  final FormzSubmissionStatus getRelationStatus;
  final String getRelationResponse;

  final FormzSubmissionStatus getDivisionListStatus;
  final String getDivisionListResponse;

  final FormzSubmissionStatus getDistrictListStatus;
  final String getDistrictListResponse;

  final FormzSubmissionStatus getStateListStatus;
  final String getStateListResponse;

  final FormzSubmissionStatus getTalukaListStatus;
  final String getTalukaListResponse;

  final FormzSubmissionStatus getTownListStatus;
  final String getTownListResponse;

  final FormzSubmissionStatus getSchemAdoptedListStatus;
  final String getSchemAdoptedListResponse;

  final FormzSubmissionStatus getBloodGroupStatus;
  final String getBloodGroupResponse;

  final FormzSubmissionStatus getDialysisModeListStatus;
  final String getDialysisModeListResponse;

  final FormzSubmissionStatus getRefferedByStatus;
  final String getRefferedByResponse;

  final FormzSubmissionStatus getAddressByPincodeStatus;
  final String getAddressByPincodeResponse;

  final FormzSubmissionStatus getMasterStatus;
  final String getMasterResponse;

  final FormzSubmissionStatus getMasterDesignationTypeStatus;
  final String getMasterDesignationTypeResponse;
  final FormzSubmissionStatus getGenderStatus;
  final String getGenderResponse;

  final FormzSubmissionStatus getStakeholderSubTypeStatus;
  final String getStakeholderSubTypeResponse;
  final FormzSubmissionStatus getCampDropdownListStatus;
  final String getCampDropdownListResponse;

  final FormzSubmissionStatus getSectorTypeStatus;
  final String getSectorTypeResponse;

  MasterDataState copyWith({
    FormzSubmissionStatus? getUnitListStatus,
    String? getUnitListResponse,
    FormzSubmissionStatus? getViralLoadStatusStatus,
    String? getViralLoadStatusResponse,
    FormzSubmissionStatus? getIDProofListStatus,
    String? getIDProofListResponse,
    FormzSubmissionStatus? schemeAdoptedStatus,
    String? schemeAdoptedResponse,
    FormzSubmissionStatus? getSlotListStatus,
    String? getSlotListResponse,
    FormzSubmissionStatus? prefixStatus,
    String? prefixResponse,
    FormzSubmissionStatus? getMaritalStatusStatus,
    String? getMaritalStatusResponse,
    FormzSubmissionStatus? getRelationStatus,
    String? getRelationResponse,
    FormzSubmissionStatus? getDivisionListStatus,
    String? getDivisionListResponse,
    FormzSubmissionStatus? getDistrictListStatus,
    String? getDistrictListResponse,
    FormzSubmissionStatus? getStateListStatus,
    String? getStateListResponse,
    FormzSubmissionStatus? getTalukaListStatus,
    String? getTalukaListResponse,
    FormzSubmissionStatus? getTownListStatus,
    String? getTownListResponse,
    FormzSubmissionStatus? getSchemAdoptedListStatus,
    String? getSchemAdoptedListResponse,
    FormzSubmissionStatus? getBloodGroupStatus,
    String? getBloodGroupResponse,
    FormzSubmissionStatus? getDialysisModeListStatus,
    String? getDialysisModeListResponse,
    FormzSubmissionStatus? getRefferedByStatus,
    String? getRefferedByResponse,
    FormzSubmissionStatus? getAddressByPincodeStatus,
    String? getAddressByPincodeResponse,
    FormzSubmissionStatus? getMasterStatus,
    String? getMasterResponse,
    FormzSubmissionStatus? getMasterDesignationTypeStatus,
    String? getMasterDesignationTypeResponse,
    FormzSubmissionStatus? getGenderStatus,
    String? getGenderResponse,
    FormzSubmissionStatus? getStakeholderSubTypeStatus,
    String? getStakeholderSubTypeResponse,
    FormzSubmissionStatus? getCampDropdownListStatus,
    String? getCampDropdownListResponse,
    FormzSubmissionStatus? getSectorTypeStatus,
    String? getSectorTypeResponse,
  }) {
    return MasterDataState(
      prefixResponse: prefixResponse ?? this.prefixResponse,
      prefixStatus: prefixStatus ?? this.prefixStatus,
      getUnitListStatus: getUnitListStatus ?? this.getUnitListStatus,
      getUnitListResponse: getUnitListResponse ?? this.getUnitListResponse,
      getViralLoadStatusStatus:
          getViralLoadStatusStatus ?? this.getViralLoadStatusStatus,
      getViralLoadStatusResponse:
          getViralLoadStatusResponse ?? this.getViralLoadStatusResponse,
      getIDProofListStatus: getIDProofListStatus ?? this.getIDProofListStatus,
      getIDProofListResponse:
          getIDProofListResponse ?? this.getIDProofListResponse,
      schemeAdoptedStatus: schemeAdoptedStatus ?? this.schemeAdoptedStatus,
      schemeAdoptedResponse:
          schemeAdoptedResponse ?? this.schemeAdoptedResponse,
      getSlotListStatus: getSlotListStatus ?? this.getSlotListStatus,
      getSlotListResponse: getSlotListResponse ?? this.getSlotListResponse,
      getMaritalStatusResponse:
          getMaritalStatusResponse ?? this.getMaritalStatusResponse,
      getMaritalStatusStatus:
          getMaritalStatusStatus ?? this.getMaritalStatusStatus,
      getRelationResponse: getRelationResponse ?? this.getRelationResponse,
      getRelationStatus: getRelationStatus ?? this.getRelationStatus,
      getDistrictListResponse:
          getDistrictListResponse ?? this.getDistrictListResponse,
      getDistrictListStatus:
          getDistrictListStatus ?? this.getDistrictListStatus,
      getDivisionListResponse:
          getDivisionListResponse ?? this.getDivisionListResponse,
      getDivisionListStatus:
          getDivisionListStatus ?? this.getDivisionListStatus,
      getStateListResponse: getStateListResponse ?? this.getStateListResponse,
      getStateListStatus: getStateListStatus ?? this.getStateListStatus,
      getTalukaListResponse:
          getTalukaListResponse ?? this.getTalukaListResponse,
      getTalukaListStatus: getTalukaListStatus ?? this.getTalukaListStatus,
      getTownListResponse: getTownListResponse ?? this.getTownListResponse,
      getTownListStatus: getTownListStatus ?? this.getTownListStatus,
      getSchemAdoptedListResponse:
          getSchemAdoptedListResponse ?? this.getSchemAdoptedListResponse,
      getSchemAdoptedListStatus:
          getSchemAdoptedListStatus ?? this.getSchemAdoptedListStatus,
      getBloodGroupResponse:
          getBloodGroupResponse ?? this.getBloodGroupResponse,
      getBloodGroupStatus: getBloodGroupStatus ?? this.getBloodGroupStatus,
      getDialysisModeListResponse:
          getDialysisModeListResponse ?? this.getDialysisModeListResponse,
      getDialysisModeListStatus:
          getDialysisModeListStatus ?? this.getDialysisModeListStatus,
      getRefferedByResponse:
          getRefferedByResponse ?? this.getRefferedByResponse,
      getRefferedByStatus: getRefferedByStatus ?? this.getRefferedByStatus,
      getAddressByPincodeResponse:
          getAddressByPincodeResponse ?? this.getAddressByPincodeResponse,
      getAddressByPincodeStatus:
          getAddressByPincodeStatus ?? this.getAddressByPincodeStatus,
      getMasterResponse: getMasterResponse ?? this.getMasterResponse,
      getMasterStatus: getMasterStatus ?? this.getMasterStatus,
      getMasterDesignationTypeResponse: getMasterDesignationTypeResponse ??
          this.getMasterDesignationTypeResponse,
      getMasterDesignationTypeStatus:
          getMasterDesignationTypeStatus ?? this.getMasterDesignationTypeStatus,
      getGenderResponse: getGenderResponse ?? this.getGenderResponse,
      getGenderStatus: getGenderStatus ?? this.getGenderStatus,
      getStakeholderSubTypeResponse:
          getStakeholderSubTypeResponse ?? this.getStakeholderSubTypeResponse,
      getStakeholderSubTypeStatus:
          getStakeholderSubTypeStatus ?? this.getStakeholderSubTypeStatus,
      getCampDropdownListResponse:
          getCampDropdownListResponse ?? this.getCampDropdownListResponse,
      getCampDropdownListStatus:
          getCampDropdownListStatus ?? this.getCampDropdownListStatus,
      getSectorTypeResponse:
          getSectorTypeResponse ?? this.getSectorTypeResponse,
      getSectorTypeStatus: getSectorTypeStatus ?? this.getSectorTypeStatus,
    );
  }

  @override
  List<Object> get props => [
        getUnitListStatus,
        getUnitListResponse,
        getViralLoadStatusResponse,
        getViralLoadStatusStatus,
        getIDProofListResponse,
        getIDProofListStatus,
        getSlotListResponse,
        getSlotListStatus,
        schemeAdoptedStatus,
        schemeAdoptedResponse,
        prefixResponse,
        prefixStatus,
        getMaritalStatusResponse,
        getMaritalStatusStatus,
        getRelationResponse,
        getRelationStatus,
        getDistrictListResponse,
        getDistrictListStatus,
        getDivisionListResponse,
        getDivisionListStatus,
        getStateListResponse,
        getStateListStatus,
        getTalukaListResponse,
        getTalukaListStatus,
        getTownListResponse,
        getTownListStatus,
        getSchemAdoptedListResponse,
        getSchemAdoptedListStatus,
        getBloodGroupResponse,
        getBloodGroupStatus,
        getDialysisModeListResponse,
        getDialysisModeListStatus,
        getRefferedByResponse,
        getRefferedByStatus,
        getAddressByPincodeResponse,
        getAddressByPincodeStatus,
        getMasterResponse,
        getMasterStatus,
        getMasterDesignationTypeResponse,
        getMasterDesignationTypeStatus,
        getGenderResponse,
        getGenderStatus,
        getStakeholderSubTypeResponse,
        getStakeholderSubTypeStatus,
        getCampDropdownListResponse,
        getCampDropdownListStatus,
        getSectorTypeResponse,
        getSectorTypeStatus
      ];
}
