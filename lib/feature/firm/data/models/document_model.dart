import 'dart:convert';

import 'package:fdni/feature/firm/domain/entities/document_entity.dart';

class DataDocuments {
  DataDocuments({
    required this.dataroot,
  });

  final Dataroot? dataroot;

  factory DataDocuments.fromRawJson(String str) =>
      DataDocuments.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataDocuments.fromJson(Map<String, dynamic> json) => DataDocuments(
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
    required this.tblDocuments,
  });

  final List<DocumentModel>? tblDocuments;

  factory Dataroot.fromRawJson(String str) =>
      Dataroot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Dataroot.fromJson(Map<String, dynamic> json) => Dataroot(
        tblDocuments: json["tblDocuments"] == null
            ? null
            : List<DocumentModel>.from(
                json["tblDocuments"].map((x) => DocumentModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tblDocuments": tblDocuments == null
            ? null
            : List<dynamic>.from(tblDocuments!.map((x) => x.toJson())),
      };
}

class DocumentModel extends DocumentEntity {
  const DocumentModel({
    required super.idDocument,
    super.idPeriod,
    super.countOfId,
    super.year,
    super.type,
    super.subType,
    super.start,
    super.end,
    super.idOld,
    super.note,
    super.docLabel,
    super.docDate,
  });

  factory DocumentModel.fromRawJson(String str) =>
      DocumentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DocumentModel.fromJson(Map<String, dynamic> json) => DocumentModel(
        idDocument: json["ID_Document"] ?? 'NoIdDocument',
        idPeriod: json["ID_Period"],
        countOfId: json["CountOfID"] == null
            ? null
            : num.tryParse(json["CountOfID"].toString()) as int?,
        year: json["Year"] == null
            ? null
            : num.tryParse(json["Year"].toString()) as int?,
        type: json["Type"] == null
            ? null
            : num.tryParse(json["Type"].toString()) as int?,
        subType: json["SubType"] == null
            ? null
            : num.tryParse(json["SubType"].toString()) as int?,
        start: json["Start"] == null ? null : DateTime.parse(json["Start"]),
        end: json["End"] == null ? null : DateTime.parse(json["End"]),
        idOld: json["ID_Old"],
        note: json["Note"],
        docLabel: json["DocLabel"],
        docDate:
            json["DocDate"] == null ? null : DateTime.parse(json["DocDate"]),
      );

  Map<String, dynamic> toJson() => {
        "ID_Document": idDocument,
        "ID_Period": idPeriod,
        "CountOfID": countOfId,
        "Year": year,
        "Type": type,
        "SubType": subType,
        "Start": start == null ? null : start!.toIso8601String(),
        "End": end == null ? null : end!.toIso8601String(),
        "ID_Old": idOld,
        "Note": note,
        "DocLabel": docLabel,
        "DocDate": docDate == null ? null : docDate!.toIso8601String(),
      };
}
