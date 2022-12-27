import 'package:dartz/dartz.dart';
import 'package:fdni/feature/firm/domain/entities/document_entity.dart';
import 'package:fdni/feature/firm/domain/entities/document_firm_entity.dart';
import 'package:fdni/feature/firm/domain/entities/firm_entity.dart';

import '../../../../core/enums/firm.dart';
import '../../../../core/error/failures.dart';
import '../entities/firm_data_entity.dart';

abstract class DocumentRepository {
  Future<Either<Failure, List<FirmEntity>>> getAllFirms();
  Future<Either<Failure, List<DocumentEntity>>> getAllDocuments();
  Future<Either<Failure, List<DocumentFirmEntity>>> getAllDocumentsFirms();
  Future<Either<Failure, List<DocumentFirmEntity>>>
      getDocumentsFirmsByIdDocument(String idDocument);

  Future<Either<Failure, DocumentEntity>> getDocumentById(String idDocument);

  Future<Either<Failure, List<FirmDataEntity>>> getFirmDocumentsByFirm(
      Firm firm);
}
