part of 'all_data_bloc.dart';

abstract class AllDataState extends Equatable {
  const AllDataState();

  @override
  List<Object> get props => [];

  List<FirmEntity> get firms => [];

  List<DocumentEntity> get documents => [];

  List<DocumentFirmEntity> get allData => [];

  FirmEntity? getFirmById(int? idFirm) {
    if (firms.any((e) => e.idFirm == idFirm)) {
      return firms.firstWhere((e) => e.idFirm == idFirm);
    }
    return null;
  }

  DocumentEntity? getDocumentById(String? idDocument) {
    if (documents.any((e) => e.idDocument == idDocument)) {
      return documents.firstWhere((e) => e.idDocument == idDocument);
    }
    return null;
  }

  DocumentFirmEntity? getDocumentFirmByIds(int idFirm, String idDocument) {
    if (allData.any((e) => e.idDocument == idDocument && e.idFirm == idFirm)) {
      return allData
          .firstWhere((e) => e.idDocument == idDocument && e.idFirm == idFirm);
    }
    return null;
  }

  List<DocumentFirmEntity> getDataByIdDocument(String idDocument) {
    return allData.where((e) => e.idDocument == idDocument).toList();
  }

  List<DocumentFirmEntity> getDataByIdFirm(int idFirm) {
    return allData.where((e) => e.idFirm == idFirm).toList();
  }

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

  Map<int, Map<DocumentType, List<DocumentSubType>>> get existingDocuments {
    Map<int, Map<DocumentType, List<DocumentSubType>>> data = {};
    for (var e in documents) {
      final year = e.year ?? 0;
      final type = DocumentType.getWithId(e.type);
      final subType = DocumentSubType.getWithId(e.subType);
      if (data.containsKey(year)) {
        Map<DocumentType, List<DocumentSubType>> w;
        w = data[year]!;
        if (w.containsKey(type)) {
          List<DocumentSubType> ls;
          ls = w[type] ?? [];
          ls.add(subType);
          w.putIfAbsent(type, () => ls);
        } else {
          w.addAll({
            type: [subType],
          });
        }
        // data.addAll({year: w});
        data.putIfAbsent(year, () => w);
      } else {
        data.putIfAbsent(
          year,
          () => {
            type: [subType],
          },
        );
      }
    }
    return data;
  }

  Map<int, List<DocumentSubType>> get existingReports {
    Map<int, List<DocumentSubType>> data = {};
    for (var e in documents) {
      final year = e.year ?? 0;
      final type = DocumentType.getWithId(e.type);
      final subType = DocumentSubType.getWithId(e.subType);
      if (type == DocumentType.raport) {
        if (data.containsKey(year)) {
          List<DocumentSubType> w = data[year] ?? [];
          if (!w.contains(subType)) {
            w.add(subType);
          }
          data.putIfAbsent(year, () => w);
        } else {
          data.putIfAbsent(
            year,
            () => [subType],
          );
        }
      }
    }
    return data;
  }

  List<PieDataEntitey> getPieData(String idDocument) {
    // final firms = getIt.get<FirmBloc>().state.firms;
    final listDocFirm = getDataByIdDocument(idDocument);
    List<PieDataEntitey> data = listDocFirm.map((doc) {
      final total = doc.ukupno;
      final firma = firms.firstWhere((f) => f.idFirm == doc.idFirm).name;
      final dat = PieDataEntitey(firma: firma, total: total);
      return dat;
    }).toList();

    return data;
  }

  List<BarDataEntitey> getBarData(String idDocument) {
    final listDocFirm = getDataByIdDocument(idDocument);
    List<BarDataEntitey> data = listDocFirm.map((doc) {
      final total = doc.ukupno;
      final nvo = doc.nvo;
      final ta = doc.ta;
      final usluge = doc.usluge;
      final firma = Firm.getWithId(doc.idFirm);
      final dat = BarDataEntitey(
        firma: firma,
        nvo: nvo,
        ta: ta,
        usluge: usluge,
        total: total,
      );
      return dat;
    }).toList();

    return data;
  }
}

class AllDataInitial extends AllDataState {}

class AllDataLoadingState extends AllDataState {}

class AllDataFirmsLoadedState extends AllDataState {
  final List<FirmEntity> _firms;

  const AllDataFirmsLoadedState({
    required List<FirmEntity> firms,
  }) : _firms = firms;

  @override
  List<FirmEntity> get firms => _firms;
}

class AllDataFirmsAndDocumentLoadedState extends AllDataState {
  final List<FirmEntity> _firms;
  final List<DocumentEntity> _documents;

  const AllDataFirmsAndDocumentLoadedState({
    required List<FirmEntity> firms,
    required List<DocumentEntity> documents,
  })  : _firms = firms,
        _documents = documents;

  @override
  List<FirmEntity> get firms => _firms;

  @override
  List<DocumentEntity> get documents => _documents;
}

class AllDataLoadedState extends AllDataState {
  final List<FirmEntity> _firms;
  final List<DocumentEntity> _documents;
  final List<DocumentFirmEntity> _allData;

  const AllDataLoadedState({
    required List<FirmEntity> firms,
    required List<DocumentEntity> documents,
    required List<DocumentFirmEntity> allData,
  })  : _firms = firms,
        _documents = documents,
        _allData = allData;

  @override
  List<FirmEntity> get firms => _firms;

  @override
  List<DocumentEntity> get documents => _documents;

  @override
  List<DocumentFirmEntity> get allData => _allData;
}

class AllDataRetrievalErrorState extends AllDataState {}
