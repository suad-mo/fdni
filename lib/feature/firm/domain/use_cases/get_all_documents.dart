import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_cases.dart';
import '../entities/document_entity.dart';
import '../repositories/document_repository.dart';

class GetAllDocumentsUseCase
    implements UseCase<List<DocumentEntity>, NoParams> {
  final DocumentRepository _repository;

  GetAllDocumentsUseCase({
    required DocumentRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, List<DocumentEntity>>> call(NoParams params) async {
    final documents = await _repository.getAllDocuments();
    return documents;
  }
}
