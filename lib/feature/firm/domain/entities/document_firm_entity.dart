import 'package:equatable/equatable.dart';

class DocumentFirmEntity extends Equatable {
  const DocumentFirmEntity({
    required this.idDocument,
    required this.idFirm,
    this.nvo,
    this.ta,
    this.usluge,
    this.aktOznaka,
    this.aktDatum,
    this.dopuna,
    this.id,
    this.finished,
    this.ukupno,
    this.idPeriod,
    this.napomena,
  });

  final String idDocument;
  final int idFirm;
  final double? nvo;
  final double? ta;
  final double? usluge;
  final String? aktOznaka;
  final DateTime? aktDatum;
  final String? dopuna;
  final int? id;
  final int? finished;
  final double? ukupno;
  final String? idPeriod;
  final String? napomena;

  @override
  List<Object?> get props => [
        idDocument,
        idFirm,
        nvo,
        ta,
        usluge,
        aktOznaka,
        aktDatum,
        dopuna,
        id,
        finished,
        ukupno,
        idPeriod,
        napomena,
      ];
}
