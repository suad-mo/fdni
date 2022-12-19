import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/dependency_injection/get_it.dart';
import '../../../firm/domain/entities/bar_data_entity.dart';
import '../../../firm/domain/entities/document_entity.dart';
import '../../../firm/presentation/blocs/all_data_bloc/all_data_bloc.dart';

class BarChartWidget extends StatefulWidget {
  final String idDocument;
  const BarChartWidget({super.key, required this.idDocument});

  static Route<void> route(String idDocument) => MaterialPageRoute<void>(
        builder: (_) => BarChartWidget(idDocument: idDocument),
      );

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  late List<BarDataEntitey> _barData;
  late DocumentEntity? _doc;
  late TooltipBehavior _tooltipBehavior;

  String _titleChart() {
    int year = 2022;
    int period = 3;

    if (_doc != null && _doc!.year != null) {
      year = _doc!.year!;
    }

    if (_doc != null && _doc!.type != null) {
      period = _doc!.subType!;
    }

    return 'Izvještaj za $year .godinu \n$period. kvartal';
  }

  @override
  void initState() {
    _barData = getIt.get<AllDataBloc>().state.getBarData(widget.idDocument);
    _doc = getIt.get<AllDataBloc>().state.getDocumentById(widget.idDocument);
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // appBar: AppBar(title: const Text('Chart')),
      child: SfCartesianChart(
        title: ChartTitle(text: _titleChart()),
        legend: Legend(isVisible: true),
        tooltipBehavior: _tooltipBehavior,
        series: <ChartSeries>[
          // StackedBarSeries<BarDataEntitey, String>(
          //   name: 'Total',
          //   dataSource: _barData,
          //   xValueMapper: (BarDataEntitey data, _) => data.firma.shortName,
          //   yValueMapper: (BarDataEntitey data, _) => data.total, // 1000000,
          //   dataLabelSettings: const DataLabelSettings(isVisible: true),
          //   enableTooltip: true,
          //   // width: 0.3,
          //   // spacing: 0.1,
          // ),
          StackedBarSeries<BarDataEntitey, String>(
            groupName: 'Total',
            name: 'NVO',
            dataSource: _barData,
            xValueMapper: (BarDataEntitey data, _) => data.firma.shortName,
            yValueMapper: (BarDataEntitey data, _) => data.nvo, // 1000000,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              showCumulativeValues: true,
            ),
            // width: 0.3,
            // spacing: 0.1,
          ),
          StackedBarSeries<BarDataEntitey, String>(
            groupName: 'Total',
            name: 'TA',
            dataSource: _barData,
            xValueMapper: (BarDataEntitey data, _) => data.firma.shortName,
            yValueMapper: (BarDataEntitey data, _) => data.ta, // 1000000,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              showCumulativeValues: true,
            ),
            // width: 0.3,
            // spacing: 0.1,
          ),
          StackedBarSeries<BarDataEntitey, String>(
            groupName: 'Total',
            name: 'US',
            color: Colors.amber,
            dataSource: _barData,
            xValueMapper: (BarDataEntitey data, _) => data.firma.shortName,
            yValueMapper: (BarDataEntitey data, _) => data.usluge, // 1000000,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
            ),
            // width: 0.3,
            // spacing: 0.1,
          )
        ],
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            numberFormat: NumberFormat.compactCurrency(symbol: ''),
            title: AxisTitle(text: 'Proizvodnja NVO')),
      ),
    );
  }
}
