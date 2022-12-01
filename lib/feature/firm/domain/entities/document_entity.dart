import 'package:equatable/equatable.dart';

class DocumentEntity extends Equatable {
  const DocumentEntity({
    required this.idDocument,
    this.idPeriod,
    this.countOfId,
    this.year,
    this.type,
    this.subType,
    this.start,
    this.end,
    this.idOld,
    this.note,
    this.docLabel,
    this.docDate,
  });

  final String idDocument;
  final String? idPeriod;
  final int? countOfId;
  final int? year;
  final int? type;
  final int? subType;
  final DateTime? start;
  final DateTime? end;
  final String? idOld;
  final String? note;
  final String? docLabel;
  final DateTime? docDate;

  @override
  List<Object?> get props => [
        idDocument,
        idPeriod,
        countOfId,
        year,
        type,
        subType,
        start,
        end,
        idOld,
        note,
        docLabel,
        docDate,
      ];
}
