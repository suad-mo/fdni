part of 'firm_all_documents_bloc.dart';

abstract class FirmAllDocumentsState extends Equatable {
  const FirmAllDocumentsState();

  @override
  List<Object> get props => [];

  List<FirmDataEntity> get documents => [];

  List<FirmDataExtendEntity> get extendDocuments => [];
  List<FirmDataExtendEntity> getDocsBySubType(int subType) =>
      extendDocuments.where((e) => e.subType == subType).toList();

  List<FirmDataEntity> get docsType1 =>
      documents.where((e) => e.type == 1).toList();
}

class FirmAllDocumentsInitialState extends FirmAllDocumentsState {}

class FirmAllDocumentsLoadingState extends FirmAllDocumentsState {}

class FirmAllDocumentsLoadedState extends FirmAllDocumentsState {
  final List<FirmDataEntity> _allDocuments;

  const FirmAllDocumentsLoadedState(List<FirmDataEntity> allDocuments)
      : _allDocuments = allDocuments;

  @override
  List<FirmDataEntity> get documents => _allDocuments;

  @override
  List<FirmDataExtendEntity> get extendDocuments =>
      ConvertData.extendFirmDataType1(_allDocuments);
}

class FirmAllDocumentsRetrievalErrorState extends FirmAllDocumentsState {
  final String _message;

  const FirmAllDocumentsRetrievalErrorState({required String message})
      : _message = message;

  String get message => _message;

  @override
  List<Object> get props => [_message];
}
