import 'package:fdni/core/dependency_injection/get_it.dart';
import 'package:fdni/feature/firm/presentation/blocs/document_firm_bloc/document_firm_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../firm/domain/entities/pie_data_entity.dart';

class PieYearDocumentSubType extends StatelessWidget {
  PieYearDocumentSubType({super.key});
  final f = NumberFormat.currency(
    decimalDigits: 0,
    locale: "bs-Latn-BA",
    symbol: "",
  );
  final s = NumberFormat('#0.0 %', "bs-Latn-BA");
  @override
  Widget build(BuildContext context) {
    final pieData = getIt.get<DocumentFirmBloc>().state.pieData;
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width * 2 / 3,
        height: MediaQuery.of(context).size.width * 2 / 3,
        color: Colors.amber,
        child: SfCircularChart(
          series: <CircularSeries>[
            PieSeries<PieDataEntitey, String>(
              dataSource: pieData, // widget.data,
              xValueMapper: (PieDataEntitey data, _) => data.firma,
              yValueMapper: (PieDataEntitey data, _) => data.total,
              dataLabelMapper: (PieDataEntitey data, _) {
                var x = 0.0;
                for (var value in pieData) {
                  x += value.total;
                }
                final y = data.total / x;
                return s.format(y);
              },
              radius: '75%',
              explode: true,
            )
          ],
        ),
      ),
    );
  }
}
