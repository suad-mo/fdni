import 'package:fdni/feature/firm/domain/entities/firm_entity.dart';
import 'package:fdni/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/document_repository.dart';
import '../data_sources/local_data_source/documents_local_data_source.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  final DocumentsLocalDataSource _localDataSource;

  DocumentRepositoryImpl({required DocumentsLocalDataSource localDataSource})
      : _localDataSource = localDataSource;
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
}
