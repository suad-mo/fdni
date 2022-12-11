import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_cases.dart';
import '../entities/document_firm_entity.dart';
import '../repositories/document_repository.dart';

class GetAllDocumentsFirmsUseCase
    implements UseCase<List<DocumentFirmEntity>, NoParams> {
  final DocumentRepository _repository;

  GetAllDocumentsFirmsUseCase({
    required DocumentRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, List<DocumentFirmEntity>>> call(
      NoParams params) async {
    final documentsFirms = await _repository.getAllDocumentsFirms();
    return documentsFirms;
  }
}
