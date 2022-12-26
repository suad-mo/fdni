import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/dependency_injection/get_it.dart';
import '../../../../core/enums/firms.dart';
import '../../domain/entities/document_firm_entity.dart';
import '../blocs/all_data_bloc/all_data_bloc.dart';
import 'tabs/pie_chart_tabs_widget.dart';

class FirmDocumentDetailPage extends StatelessWidget {
  final int idFirm;
  final String idDocument;
  final DocumentFirmEntity? doc;

  final f = NumberFormat.currency(
    decimalDigits: 2,
    locale: "bs-Latn-BA",
    symbol: "KM",
  );
  final p = NumberFormat('#0.0 %', "bs-Latn-BA");
  final df = DateFormat.yMEd();

  FirmDocumentDetailPage({
    super.key,
    required this.idFirm,
    required this.idDocument,
  }) : doc = getIt
            .get<AllDataBloc>()
            .state
            .getDocumentFirmByIds(idFirm, idDocument);

  static Route<void> route({required int idFirm, required String idDocument}) =>
      MaterialPageRoute<void>(
        builder: (_) => FirmDocumentDetailPage(
          idDocument: idDocument,
          idFirm: idFirm,
        ),
      );

  @override
  Widget build(BuildContext context) {
    late DocumentFirmEntity d;
    if (doc == null) {
      return const Center(child: Text('Nema podataka'));
    } else {
      d = doc!;
    }
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(Firms.getWithId(d.idFirm).name),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.cloud_outlined),
              ),
              Tab(
                icon: Icon(Icons.beach_access_sharp),
              ),
              Tab(
                icon: Icon(Icons.brightness_5_sharp),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            DataTableTabWidget(d: d),
            PieChartTabWidget(doc: doc!),
            Center(
              child: Text("It's sunny here"),
            ),
          ],
        ),
        // Column(
        //   // mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     if (d.aktOznaka != null)
        //       Row(
        //         children: [
        //           const Text('Broj: '),
        //           Text(d.aktOznaka!),
        //         ],
        //       ),
        //     if (d.aktDatum != null)
        //       Row(
        //         children: [
        //           const Text('Datum: '),
        //           Text(df.format(d.aktDatum!)),
        //         ],
        //       ),
        //     Container(
        //       child: Text(d.napomena ?? 'napomena'),
        //     ),
        //     Container(
        //       child: Text(d.dopuna ?? 'dopuna'),
        //     ),
        //     Row(
        //       children: [
        //         Expanded(child: SizedBox()),
        //         Expanded(child: Text('NVO: ')),
        //         Expanded(child: Text(f.format(d.nvo))),
        //       ],
        //     ),
        //     DataTableTabWidget(d: d),
        //     PieChartTabWidget(doc: doc!)
        //   ],
        // ),
      ),
    );
  }
}

class DataTableTabWidget extends StatelessWidget {
  const DataTableTabWidget({
    Key? key,
    required this.d,
  }) : super(key: key);

  final DocumentFirmEntity d;

  @override
  Widget build(BuildContext context) {
    final f = NumberFormat.currency(
      decimalDigits: 2,
      locale: "bs-Latn-BA",
      symbol: "KM",
    );
    final p = NumberFormat('#0.0 %', "bs-Latn-BA");
    final da = DateFormat('dd.MM.yyyy');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                  width: 60,
                  // alignment: Alignment.centerRight,
                  child: Text('Broj:')),
              Text(d.aktOznaka!),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                  width: 60,
                  // alignment: Alignment.centerRight,
                  child: Text('Datum:')),
              Text(da.format(d.aktDatum!)),
            ],
          ),
          DataTable(
            // sortColumnIndex: 0,
            columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Vrsta',
                    style: TextStyle(fontStyle: FontStyle.italic),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              DataColumn(
                numeric: true,
                label: Expanded(
                  child: Text(
                    'Vrijednost',
                    style: TextStyle(fontStyle: FontStyle.italic),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    '%',
                    style: TextStyle(fontStyle: FontStyle.italic),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
            rows: <DataRow>[
              DataRow(
                cells: <DataCell>[
                  DataCell(
                    Container(
                        alignment: Alignment.centerRight,
                        child: const Text('NVO')),
                  ),
                  DataCell(
                    Container(
                        alignment: Alignment.centerRight,
                        child: Text(f.format(d.nvo))),
                  ),
                  DataCell(
                    Container(
                        alignment: Alignment.centerRight,
                        child: Text(p.format(d.nvo! / d.ukupno!))),
                  ),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(
                    Container(
                        alignment: Alignment.centerRight,
                        child: const Text(
                          'Tržišni \nartikli',
                          // softWrap: true,
                          textAlign: TextAlign.right,
                        )),
                  ),
                  DataCell(
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(f.format(d.ta)),
                    ),
                  ),
                  DataCell(
                    Container(
                        alignment: Alignment.centerRight,
                        child: Text(p.format(d.ta! / d.ukupno!))),
                  ),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(
                    Container(
                        alignment: Alignment.centerRight,
                        child: const Text(
                          'Usluge',
                          softWrap: true,
                        )),
                  ),
                  DataCell(
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(f.format(d.usluge)),
                    ),
                  ),
                  DataCell(
                    Container(
                        alignment: Alignment.centerRight,
                        child: Text(p.format(d.usluge! / d.ukupno!))),
                  ),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  DataCell(
                    Container(
                        alignment: Alignment.centerRight,
                        child: const Text(
                          'Ukupno',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  DataCell(
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        f.format(d.ukupno),
                        style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          p.format(d.ukupno! / d.ukupno!),
                          style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                  // width: 60,
                  // alignment: Alignment.centerRight,
                  child: Text('Napomena: ')),
              Text(d.napomena ?? '-'),
            ],
          ),
          // Row(
          //   children: [
          Container(
              // width: 80,
              alignment: Alignment.topLeft,
              margin: EdgeInsets.all(10),
              // height: 40,
              child: const Text('Dodatno: ')),
          Container(
            // height: 100,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              d.dopuna ?? '-',
              maxLines: 5,
              softWrap: true,
              // overflow: TextOverflow.clip,
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            //   ),
            // ],
          ),
        ],
      ),
    );
  }
}




// style: TextStyle(fontStyle: FontStyle.italic),
