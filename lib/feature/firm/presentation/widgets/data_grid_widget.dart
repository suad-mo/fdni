import 'package:fdni/core/enums/firm.dart';
import 'package:fdni/feature/firm/domain/entities/document_entity.dart';
import 'package:fdni/feature/firm/presentation/pages/firm_document_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../core/dependency_injection/get_it.dart';
import '../../domain/entities/bar_data_entity.dart';
import '../blocs/document_firm_bloc/document_firm_bloc.dart';

class DataGridWidget extends StatefulWidget {
  const DataGridWidget({super.key});

  static Route<void> route() => MaterialPageRoute<void>(
        builder: (_) => const DataGridWidget(),
      );

  @override
  State<DataGridWidget> createState() => _DataGridWidgetState();
}

class _DataGridWidgetState extends State<DataGridWidget> {
  late List<BarDataEntitey> _firms;
  late FirmsDataSource _firmsDataSource;
  late DataGridController _controller; // = DataGridController()
  late DocumentEntity _doc;

  Firm? currentFirm;

  @override
  void initState() {
    _firms = getIt.get<DocumentFirmBloc>().state.barData;
    _firmsDataSource = FirmsDataSource(_firms);
    _controller = DataGridController();
    _doc = getIt.get<DocumentFirmBloc>().state.doc;
    // _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  String _title() {
    int year = 2022;
    int period = 3;
    if (_doc.year != null) {
      year = _doc.year!;
    }
    if (_doc.type != null) {
      period = _doc.subType!;
    }
    return 'Proizvodnja $year - $period. kvartal';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(_title()),
            // actions: [
            //   IconButton(
            //     onPressed: () {
            //       Navigator.push(context, HorizontalBarChartWidget.route());
            //     },
            //     icon: const Icon(Icons.bar_chart),
            //   ),
            //   IconButton(
            //     onPressed: () {
            //       Navigator.push(context, PieWidget.route());
            //     },
            //     icon: const Icon(Icons.pie_chart),
            //   ),
            // ],
          ),
          body: Column(
            children: [
              TextButton(
                  child: Text(currentFirm != null
                      ? currentFirm!.name
                      : 'Get Selection Information'),
                  onPressed: () {
                    if (currentFirm != null) {
                      // Navigator.push(
                      //   context,
                      //   FirmDocPage.route(firm: currentFirm!),
                      // );
                      final idDocument = _doc.idDocument;
                      final idFirm = currentFirm?.id ?? 0;
                      Navigator.push(
                          context,
                          FirmDocumentDetailPage.route(
                            idDocument: idDocument,
                            idFirm: idFirm,
                          ));
                    }
                  }),
              Expanded(
                child: SfDataGrid(
                  source: _firmsDataSource,
                  selectionMode: SelectionMode.single,
                  controller: _controller,
                  allowSorting: true,
                  columnWidthMode: ColumnWidthMode.fitByCellValue,
                  tableSummaryRows: _getTableSummaryRows(),
                  onCellTap: (details) {
                    //print(details.rowColumnIndex.rowIndex);
                  },
                  onSelectionChanged: (addedRows, removedRows) {
                    final x = addedRows[0].getCells().first.value;
                    setState(() {
                      currentFirm = Firm.getWithId(x);
                    });
                  },
                  columnWidthCalculationRange:
                      ColumnWidthCalculationRange.allRows,
                  columns: [
                    GridColumn(
                      columnName: 'id',
                      visible: true,
                      label: Container(
                        // padding: const EdgeInsets.symmetric(horizontal: 1),

                        alignment: Alignment.centerRight,
                        child: const Text(
                          'Id',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'name',
                      label: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Name',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'total',
                      label: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.centerRight,
                        child: const Text(
                          'Total',
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'p',
                      width: 80,
                      label: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.centerRight,
                        child: const Text(
                          '%',
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'nvo',
                      label: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.centerRight,
                        child: const Text(
                          'NVO',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'ta',
                      label: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.centerRight,
                        child: const Text(
                          'TA',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'usluge',
                      label: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.centerRight,
                        child: const Text(
                          'Usluge',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  List<GridTableSummaryRow> _getTableSummaryRows() {
    const Color color = Color(0xFFEBEBEB);
    // model.themeData.colorScheme.brightness == Brightness.light
    //     ? const Color(0xFFEBEBEB)
    //     : const Color(0xFF3B3B3B);
    return <GridTableSummaryRow>[
      // GridTableSummaryRow(
      //     showSummaryInRow: true,
      //     // color: color,
      //     title: 'Total Order Count: {Count}',
      //     columns: <GridSummaryColumn>[
      //       const GridSummaryColumn(
      //           name: 'Count',
      //           columnName: 'id',
      //           summaryType: GridSummaryType.count),
      //     ],
      //     position: GridTableSummaryRowPosition.top),
      GridTableSummaryRow(
          color: color,
          showSummaryInRow: false,
          columns: <GridSummaryColumn>[
            const GridSummaryColumn(
                name: 'total',
                columnName: 'total',
                summaryType: GridSummaryType.sum),
            const GridSummaryColumn(
              name: 'nvo',
              columnName: 'nvo',
              summaryType: GridSummaryType.sum,
            ),
            const GridSummaryColumn(
              name: 'ta',
              columnName: 'ta',
              summaryType: GridSummaryType.sum,
            ),
            const GridSummaryColumn(
              name: 'usluge',
              columnName: 'usluge',
              summaryType: GridSummaryType.sum,
            ),
          ],
          position: GridTableSummaryRowPosition.bottom),
    ];
  }
}

class FirmsDataSource extends DataGridSource {
  FirmsDataSource(List<BarDataEntitey> firms) {
    final uk = firms.fold<double>(
        0.0, (previousValue, element) => previousValue + element.total);
    dataGridRows = firms
        .map<DataGridRow>((data) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: data.firma.id),
              DataGridCell<String>(
                  columnName: 'name', value: data.firma.shortName),
              DataGridCell<double>(columnName: 'total', value: data.total),
              DataGridCell<double>(columnName: 'p', value: data.total / uk),
              DataGridCell<double>(columnName: 'nvo', value: data.nvo),
              DataGridCell<double>(columnName: 'ta', value: data.ta),
              DataGridCell<double>(columnName: 'usluge', value: data.usluge),
            ]))
        .toList();
  }
  late List<DataGridRow> dataGridRows;

  final f = NumberFormat.currency(
    decimalDigits: 0,
    locale: "bs-Latn-BA",
    symbol: "",
  );
  final p = NumberFormat('#0.0 %', "bs-Latn-BA");
  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: dataGridCell.columnName == 'name'
            ? Alignment.centerLeft
            : Alignment.centerRight,
        // width: 150,
        child: Text(
          dataGridCell.columnName == 'name'
              ? dataGridCell.value
              : dataGridCell.columnName == 'p'
                  ? p.format(dataGridCell.value)
                  : f.format(dataGridCell.value),
          // : dataGridCell.value.toString(),
          overflow: TextOverflow.ellipsis,
          textWidthBasis: TextWidthBasis.parent,
        ),
      );
    }).toList());
  }

  @override
  Widget? buildTableSummaryCellWidget(
    GridTableSummaryRow summaryRow,
    GridSummaryColumn? summaryColumn,
    RowColumnIndex rowColumnIndex,
    String summaryValue,
  ) {
    final x = num.tryParse(summaryValue);
    return Container(
      padding: const EdgeInsets.all(10.0),
      alignment: x != null ? Alignment.centerRight : Alignment.centerLeft,
      child: Text(x != null ? f.format(x) : summaryValue),
    );
  }
}
