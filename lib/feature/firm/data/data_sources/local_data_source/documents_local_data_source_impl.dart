import 'package:fdni/core/enums/firms.dart';

import '../../../../../core/input_data/fixture_reader.dart';
import '../../../domain/entities/document_entity.dart';
import '../../../domain/entities/document_firm_entity.dart';
import '../../../domain/entities/firm_data_entity.dart';
import '../../../domain/entities/firm_entity.dart';
import '../../models/document_model.dart';
import '../../models/document_firm_model.dart';
import '../../models/firm_model.dart';
import 'documents_local_data_source.dart';

class DocumentsLocalDataSourceImpl implements DocumentsLocalDataSource {
  @override
  Future<List<FirmEntity>> getAllFirms() async {
    try {
      const String fileName = 'data_firms.json';
      final xMap = await readJsonFile(fileName);
      final jsonData = xMap['dataroot']['tblFirms'];
      final List<FirmEntity> firms = xMap == null
          ? []
          : List<FirmModel>.from(jsonData.map((x) => FirmModel.fromJson(x)));
      return firms;
    } catch (e) {
      //print(e.toString());
      return [];
    }
  }

  @override
  Future<List<DocumentEntity>> getAllDocuments() async {
    try {
      const String fileName = 'data_documents.json';
      final xMap = await readJsonFile(fileName);
      final jsonData = xMap['dataroot']['tblDocuments'];
      final List<DocumentEntity> documents = xMap == null
          ? []
          : List<DocumentEntity>.from(
              jsonData.map((x) => DocumentModel.fromJson(x)));
      return documents;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<DocumentFirmEntity>> getAllDocumentsFirms() async {
    try {
      const String fileName = 'data_documents_firms.json';
      final xMap = await readJsonFile(fileName);
      final jsonData = xMap['dataroot']['tblDocumentsFirms'];
      final List<DocumentFirmEntity> documents = xMap == null
          ? []
          : List<DocumentFirmEntity>.from(
              jsonData.map((x) => DocumentFirmModel.fromJson(x)));
      return documents;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<DocumentFirmEntity>> getDocumentsFirmsById(
      String idDocument) async {
    try {
      const String fileName = 'data_documents_firms.json';
      final xMap = await readJsonFile(fileName);
      final jsonData = xMap['dataroot']['tblDocumentsFirms'];
      final List<DocumentFirmEntity> documents = xMap == null
          ? []
          : List<DocumentFirmEntity>.from(
              jsonData.map((x) => DocumentFirmModel.fromJson(x)));
      final x = documents
          .where((value) =>
              value.idDocument.compareTo(idDocument) == 0 &&
              value.ukupno != null &&
              value.ukupno! > 0)
          .toList();
      x.sort(((a, b) => b.ukupno!.compareTo(a.ukupno!)));
      return x;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<FirmDataEntity>> getFirmDocumentsByIdFirm(Firms firm) async {
    try {
      const String fileName = 'data_documents_firms.json';
      final xMap = await readJsonFile(fileName);
      final jsonData = xMap['dataroot']['tblDocumentsFirms'];
      final List<DocumentFirmEntity> documents = xMap == null
          ? []
          : List<DocumentFirmEntity>.from(
              jsonData.map((x) => DocumentFirmModel.fromJson(x)));
      //print(documents);
      final x = documents
          .where((doc) =>
              doc.idFirm == firm.id && doc.ukupno != null && doc.ukupno! > 0) //
          .toList();
      x.sort(((a, b) => a.idDocument.compareTo(b.idDocument)));
      final convertList = ConvertData.listDocsToData(x);
      return convertList;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<DocumentEntity> getDocumentById(String idDocument) async {
    final docs = await getAllDocuments();
    final doc = docs.firstWhere((d) => d.idDocument == idDocument);
    return doc;
  }

  @override
  Future<DocumentFirmEntity> getFirmDocumentByFirmAndIdDocument(
      Firms firm, String idDocument) async {
    final docs = await getDocumentsFirmsById(idDocument);
    final doc = docs.firstWhere((d) => d.idFirm == firm.id);
    return doc;
  }
}
