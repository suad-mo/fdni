import 'package:fdni/core/enums/firm.dart';
import 'package:fdni/feature/firm/domain/entities/document_firm_entity.dart';
import 'package:fdni/feature/firm/domain/entities/document_entity.dart';
import 'package:fdni/feature/firm/domain/entities/firm_entity.dart';
import 'package:fdni/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/firm_data_entity.dart';
import '../../domain/repositories/document_repository.dart';
import '../data_sources/local_data_source/documents_local_data_source.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  final DocumentsLocalDataSource _localDataSource;

  DocumentRepositoryImpl({
    required DocumentsLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;
  @override
  Future<Either<Failure, List<FirmEntity>>> getAllFirms() async {
    try {
      final firms = await _localDataSource.getAllFirms();
      return Right(firms);
    } catch (e) {
      final failure = CacheFailure();
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<DocumentEntity>>> getAllDocuments() async {
    try {
      final documents = await _localDataSource.getAllDocuments();
      return Right(documents);
    } catch (e) {
      final failure = CacheFailure();
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<DocumentFirmEntity>>>
      getAllDocumentsFirms() async {
    try {
      final documentsFirms = await _localDataSource.getAllDocumentsFirms();
      return Right(documentsFirms);
    } catch (e) {
      final failure = CacheFailure();
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<DocumentFirmEntity>>>
      getDocumentsFirmsByIdDocument(String id) async {
    try {
      final documentsFirms = await _localDataSource.getDocumentsFirmsById(id);
      return Right(documentsFirms);
    } catch (e) {
      final failure = CacheFailure();
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, DocumentEntity>> getDocumentById(
      String idDocument) async {
    try {
      final document = await _localDataSource.getDocumentById(idDocument);
      return Right(document);
    } catch (e) {
      final failure = CacheFailure();
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, List<FirmDataEntity>>> getFirmDocumentsByFirm(
      Firm firm) async {
    try {
      final documents = await _localDataSource.getFirmDocumentsByIdFirm(firm);
      //print(documents);
      return Right(documents);
    } catch (e) {
      final failure = CacheFailure();
      return Left(failure);
    }
  }
}
