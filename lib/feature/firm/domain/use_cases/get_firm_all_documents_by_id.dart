import 'package:dartz/dartz.dart';

import '../../../../core/enums/firm.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_cases.dart';
import '../entities/firm_data_entity.dart';
import '../repositories/document_repository.dart';

class GetFirmAllDocumentsByIdUseCase
    implements UseCase<List<FirmDataEntity>, Firm> {
  final DocumentRepository _repository;

  GetFirmAllDocumentsByIdUseCase({
    required DocumentRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, List<FirmDataEntity>>> call(Firm firm) async {
    final documents = await _repository.getFirmDocumentsByFirm(firm);
    //print(documents);
    return documents;
  }
}
