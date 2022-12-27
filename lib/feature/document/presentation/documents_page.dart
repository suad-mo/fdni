import 'package:fdni/core/enums/document_type.dart';
import 'package:fdni/feature/document/presentation/widgets/expanded_reports_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/dependency_injection/get_it.dart';
import '../../../core/enums/document_sub_type.dart';
import '../../firm/presentation/blocs/all_data_bloc/all_data_bloc.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  final years = <int>[2022, 2021, 2020, 2016, 2015, 2014, 2013, 2012];
  late AllDataBloc bloc;
  int currentYear = 2022;
  DocumentType currentType = DocumentType.plan;
  DocumentSubType currentSubType = DocumentSubType.quarter3;
  Map<int, Map<DocumentType, List<DocumentSubType>>> list = {};

  // final ButtonStyle _offStyle = ElevatedButton.styleFrom(
  //   foregroundColor: Colors.black87,
  //   backgroundColor: Colors.grey[300],
  //   padding: const EdgeInsets.symmetric(horizontal: 16),
  //   shape: const RoundedRectangleBorder(
  //     borderRadius: BorderRadius.all(Radius.circular(2)),
  //   ),
  // );
  // final ButtonStyle _onStyle = ElevatedButton.styleFrom(
  //   foregroundColor: Colors.black87,
  //   backgroundColor: Colors.amber,
  //   padding: const EdgeInsets.symmetric(horizontal: 16),
  //   shape: const RoundedRectangleBorder(
  //     borderRadius: BorderRadius.all(Radius.circular(2)),
  //   ),
  // );
  @override
  void initState() {
    bloc = getIt.get<AllDataBloc>()..add(const GetAllDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllDataBloc, AllDataState>(
      bloc: bloc,
      builder: (context, state) {
        list = state.existingDocuments;
        if (state is AllDataLoadedState) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Direkcija za namjensku industriju'),
              // actions: [
              //   IconButton(
              //     onPressed: () {
              //       Navigator.push(context, HorizontalBarChartWidget.route());
              //     },
              //     icon: Transform(
              //       transform: Matrix4.rotationZ(1.57),
              //       alignment: Alignment.center,
              //       child: const Icon(Icons.bar_chart),
              //     ),
              //   ),
              //   IconButton(
              //     onPressed: () {
              //       Navigator.push(context, PieWidget.route());
              //     },
              //     icon: const Icon(Icons.pie_chart),
              //   ),
              //   IconButton(
              //     onPressed: () {
              //       Navigator.push(context, DataGridWidget.route());
              //     },
              //     icon: const Icon(Icons.table_chart),
              //   ),
              // ],
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Izvještajni period'),
                  ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   height: 40,
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: years.length,
                  //     itemBuilder: ((context, index) => Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: ElevatedButton(
                  //               style: currentYear == years[index]
                  //                   ? _onStyle
                  //                   : _offStyle,
                  //               onPressed: (() {
                  //                 setState(() {
                  //                   currentYear = years[index];
                  //                 });
                  //               }),
                  //               child: Text(years[index].toString())),
                  //         )),
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   height: 40,
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: DocumentType.values.length - 1,
                  //     itemBuilder: ((context, index) => Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: ElevatedButton(
                  //               style: currentType == DocumentType.values[index]
                  //                   ? _onStyle
                  //                   : _offStyle,
                  //               onPressed: (() {
                  //                 final x =
                  //                     currentType == DocumentType.values[index];
                  //                 if (!x) {
                  //                   setState(() {
                  //                     currentType = DocumentType.values[index];
                  //                   });
                  //                 }
                  //               }),
                  //               child: Text(DocumentType.values[index].name)),
                  //         )),
                  //   ),
                  // ),
                  // if (currentType == DocumentType.raport)
                  //   SizedBox(
                  //     width: double.infinity,
                  //     height: 40,
                  //     child: ListView.builder(
                  //       scrollDirection: Axis.horizontal,
                  //       itemCount: DocumentSubType.values.length - 1,
                  //       itemBuilder: ((context, index) => index == 0
                  //           ? Container()
                  //           : Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: ElevatedButton(
                  //                   style: currentSubType ==
                  //                           DocumentSubType.values[index]
                  //                       ? _onStyle
                  //                       : _offStyle,
                  //                   onPressed: (() {
                  //                     final x = currentSubType ==
                  //                         DocumentSubType.values[index];
                  //                     if (!x) {
                  //                       setState(() {
                  //                         currentSubType =
                  //                             DocumentSubType.values[index];
                  //                       });
                  //                     }
                  //                   }),
                  //                   child: Text(DocumentSubType
                  //                       .values[index].translationII)),
                  //             )),
                  //     ),
                  //   ),
                  // // ...listCartWidget,
                  ExpandedReportsWidget(),
                ],
              ),
            ),
          );
        }
        return const Center(
          child: SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  List<Widget> get listCartWidget => list.entries.map<Widget>(
        (e) {
          return Card(
            // shape: ShapeBorder(BoxShape.circle,
            color: Colors.blue,
            margin: const EdgeInsets.all(8),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        e.key.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                      const Expanded(child: SizedBox()),
                      IconButton(
                          iconSize: 16,
                          onPressed: (() {}),
                          icon: const Icon(
                            Icons.arrow_forward,
                            size: 16,
                          ))
                    ],
                  ),
                ),
                ...e.value.entries.map((x) {
                  return Column(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(x.key.translation)),
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                          ),
                          child: Column(
                            children: [
                              ...x.value.reversed.map(
                                (p) => InkWell(
                                    onTap: (() {
                                      // final str =
                                      //     '${e.key}-${x.key.id}${x.key.id == 0 ? "" : -p.id}';
                                      // print(str);
                                    }),
                                    child: Text(p.translation)),
                              ),
                            ],
                          )),
                    ],
                  );
                }).toList(),
              ],
            ),
          );
        },
      ).toList();

  List<Widget> get listExpandedPanelWidgets => list.entries.map<Widget>(
        (e) {
          return Card(
            // shape: ShapeBorder(BoxShape.circle,
            color: Colors.blue,
            margin: const EdgeInsets.all(8),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        e.key.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                      const Expanded(child: SizedBox()),
                      IconButton(
                          iconSize: 16,
                          onPressed: (() {}),
                          icon: const Icon(
                            Icons.arrow_forward,
                            size: 16,
                          ))
                    ],
                  ),
                ),
                ...e.value.entries.map((x) {
                  return Column(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(x.key.translation)),
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                          ),
                          child: Column(
                            children: [
                              ...x.value.reversed.map(
                                (p) => InkWell(
                                    onTap: (() {
                                      // final str =
                                      //     '${e.key}-${x.key.id}${x.key.id == 0 ? "" : -p.id}';
                                      // print(str);
                                    }),
                                    child: Text(p.translation)),
                              ),
                            ],
                          )),
                    ],
                  );
                }).toList(),
              ],
            ),
          );
        },
      ).toList();
}
