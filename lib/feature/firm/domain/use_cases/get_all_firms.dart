import 'package:fdni/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:fdni/core/use_cases/use_cases.dart';
import 'package:fdni/feature/firm/domain/entities/firm_entity.dart';
import 'package:fdni/feature/firm/domain/repositories/document_repository.dart';

class GetAllFirmsUseCase implements UseCase<List<FirmEntity>, NoParams> {
  final DocumentRepository _repository;

  GetAllFirmsUseCase({
    required DocumentRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, List<FirmEntity>>> call(NoParams params) async {
    // print('aaaaa...');
    final firms = await _repository.getAllFirms();
    return firms;
  }
}
