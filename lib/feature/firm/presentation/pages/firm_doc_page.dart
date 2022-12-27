import 'package:fdni/feature/firm/domain/entities/firm_data_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/dependency_injection/get_it.dart';
import '../../../../core/enums/firm.dart';
import '../blocs/firm_all_documents_bloc/firm_all_documents_bloc.dart';

class FirmDocPage extends StatefulWidget {
  final Firm firm;
  // final String? idDocument;
  // late FirmAllDocumentsBloc bloc;
  const FirmDocPage({
    super.key,
    required this.firm,
    // this.idDocument,
  });

  static Route<void> route({required Firm firm}) => MaterialPageRoute<void>(
        builder: (_) => FirmDocPage(firm: firm),
      );

  @override
  State<FirmDocPage> createState() => _FirmDocPageState();
}

class _FirmDocPageState extends State<FirmDocPage> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FirmAllDocumentsBloc bloc = getIt.get<FirmAllDocumentsBloc>()
      ..add(GetFirmAllDocumentsByIdEvent(firm: widget.firm));
    return BlocBuilder<FirmAllDocumentsBloc, FirmAllDocumentsState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is FirmAllDocumentsLoadedState) {
          // final docs = state.documents;
          // final docs = state.extendDocuments;
          // final docs = state.getDocsBySubType(3);
          // final docs1 = state.docsType1;
          final data4 = state.getDocsBySubType(4);
          // final data3 = state.getDocsBySubType(3);
          // final data = state.extendDocuments;
          // print(data3);
          //print('aaaa....docs: ${docs.length}');
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(title: Text(widget.firm.name)),
              body: SfCartesianChart(
                tooltipBehavior: _tooltipBehavior,
                legend: Legend(isVisible: true),
                series: <ChartSeries>[
                  // StackedLineSeries<FirmDataExtendEntity, int>(
                  //   dataSource: data4,
                  //   xValueMapper: ((FirmDataExtendEntity data, _) => data.year),
                  //   yValueMapper: ((FirmDataExtendEntity data, _) =>
                  //       data.total),
                  // ),
                  // StackedLineSeries<FirmDataExtendEntity, String>(
                  //   dataSource: data4,
                  //   xValueMapper: ((FirmDataExtendEntity d, _) => '${d.year}'),
                  //   yValueMapper: ((FirmDataExtendEntity d, _) => d.total),
                  //   name: 'total',
                  //   markerSettings: const MarkerSettings(isVisible: true),
                  // ),
                  StackedAreaSeries<FirmDataExtendEntity, String>(
                    dataSource: data4,
                    xValueMapper: ((FirmDataExtendEntity d, _) => '${d.year}'),
                    yValueMapper: ((FirmDataExtendEntity d, _) => d.nvo),
                    name: 'nvo',
                    markerSettings: const MarkerSettings(isVisible: true),
                  ),
                  StackedAreaSeries<FirmDataExtendEntity, String>(
                    dataSource: data4,
                    xValueMapper: ((FirmDataExtendEntity d, _) => '${d.year}'),
                    yValueMapper: ((FirmDataExtendEntity d, _) => d.ta),
                    name: 'ta',
                    color: Colors.amber,
                    markerSettings: const MarkerSettings(isVisible: true),
                  ),
                  StackedAreaSeries<FirmDataExtendEntity, String>(
                    dataSource: data4,
                    xValueMapper: ((FirmDataExtendEntity d, _) => '${d.year}'),
                    yValueMapper: ((FirmDataExtendEntity d, _) => d.usluge),
                    name: 'usluge',
                    markerSettings: const MarkerSettings(isVisible: true),
                  ),
                  // StackedLineSeries<FirmDataExtendEntity, String>(
                  //   dataSource: data4,
                  //   xValueMapper: ((FirmDataExtendEntity d, _) => '${d.year}'),
                  //   yValueMapper: ((FirmDataExtendEntity d, _) => d.nvo),
                  // ),
                  // StackedLineSeries<FirmDataExtendEntity, String>(
                  //     dataSource: data4,
                  //     xValueMapper: ((FirmDataExtendEntity d, _) =>
                  //         '${d.year}'),
                  //     yValueMapper: ((FirmDataExtendEntity d, _) => d.ta),
                  //     color: Colors.amber),
                ],
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    numberFormat: NumberFormat.compactCurrency(symbol: ''),
                    title: AxisTitle(text: 'Proizvodnja NVO')),
              ),
            ),
          );
        } else if (state is FirmAllDocumentsLoadingState) {
          return const Scaffold(
            body: Center(
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Container(color: Colors.blue),
          );
        }
      },
    );
  }
}


// ListView.builder(
//                   itemCount: docs.length,
//                   itemBuilder: ((context, index) {
//                     final period =
//                         '${docs[index].year} - ${docs[index].type} - ${docs[index].subType}';
//                     return Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: Row(
//                         children: [
//                           Text(period),
//                           SizedBox(width: 10),
//                           Expanded(child: Text(docs[index].total.toString())),
//                           SizedBox(width: 10),
//                           // Expanded(child: Text(docs1[index].total.toString())),
//                         ],
//                       ),
//                     );
//                     // ListTile(title: Text(period ?? 'period'));
//                   }))