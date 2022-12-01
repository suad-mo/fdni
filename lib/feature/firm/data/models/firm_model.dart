import 'dart:convert';

import '../../domain/entities/firm_entity.dart';

class DataFirms {
  DataFirms({
    required this.dataroot,
  });

  final Dataroot? dataroot;

  factory DataFirms.fromRawJson(String str) =>
      DataFirms.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataFirms.fromJson(Map<String, dynamic> json) => DataFirms(
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
    required this.firms,
  });

  final List<FirmModel> firms;

  factory Dataroot.fromRawJson(String str) =>
      Dataroot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Dataroot.fromJson(Map<String, dynamic> json) => Dataroot(
        firms: json["tblFirms"] == null
            ? []
            : List<FirmModel>.from(
                json["tblFirms"].map((x) => FirmModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tblFirms": firms.isEmpty
            ? null
            : List<dynamic>.from(firms.map((x) => x.toJson())),
      };
}

class FirmModel extends FirmEntity {
  const FirmModel({
    required super.idFirm,
    required super.name,
  });

  factory FirmModel.fromRawJson(String str) =>
      FirmModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FirmModel.fromJson(Map<String, dynamic> json) => FirmModel(
        idFirm: json["ID_Firm"] ?? -1,
        name: json["Name"] ?? 'no name',
      );

  Map<String, dynamic> toJson() => {
        "ID_Firm": idFirm,
        "Name": name,
      };
}
