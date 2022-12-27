import '../../../../../core/enums/firm.dart';
import '../../../domain/entities/document_entity.dart';
import '../../../domain/entities/document_firm_entity.dart';
import '../../../domain/entities/firm_data_entity.dart';
import '../../../domain/entities/firm_entity.dart';

abstract class DocumentsLocalDataSource {
  Future<List<FirmEntity>> getAllFirms();
  Future<List<DocumentEntity>> getAllDocuments();
  Future<List<DocumentFirmEntity>> getAllDocumentsFirms();
  Future<List<DocumentFirmEntity>> getDocumentsFirmsById(String idDocument);
  Future<DocumentEntity> getDocumentById(String idDocument);
  Future<DocumentFirmEntity> getFirmDocumentByFirmAndIdDocument(
      Firm firm, String idDocument);
  Future<List<FirmDataEntity>> getFirmDocumentsByIdFirm(Firm firm);
}
