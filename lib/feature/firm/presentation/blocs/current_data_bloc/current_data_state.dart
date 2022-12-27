part of 'current_data_bloc.dart';

abstract class CurrentDataState extends Equatable {
  const CurrentDataState();

  int? get year => null;
  DocumentType? get documentType => null;
  DocumentSubType? get documentSubType => null;
  Firm? get firm => null;

  String get idDocument {
    String idDoc = '';
    if (year != null && documentType != null) {
      if (documentType == DocumentType.plan) {
        idDoc = '$year-0';
      } else if (documentType == DocumentType.raport &&
          (documentSubType == DocumentSubType.quarter1 ||
              documentSubType == DocumentSubType.quarter2 ||
              documentSubType == DocumentSubType.quarter3 ||
              documentSubType == DocumentSubType.quarter4)) {
        idDoc = '$year-1-${documentSubType!.id}';
      }
    }
    return idDoc;
  }

  @override
  List<Object?> get props => [
        year,
        documentType,
        documentSubType,
        firm,
      ];
}

class CurrentDataInitialState extends CurrentDataState {
  const CurrentDataInitialState();
}

class CurrentDataLoadingState extends CurrentDataState {}

class CurrentDataLoadedState extends CurrentDataState {
  final int? _year;
  final DocumentType? _documentType;
  final DocumentSubType? _documentSubType;
  final Firm? _firm;

  const CurrentDataLoadedState({
    int? year,
    DocumentType? documentType,
    DocumentSubType? documentSubType,
    Firm? firm,
  })  : _year = year,
        _documentType = documentType,
        _documentSubType = documentSubType,
        _firm = firm;

  CurrentDataLoadedState copyWidth({
    int? year,
    DocumentType? documentType,
    DocumentSubType? documentSubType,
    Firm? firm,
  }) {
    return CurrentDataLoadedState(
      year: year ?? _year,
      documentType: documentType ?? _documentType,
      documentSubType: documentSubType ?? _documentSubType,
      firm: firm ?? _firm,
    );
  }

  CurrentDataLoadedState copyWidthIdDocument({
    required String idDocument,
  }) {
    final y = num.tryParse(idDocument.split('-')[0])?.toInt();
    final t = num.tryParse(idDocument.split('-')[1])?.toInt();
    final type = (t == 1 || t == 0) ? DocumentType.getWithId(t) : null;
    final st = num.tryParse(idDocument.split('-')[2])?.toInt();
    final subType = st != null ? DocumentSubType.getWithId(st) : null;

    return CurrentDataLoadedState(
      year: y ?? _year,
      documentType: type ?? _documentType,
      documentSubType: subType ?? _documentSubType,
      firm: _firm, // firm ?? _firm,
    );
  }

  @override
  int? get year => _year;
  @override
  DocumentType? get documentType => _documentType;
  @override
  DocumentSubType? get documentSubType => _documentSubType;
  @override
  Firm? get firm => _firm;
}


  // int? get year {
  //   if (idDocument != null) {
  //     final a = num.tryParse(idDocument!.split('-')[0]);
  //     if (a != null) {
  //       return a.toInt();
  //     }
  //   }
  //   return null;
  // }

  // DocumentType? get documentType {
  //   if (idDocument != null) {
  //     final a = num.tryParse(idDocument!.split('-')[1]);
  //     if (a != null) {
  //       final id = a.toInt();
  //       if (id == 0 || id == 1) {
  //         return DocumentType.getWithId(id);
  //       }
  //     }
  //   }
  //   return null;
  // }

  // DocumentSubType? get documentSubType {
  //   if (documentType == DocumentType.raport) {
  //     final a = num.tryParse(idDocument!.split('-')[2]);
  //     if (a != null) {
  //       final id = a.toInt();
  //       if (id == 1 || id == 2 || id == 3 || id == 4) {
  //         return DocumentSubType.getWithId(id);
  //       }
  //     }
  //   } else if (documentType == DocumentType.plan) {
  //     return DocumentSubType.annual;
  //   }
  //   return null;
  // }


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
