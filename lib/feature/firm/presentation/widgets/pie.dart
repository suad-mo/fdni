import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieWidgetA extends StatefulWidget {
  const PieWidgetA({super.key});

  static Route<void> route() => MaterialPageRoute<void>(
        builder: (_) => const PieWidgetA(),
      );

  @override
  State<PieWidgetA> createState() => _PieWidgetAState();
}

class _PieWidgetAState extends State<PieWidgetA> {
  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Graf')),
        body: SfCircularChart(
          title: ChartTitle(
              text: 'Continent wise GDP - 2021 \n (in billions of USD)'),
          legend: Legend(
              isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
          tooltipBehavior: _tooltipBehavior,
          series: <CircularSeries>[
            // PieSeries<GDPData, String>(
            RadialBarSeries<GDPData, String>(
              // DoughnutSeries<GDPData, String>(
              dataSource: _chartData,
              xValueMapper: (GDPData data, _) => data.continent,
              yValueMapper: (GDPData data, _) => data.gdb,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              enableTooltip: true,
              maximumValue: 40000, // Samo za RadialBarSeries
            )
          ],
        ),
      ),
    );
  }

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('Oceania', 16000.5),
      GDPData('Africa', 2490.6),
      GDPData('S America', 2900),
      GDPData('Europe', 23050),
      GDPData('N America', 24880),
      GDPData('Asia', 34390),
    ];
    return chartData;
  }
}

class GDPData {
  final String continent;
  final double gdb;

  GDPData(this.continent, this.gdb);
}
