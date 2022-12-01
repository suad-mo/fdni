import 'dart:convert';

import '../../../../../core/input_data/fixture_reader.dart';
import '../../../domain/entities/firm_entity.dart';
import '../../models/firm_model.dart';
import 'documents_local_data_source.dart';

class DocumentsLocalDataSourceImpl implements DocumentsLocalDataSource {
  @override
  Future<List<FirmEntity>> getAllFirms() async {
    const String name = 'data_firms.json';
    final String strData = fixture(name);
    final data = json.decode(strData);
    final jsonData = data['dataroot']['tblFirms'];
    final List<FirmEntity> firms = jsonData == null
        ? []
        : List<FirmModel>.from(jsonData.map((x) => FirmModel.fromJson(x)));
    return firms;
  }
}
