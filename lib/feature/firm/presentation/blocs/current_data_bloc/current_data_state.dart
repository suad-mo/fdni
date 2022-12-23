part of 'current_data_bloc.dart';

abstract class CurrentDataState extends Equatable {
  final FirmEntity? currentFirm;
  final DocumentEntity? currentDocument;

  const CurrentDataState({
    this.currentFirm,
    this.currentDocument,
  });

  @override
  List<Object?> get props => [currentFirm, currentDocument];
}

class CurrentDataInitialState extends CurrentDataState {}

class CurrentDataLoadingState extends CurrentDataState {}

class CurrentDataLoadedState extends CurrentDataState {
  const CurrentDataLoadedState({
    super.currentFirm,
    super.currentDocument,
  });
}

// class CurrentDataState extends Equatable {
//   final FirmEntity? _currentFirm;
//   final DocumentEntity? _currentDocument;

//   const CurrentDataState._({
//     FirmEntity? currentFirm,
//     DocumentEntity? currentDocument,
//   })  : _currentDocument = currentDocument,
//         _currentFirm = currentFirm;

//   const CurrentDataState.initial() : this._();

//   const CurrentDataState.changeFirm({required FirmEntity currentFirm})
//       : this._(currentFirm: currentFirm);
      
//   FirmEntity? get currentFirm => _currentFirm;

//   DocumentEntity? get currentDocument => _currentDocument;

//   CurrentDataState copyWith(
//       FirmEntity? currentFirm, DocumentEntity? currentDocument) {
//     return CurrentDataState._(
//       currentDocument: currentDocument ?? _currentDocument,
//       currentFirm: currentFirm ?? _currentFirm,
//     );
//   }

//   @override
//   List<Object?> get props => [currentFirm, currentDocument];
// }

// class CurrentDataInitialState extends CurrentDataState {}

// class CurrentDataLoadingState extends CurrentDataState {}

// class CurrentDataLoadedState extends CurrentDataState {
//   final FirmEntity? _currentFirm;
//   final DocumentEntity? _currentDocument;

//   const CurrentDataLoadedState({
//     FirmEntity? currentFirm,
//     DocumentEntity? currentDocument,
//   })  : _currentFirm = currentFirm,
//         _currentDocument = currentDocument;

//   @override
//   FirmEntity? get currentFirm => _currentFirm;

//   @override
//   DocumentEntity? get currentDocument => _currentDocument;
// }
