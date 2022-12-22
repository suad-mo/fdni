import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../domain/entities/document_firm_entity.dart';

class PieChartTabWidget extends StatelessWidget {
  const PieChartTabWidget({
    Key? key,
    required this.doc,
  }) : super(key: key);

  final DocumentFirmEntity? doc;

  @override
  Widget build(BuildContext context) {
    final s = NumberFormat('#0.0 %', "bs-Latn-BA");
    late DocumentFirmEntity d;
    if (doc == null) {
      return const Center(child: Text('Nema podataka'));
    } else {
      d = doc!;
    }
    final List<ChartData> chartData = [
      ChartData('NVO', d.nvo ?? 0),
      ChartData('Tržišni artikli', d.ta ?? 0),
      ChartData('Usluge', d.usluge ?? 0),
    ];
    return SfCircularChart(
      series: <CircularSeries>[
        // Render pie chart
        PieSeries<ChartData, String>(
          enableTooltip: true,
          dataSource: chartData,
          // pointColorMapper:(ChartData data,  _) => data.color,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          dataLabelMapper: (ChartData data, _) {
            final y = data.y / d.ukupno!;
            return s.format(y);
          },
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            // Avoid labels intersection
            labelIntersectAction: LabelIntersectAction.shift,
            // labelPosition: ChartDataLabelPosition.outside,
            connectorLineSettings:
                ConnectorLineSettings(type: ConnectorType.curve, length: '25%'),
            useSeriesColor: true,
          ),
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(
    this.x,
    this.y,
  ); // [this.color]);
  final String x;
  final double y;
  // final Color color;
}
