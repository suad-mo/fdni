import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/dependency_injection/get_it.dart';
import '../../domain/entities/pie_data_entity.dart';
import '../blocs/document_firm_bloc/document_firm_bloc.dart';

class PieWidget extends StatefulWidget {
  // final List<PieDataEntitey> data;
  // final String title;
  const PieWidget({
    super.key,
    // required this.data,
    // required this.title,
  });

  static Route<void> route() => MaterialPageRoute<void>(
        builder: (_) => const PieWidget(
            // data: data,
            // title: title,
            ),
      );

  @override
  State<PieWidget> createState() => _PieWidgetState();
}

class _PieWidgetState extends State<PieWidget> {
  final pieData = getIt.get<DocumentFirmBloc>().state.pieData;
  final doc = getIt.get<DocumentFirmBloc>().state.doc;
  late TooltipBehavior _tooltipBehavior;
  final f = NumberFormat.currency(
    decimalDigits: 0,
    locale: "bs-Latn-BA",
    symbol: "",
  );
  final s = NumberFormat('#0.0 %', "bs-Latn-BA");
  String _title() {
    String title = 'Title';
    if (doc.docLabel != null) {
      title = doc.docLabel!;
    }
    return title;
  }

  String _titleChart() {
    int year = 2022;
    int period = 3;

    if (doc.year != null) {
      year = doc.year!;
    }
    if (doc.type != null) {
      period = doc.subType!;
    }

    return 'Izvještaj za $year \n$period. kvartal';
  }

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
        enable: true,
        // textAlignment: ChartAlignment.center,
        // format: 'point.x\n\npoint.y',
        builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
            int seriesIndex) {
          // print(
          //     'data:$data, point: $point, series: $series, pointIndex: $pointIndex, seriesIndex: $seriesIndex');
          return Container(
              height: 80,
              width: 150,
              color: Colors.greenAccent,
              alignment: Alignment.center,
              // decoration: BoxDecoration(
              //     color: Colors.grey,
              //     // shape: BoxShape.rectangle,
              //     // border: Border.all(),
              //     borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    data is PieDataEntitey ? data.firma : "",
                    maxLines: 3,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.fade,
                  ),
                  Text(data is PieDataEntitey ? f.format(data.total) : ""),
                ],
              ));
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // data.sort(((a, b) => a.total.compareTo(b.total)));
    // final pieData = data;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(_title())),
        body: Center(
          child: SfCircularChart(
            title: ChartTitle(text: _titleChart()),
            legend: Legend(
              isVisible: true,
              overflowMode: LegendItemOverflowMode.wrap,
              position: LegendPosition.bottom,
              // Templating the legend item
              // legendItemBuilder:
              //     (String name, dynamic series, dynamic point, int index) {
              //   print(name);
              //   print(point.label);
              //   return Container(
              //       height: 20,
              //       width: 60,
              //       child: Container(child: Text(point.x.toString())));
              // }
              // toggleSeriesVisibility: true,
              // title: LegendTitle(
              //   text: 'Firme namjenske industrije',
              //   textStyle: TextStyle(
              //       color: Colors.blueAccent,
              //       fontSize: 12,
              //       fontStyle: FontStyle.italic,
              //       fontWeight: FontWeight.w900),
              // ),
            ),
            tooltipBehavior: _tooltipBehavior,
            series: <CircularSeries>[
              PieSeries<PieDataEntitey, String>(
                // onPointTap: (ChartPointDetails details) {
                //   print(widget.data[details.pointIndex!].firma);
                //   print(details.seriesIndex);
                //   print(details.dataPoints![0].toString());
                // },
                // RadialBarSeries<PieDataEntitey, String>(
                // DoughnutSeries<PieDataEntitey, String>(
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
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  // Avoid labels intersection
                  labelIntersectAction: LabelIntersectAction.shift,
                  // labelPosition: ChartDataLabelPosition.outside,
                  connectorLineSettings: ConnectorLineSettings(
                      type: ConnectorType.curve, length: '25%'),
                  useSeriesColor: true,
                ),
                enableTooltip: true,
                explodeAll: true,

                // maximumValue: 40000, // Samo za RadialBarSeries
              )
            ],
          ),
        ),
      ),
    );
  }
}
