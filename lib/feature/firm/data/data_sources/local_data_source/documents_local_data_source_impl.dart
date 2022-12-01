import 'dart:convert';

import '../../../../../core/input_data/fixture_reader.dart';
import '../../../domain/entities/firm_entity.dart';
import '../../models/firm_model.dart';
import 'documents_local_data_source.dart';

import '../../../../../core/input_data/data_firms.json' as x;

// const  x = json.decoder(jsonFirms);

class DocumentsLocalDataSourceImpl implements DocumentsLocalDataSource {
  @override
  Future<List<FirmEntity>> getAllFirms() async {
    const String name = 'data_firms.json';
    print(name);
    final String strData = fixture(name);
    print('aaaa...$strData');
    final data = json.decode(strData);
    print('bbbbb....');
    print(data.toString());
    // final x = jsonFirms;

    final jsonData = data['dataroot']['tblFirms'];
    final List<FirmEntity> firms = jsonData == null
        ? []
        : List<FirmModel>.from(jsonData.map((x) => FirmModel.fromJson(x)));
    return firms;
  }
}
