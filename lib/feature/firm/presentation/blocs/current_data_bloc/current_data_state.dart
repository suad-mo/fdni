part of 'current_data_bloc.dart';

abstract class CurrentDataState extends Equatable {
  const CurrentDataState({
    FirmEntity? currentFirm,
    DocumentEntity? currentDocument,
  })  : _currentFirm = currentFirm,
        _currentDocument = currentDocument;

  const CurrentDataState.copyWith(
    FirmEntity? currentFirm,
    DocumentEntity? currentDocument,
  )   : _currentDocument = currentDocument, // ?? _currentDocument,
        _currentFirm = currentFirm; // ?? this._currentFirm;

  final FirmEntity? _currentFirm;
  final DocumentEntity? _currentDocument;

  FirmEntity? get currentFirm => _currentFirm;

  DocumentEntity? get currentDocument => _currentDocument;

  @override
  List<Object> get props => [];
}

class CurrentDataLoadingState extends CurrentDataState {}

class CurrentDataLoadedState extends CurrentDataState {
  const CurrentDataLoadedState.copyWidh(CurrentDataState state);
}

class CurrentDataInitial extends CurrentDataState {}
