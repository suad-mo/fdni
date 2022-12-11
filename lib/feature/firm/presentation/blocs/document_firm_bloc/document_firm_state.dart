part of 'document_firm_bloc.dart';

abstract class DocumentFirmState extends Equatable {
  const DocumentFirmState();

  @override
  List<Object> get props => [];

  List<PieDataEntitey> get pieData => [];

  List<BarDataEntitey> get barData => [];

  DocumentEntity get doc => const DocumentEntity(idDocument: '-1');

  List<DocumentFirmEntity> get firmDocs => [];
}

class DocumentFirmInitialState extends DocumentFirmState {}

class DocumentFirmLoadingState extends DocumentFirmState {}

class DocumentFirmByIdLoadedState extends DocumentFirmState {
  final List<DocumentFirmEntity> listDocFirm;
  final DocumentEntity document;

  const DocumentFirmByIdLoadedState({
    required this.listDocFirm,
    required this.document,
  });

  double get totalNvo {
    double total = 0;
    for (var e in listDocFirm) {
      if (e.nvo != null) {
        total += e.nvo!;
      }
    }
    return total;
  }

  @override
  DocumentEntity get doc => document;

  @override
  List<PieDataEntitey> get pieData {
    final firms = getIt.get<FirmBloc>().state.firms;
    List<PieDataEntitey> data = listDocFirm.map((doc) {
      final total = doc.ukupno;
      final firma = firms.firstWhere((f) => f.idFirm == doc.idFirm).name;
      final dat = PieDataEntitey(firma: firma, total: total);
      return dat;
    }).toList();

    return data;
  }

  @override
  List<BarDataEntitey> get barData {
    List<BarDataEntitey> data = listDocFirm.map((doc) {
      final total = doc.ukupno;
      final nvo = doc.nvo;
      final ta = doc.ta;
      final usluge = doc.usluge;
      final firma = Firms.getWithId(doc.idFirm);
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

  double get totalTa {
    double total = 0;
    for (var e in listDocFirm) {
      if (e.ta != null) {
        total += e.ta!;
      }
    }
    return total;
  }

  double get totalUsluge {
    double total = 0;
    for (var e in listDocFirm) {
      if (e.usluge != null) {
        total += e.usluge!;
      }
    }
    return total;
  }

  double get totalA => totalNvo + totalTa + totalUsluge;
}

class DocumentFirmRetrievalErrorState extends DocumentFirmState {
  final String _message;

  const DocumentFirmRetrievalErrorState({required String message})
      : _message = message;

  String get message => _message;

  @override
  List<Object> get props => [_message];
}
