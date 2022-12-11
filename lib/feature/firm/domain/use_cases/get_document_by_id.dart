import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_cases.dart';
import '../entities/document_entity.dart';
import '../repositories/document_repository.dart';

class GetDocumentByIdUseCase implements UseCase<DocumentEntity, String> {
  final DocumentRepository _repository;

  GetDocumentByIdUseCase({
    required DocumentRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, DocumentEntity>> call(String idDocument) async {
    final document = await _repository.getDocumentById(idDocument);
    return document;
  }
}
