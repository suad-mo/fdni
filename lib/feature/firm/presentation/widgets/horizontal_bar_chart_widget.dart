import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/dependency_injection/get_it.dart';
import '../../domain/entities/bar_data_entity.dart';
import '../../domain/entities/document_entity.dart';
import '../blocs/document_firm_bloc/document_firm_bloc.dart';

class HorizontalBarChartWidget extends StatefulWidget {
  const HorizontalBarChartWidget({super.key});

  static Route<void> route() => MaterialPageRoute<void>(
        builder: (_) => const HorizontalBarChartWidget(),
      );

  @override
  State<HorizontalBarChartWidget> createState() =>
      _HorizontalBarChartWidgetState();
}

class _HorizontalBarChartWidgetState extends State<HorizontalBarChartWidget> {
  late List<BarDataEntitey> _barData;
  late DocumentEntity _doc;
  late TooltipBehavior _tooltipBehavior;

  String _titleChart() {
    int year = 2022;
    int period = 3;

    if (_doc.year != null) {
      year = _doc.year!;
    }

    if (_doc.type != null) {
      period = _doc.subType!;
    }

    return 'Izvještaj za $year .godinu \n$period. kvartal';
  }

  @override
  void initState() {
    var x = getIt.get<DocumentFirmBloc>().state.barData;
    x.sort(((a, b) => a.total.compareTo(b.total)));
    _barData = x;
    // getIt.get<DocumentFirmBloc>().state.barData;
    _doc = getIt.get<DocumentFirmBloc>().state.doc;
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Chart')),
        body: SfCartesianChart(
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
      ),
    );
  }
}
