// To parse this JSON data, do
//
//     final dataDocumentsFirms = dataDocumentsFirmsFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/document_firm_entity.dart';

class DataDocumentsFirms {
  DataDocumentsFirms({
    required this.dataroot,
  });

  final Dataroot? dataroot;

  factory DataDocumentsFirms.fromRawJson(String str) =>
      DataDocumentsFirms.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataDocumentsFirms.fromJson(Map<String, dynamic> json) =>
      DataDocumentsFirms(
        dataroot: json["dataroot"] == null
            ? null
            : Dataroot.fromJson(json["dataroot"]),
      );

  Map<String, dynamic> toJson() => {
        "dataroot": dataroot == null ? null : dataroot!.toJson(),
      };
}

class Dataroot {
  Dataroot({
    required this.tblDocumentsFirms,
  });

  final List<DocumentFirmModel>? tblDocumentsFirms;

  factory Dataroot.fromRawJson(String str) =>
      Dataroot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Dataroot.fromJson(Map<String, dynamic> json) => Dataroot(
        tblDocumentsFirms: json["tblDocumentsFirms"] == null
            ? null
            : List<DocumentFirmModel>.from(json["tblDocumentsFirms"]
                .map((x) => DocumentFirmModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tblDocumentsFirms": tblDocumentsFirms == null
            ? null
            : List<dynamic>.from(tblDocumentsFirms!.map((x) => x.toJson())),
      };
}

class DocumentFirmModel extends DocumentFirmEntity {
  const DocumentFirmModel({
    required super.idDocument,
    required super.idFirm,
    super.nvo,
    super.ta,
    super.usluge,
    super.aktOznaka,
    super.aktDatum,
    super.dopuna,
    super.id,
    super.finished,
    super.ukupno,
    super.idPeriod,
    super.napomena,
  });

  factory DocumentFirmModel.fromRawJson(String str) =>
      DocumentFirmModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DocumentFirmModel.fromJson(Map<String, dynamic> json) =>
      DocumentFirmModel(
        idDocument: json["ID_Document"] ?? 'NoIdDocument',
        idFirm: json["ID_Firm"] ?? -1,
        nvo: json["NVO"] == null ? null : num.tryParse(json["NVO"]) as double?,
        ta: json["TA"] == null ? null : num.tryParse(json["TA"]) as double?,
        usluge: json["Usluge"] == null
            ? null
            : num.tryParse(json["Usluge"]) as double?,
        aktOznaka: json["AktOznaka"],
        aktDatum:
            json["AktDatum"] == null ? null : DateTime.parse(json["AktDatum"]),
        dopuna: json["Dopuna"],
        id: json["ID"],
        finished: json["Finished"],
        ukupno: json["Ukupno"] == null
            ? null
            : num.tryParse(json["Ukupno"]) as double?,
        idPeriod: json["ID_Period"],
        napomena: json["Napomena"],
      );

  Map<String, dynamic> toJson() => {
        "ID_Document": idDocument,
        "ID_Firm": idFirm,
        "NVO": nvo,
        "TA": ta,
        "Usluge": usluge,
        "AktOznaka": aktOznaka,
        "AktDatum": aktDatum == null ? null : aktDatum!.toIso8601String(),
        "Dopuna": dopuna,
        "ID": id,
        "Finished": finished,
        "Ukupno": ukupno,
        "ID_Period": idPeriod,
        "Napomena": napomena,
      };
}
