import 'package:dartz/dartz.dart';
import 'package:fdni/feature/firm/domain/entities/firm_entity.dart';

import '../../../../core/error/failures.dart';

abstract class DocumentRepository {
  Future<Either<Failure, List<FirmEntity>>> getAllFirms();
}
