// import 'dart:html';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_cases.dart';
import '../entities/document_firm_entity.dart';
import '../repositories/document_repository.dart';

class GetDocumentsFirmsByIdUseCase
    implements UseCase<List<DocumentFirmEntity>, String> {
  final DocumentRepository _repository;

  GetDocumentsFirmsByIdUseCase({
    required DocumentRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, List<DocumentFirmEntity>>> call(String id) async {
    final documentsFirms = await _repository.getDocumentsFirmsByIdDocument(id);
    return documentsFirms;
  }
}
