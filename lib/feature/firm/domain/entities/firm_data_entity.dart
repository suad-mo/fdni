import 'package:equatable/equatable.dart';

import 'document_firm_entity.dart';

class FirmDataEntity extends Equatable {
  const FirmDataEntity({
    required this.year,
    required this.type,
    required this.subType,
    required this.nvo,
    required this.ta,
    required this.usluge,
    required this.total,
  });

  final int year;
  final int type;
  final int subType;
  final double nvo;
  final double ta;
  final double usluge;
  final double total;

  @override
  List<Object?> get props => [
        year,
        type,
        subType,
        nvo,
        ta,
        usluge,
        total,
      ];
}

class ConvertData {
  static List<FirmDataEntity> listDocsToData(List<DocumentFirmEntity> list) {
    final newList = list.map((e) {
      final int year = ConvertData._idDocumentToMap(e.idDocument)['year'] ?? 0;
      final int type = ConvertData._idDocumentToMap(e.idDocument)['type'] ?? 0;
      final int subType =
          ConvertData._idDocumentToMap(e.idDocument)['subType'] ?? 0;
      final double nvo = e.nvo ?? 0;
      final double ta = e.ta ?? 0;
      final double usluge = e.usluge ?? 0;
      final double total = e.ukupno ?? 0;
      return FirmDataEntity(
        year: year,
        type: type,
        subType: subType,
        nvo: nvo,
        ta: ta,
        usluge: usluge,
        total: total,
      );
    }).toList();
    return newList;
  }

  static List<FirmDataExtendEntity> extendFirmDataType1(
      List<FirmDataEntity> list) {
    final x = <FirmDataExtendEntity>[];
    final y = list.where((e) => e.type == 1).toList();

    FirmDataExtendEntity? prevData;

    for (var e in y) {
      if (prevData == null) {
        final data = FirmDataExtendEntity(
          dNvo: e.nvo,
          dTa: e.ta,
          dUsluge: e.usluge,
          dtotal: e.total,
          year: e.year,
          type: e.type,
          subType: e.subType,
          nvo: e.nvo,
          ta: e.ta,
          usluge: e.usluge,
          total: e.total,
        );
        x.add(data);
        prevData = data;
      } else {
        if (e.year == prevData.year) {
          if ((e.subType - prevData.subType) == 1) {
            final data = FirmDataExtendEntity(
              dNvo: e.nvo - prevData.dNvo,
              dTa: e.ta - prevData.ta,
              dUsluge: e.usluge - prevData.usluge,
              dtotal: e.total - prevData.total,
              year: e.year,
              type: e.type,
              subType: e.subType,
              nvo: e.nvo,
              ta: e.ta,
              usluge: e.usluge,
              total: e.total,
            );
            x.add(data);
            if (e.subType == 4) {
              prevData = null;
            } else {
              prevData = data;
            }
          } else {
            final data = FirmDataExtendEntity(
              dNvo: e.nvo,
              dTa: e.ta,
              dUsluge: e.usluge,
              dtotal: e.total,
              year: e.year,
              type: e.type,
              subType: e.subType,
              nvo: e.nvo,
              ta: e.ta,
              usluge: e.usluge,
              total: e.total,
            );
            x.add(data);

            prevData = null;
          }
        } else {
          final data = FirmDataExtendEntity(
            dNvo: e.nvo,
            dTa: e.ta,
            dUsluge: e.usluge,
            dtotal: e.total,
            year: e.year,
            type: e.type,
            subType: e.subType,
            nvo: e.nvo,
            ta: e.ta,
            usluge: e.usluge,
            total: e.total,
          );
          x.add(data);
          prevData = data;
        }
      }
    }

    return x;
  }

  static Map<String, int> _idDocumentToMap(String idDocument) {
    int year = DateTime.now().year;
    int type = 0;
    int subType = 0;
    try {
      year = int.parse(idDocument.split('-')[0]);
      type = int.parse(idDocument.split('-')[1]);
      subType = int.parse(idDocument.split('-')[2]);
    } catch (e) {
      return {
        'year': year,
        'type': type,
        'subType': subType,
      };
    }

    return {
      'year': year,
      'type': type,
      'subType': subType,
    };
  }
}

class FirmDataExtendEntity extends FirmDataEntity {
  final double dNvo;
  final double dTa;
  final double dUsluge;
  final double dtotal;
  const FirmDataExtendEntity({
    required this.dNvo,
    required this.dTa,
    required this.dUsluge,
    required this.dtotal,
    required super.year,
    required super.type,
    required super.subType,
    required super.nvo,
    required super.ta,
    required super.usluge,
    required super.total,
  });
}
