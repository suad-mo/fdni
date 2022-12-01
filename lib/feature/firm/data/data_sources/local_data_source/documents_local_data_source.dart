import 'package:fdni/feature/firm/domain/entities/firm_entity.dart';

abstract class DocumentsLocalDataSource {
  Future<List<FirmEntity>> getAllFirms();
}
