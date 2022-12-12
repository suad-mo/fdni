part of 'document_bloc.dart';

abstract class DocumentState extends Equatable {
  final List<DocumentEntity> documents;

  const DocumentState({
    this.documents = const <DocumentEntity>[],
  });
  Map<int, Map<DocumentSubType, DocumentType>> get existingYearTypeDocument =>
      {};
  Map<int, Map<DocumentType, DocumentSubType>> get existingDocuments => {};
  @override
  List<Object> get props => [documents];
}

class DocumentInitialState extends DocumentState {}

class DocumentLoadingState extends DocumentState {}

class DocumentLoadedState extends DocumentState {
  const DocumentLoadedState({
    super.documents,
  });

  @override
  List<Object> get props => [documents];

  @override
  Map<int, Map<DocumentSubType, DocumentType>> get existingYearTypeDocument {
    Map<int, Map<DocumentSubType, DocumentType>> data = {};

    // Map<int, Map<DocumentType,DocumentSubType>> data = {};

    for (var e in documents) {
      if (e.year != null && data[e.year] != null) {
        Map<DocumentSubType, DocumentType> r = data[e.year]!;
        r.putIfAbsent(DocumentSubType.getWithId(e.subType),
            () => DocumentType.getWithId(e.type));
        // print(r);
        data.putIfAbsent(e.year!, () => r);
      } else if ((e.year == null && data[e.year] != null)) {
        data = {
          ...data,
          e.year!: {
            DocumentSubType.getWithId(e.subType):
                DocumentType.getWithId(e.type),
          }
        };
      } else {
        data = {
          ...data,
          e.year!: {
            DocumentSubType.getWithId(e.subType):
                DocumentType.getWithId(e.type),
          }
        };
      }
    }
    return data;
  }

  @override
  Map<int, Map<DocumentType, DocumentSubType>> get existingDocuments {
    Map<int, Map<DocumentType, DocumentSubType>> data = {};
    for (var e in documents) {
      // print(e);
      final year = e.year ?? 0;
      final type = DocumentType.getWithId(e.type);
      final subType = DocumentSubType.getWithId(e.subType);
      if (data.containsKey(year)) {
        Map<DocumentType, DocumentSubType> w;
        w = data[year]!;
        if (w.containsKey(type)) {
          // w.addAll(w);
          w.putIfAbsent(type, () => subType);
        } else {
          w.addAll({
            type: subType,
          });
        }
        // data.addAll({year: w});
        data.putIfAbsent(year, () => w);
      } else {
        data.addAll({
          year: {
            type: subType,
          }
        });
        // data.putIfAbsent(year, () => {type: subType});
      }
    }
    return data;
  }
}

class DocumentRetrievalErrorState extends DocumentState {
  final String _message;

  const DocumentRetrievalErrorState({required String message})
      : _message = message;

  String get message => _message;

  @override
  List<Object> get props => [_message];
}

class ExistingDocumentsYearType {
  final Map<int, Map<DocumentType, DocumentSubType>> years;

  ExistingDocumentsYearType(this.years);
}
