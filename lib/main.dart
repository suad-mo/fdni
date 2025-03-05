import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feature/firm/presentation/widgets/data_grid_widget.dart';
import 'feature/firm/presentation/widgets/horizontal_bar_chart_widget.dart';
import 'feature/firm/presentation/widgets/pie_widget.dart';

import 'feature/firm/presentation/blocs/document_firm_bloc/document_firm_bloc.dart';
import 'feature/firm/presentation/blocs/firm_bloc/firm_bloc.dart';

import 'feature/home/presentation/home_page.dart';
import 'core/dependency_injection/get_it.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AppGetIt.init().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter FDNI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _year = '2022';
  int _period = 3;

  String get idPeriod => '$_year-1-$_period';

  @override
  Widget build(BuildContext context) {
    final f = NumberFormat.currency(
      locale: "bs-Latn-BA",
      symbol: "",
    );
    // final p = NumberFormat.percentPattern("bs-Latn-BA");
    final s = NumberFormat('#0.0 %', "bs-Latn-BA");

    final bloc = getIt.get<DocumentFirmBloc>()
      ..add(GetDocumentFirmByIdEvent(id: idPeriod));
    return BlocBuilder<DocumentFirmBloc, DocumentFirmState>(
      bloc: bloc,
      builder: (context, state) {
        final firms = getIt.get<FirmBloc>().state.firms;
        if (state is DocumentFirmByIdLoadedState) {
          // return const DataGridWidget();
          final data = state.listDocFirm;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Proizvodnja NVO-a'),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context, HorizontalBarChartWidget.route());
                  },
                  icon: Transform(
                    transform: Matrix4.rotationZ(1.57),
                    alignment: Alignment.center,
                    child: const Icon(Icons.bar_chart),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context, PieWidget.route());
                  },
                  icon: const Icon(Icons.pie_chart),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context, DataGridWidget.route());
                  },
                  icon: const Icon(Icons.table_chart),
                ),
              ],
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        const Text(
                          'Period',
                          style: TextStyle(
                              fontSize: 20, fontStyle: FontStyle.italic),
                        ),
                        const Expanded(child: SizedBox()),
                        DropdownButton<String>(
                          value: _year,
                          items: <String>[
                            '2024',
                            '2023',
                            '2022',
                            '2021',
                            '2020',
                            '2016',
                            '2015',
                            '2014',
                            '2013',
                            '2012'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(fontSize: 20),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != _year) {
                              setState(() {
                                _year = newValue!;
                                _period = 1;
                              });
                            }
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        DropdownButton<int>(
                          // Step 3.
                          value: _period,
                          // Step 4.
                          items: <int>[1, 2, 3, 4]
                              .map<DropdownMenuItem<int>>((int value) {
                            String str = '';
                            switch (value) {
                              case 1:
                                str = 'I kvartal';
                                break;
                              case 2:
                                str = 'II kvartal';
                                break;
                              case 3:
                                str = 'III kvartal';
                                break;
                              case 4:
                                str = 'IV kvartal';
                                break;
                              default:
                            }
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(
                                str,
                                style: const TextStyle(fontSize: 20),
                              ),
                            );
                          }).toList(),
                          // Step 5.
                          onChanged: (int? newValue) {
                            if (newValue != _period) {
                              setState(() {
                                _period = newValue!;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  DataTable(
                      dividerThickness: 2,
                      columnSpacing: 4,
                      // Datatable widget that have the property columns and rows.
                      columns: const [
                        // Set the name of the column
                        DataColumn(
                          label: Text('Firma'),
                        ),
                        DataColumn(
                          label: Text('Pecent'),
                        ),
                        DataColumn(
                          label: Text('Ukupno'),
                        ),
                      ],
                      rows: [
                        // Set the values to the columns

                        ...data.map(
                          (e) {
                            // MaterialStatePropertyColor color = Colors.white;
                            var name = e.idFirm.toString();
                            if (firms.isNotEmpty) {
                              name = firms
                                  .firstWhere((firm) => e.idFirm == firm.idFirm)
                                  .name;
                            }

                            return DataRow(cells: [
                              DataCell(SizedBox(
                                // width: MediaQuery.of(context).size.width / 3 - 20,

                                child: Text(
                                  name,
                                  maxLines: 2,
                                  // softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                // ),
                              )),
                              DataCell(
                                Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                        s.format(e.ukupno! / state.totalA))),
                              ),
                              DataCell(Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  f.format(e.ukupno),
                                  textAlign: TextAlign.right,
                                ),
                              )),
                            ]);
                          },
                        ).toList(),
                        DataRow(cells: [
                          DataCell(
                            Container(),
                          ),
                          DataCell(Container(
                            alignment: Alignment.centerRight,
                            child: const Text(
                              'Total: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )),
                          DataCell(Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                f.format(state.totalA),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ))),
                        ]),
                      ]),
                ],
              ),
            ),
          );
        } else if (state is DocumentFirmLoadingState) {
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
            appBar: AppBar(title: const Text('Back')),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  const Text(
                    'Period',
                    style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                  ),
                  const Expanded(child: SizedBox()),
                  DropdownButton<String>(
                    value: _year,
                    items: <String>[
                      '2022',
                      '2021',
                      '2020',
                      '2016',
                      '2015',
                      '2014',
                      '2013',
                      '2012'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 20),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != _year) {
                        setState(() {
                          _year = newValue!;
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  DropdownButton<int>(
                    // Step 3.
                    value: _period,
                    // Step 4.
                    items: <int>[1, 2, 3, 4]
                        .map<DropdownMenuItem<int>>((int value) {
                      String str = '';
                      switch (value) {
                        case 1:
                          str = 'I kvartal';
                          break;
                        case 2:
                          str = 'II kvartal';
                          break;
                        case 3:
                          str = 'III kvartal';
                          break;
                        case 4:
                          str = 'IV kvartal';
                          break;
                        default:
                      }
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(
                          str,
                          style: const TextStyle(fontSize: 20),
                        ),
                      );
                    }).toList(),
                    // Step 5.
                    onChanged: (int? newValue) {
                      if (newValue != _period) {
                        setState(() {
                          _period = newValue!;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

// body: ListView.builder(
            //   itemCount: state.documents.length,
            //   itemBuilder: ((context, index) {
            //     final x = state.documents[index].idFirm;
            // var name = x.toString();
            // if (firms.isNotEmpty) {
            //   name = firms.firstWhere((e) => e.idFirm == x).name;
            // }
            //     return ListTile(
            //       subtitle: Text(
            //           s.format(state.documents[index].ukupno! / state.totalA)),
            //       title: Row(
            //         children: [
            //           Text(
            //             name,
            //             maxLines: 3,
            //             overflow: TextOverflow.ellipsis,
            //             softWrap: true,
            //           ),
            //           const Expanded(child: SizedBox()),
            //           Text(f.format(state.documents[index].ukupno)),

            //           // Column(
            //           //   mainAxisAlignment: MainAxisAlignment.end,
            //           //   crossAxisAlignment: CrossAxisAlignment.end,
            //           //   children: [
            //           //     Text(f.format(state.documents[index].nvo)),
            //           //     Text(f.format(state.documents[index].ta)),
            //           //     Text(f.format(state.documents[index].usluge)),
            //           //     const Divider(
            //           //       thickness: 1,
            //           //       // indent: 2,
            //           //       // endIndent: 5,
            //           //       color: Color.fromARGB(255, 30, 8, 6),
            //           //     ),
            //           //     Text(f.format(state.documents[index].ukupno)),
            //           //     const Divider(
            //           //       thickness: 1,
            //           //       // indent: 2,
            //           //       // endIndent: 5,
            //           //       color: Color.fromARGB(255, 30, 8, 6),
            //           //     ),
            //           //   ],
            //           // ),
            //           // const SizedBox(width: 10),
            //           // const SizedBox(width: 10),
            //         ],
            //       ),
            //       // trailing: IconButton(
            //       //     onPressed: (() {
            //       //       // bloc.add(ChangeSelectFirmByIdEvent(
            //       //       //     id: state.selectFirms[index].idFirm,
            //       //       //     selectedFirms: state.selectFirms));
            //       //       // setState(() {});
            //       //     }),
            //       //     icon: state.documents[index].finished == null
            //       //         ? const Icon(Icons.add)
            //       //         : const Icon(Icons.done)),
            //     );
            //   }),
            // ),
            
// final bloc = getIt.get<FirmBloc>()..add(GetAllFirmsEvent());
//     return BlocBuilder<FirmBloc, FirmState>(
//       bloc: bloc,
//       builder: (context, state) {
//         if (state is FirmLoadedState) {
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text('All firms'),
//             ),
//             body: ListView.builder(
//                 itemCount: state.selectFirms.length,
//                 itemBuilder: ((context, index) {
//                   return ListTile(
//                     title: Text(state.selectFirms[index].name),
//                     trailing: IconButton(
//                         onPressed: (() {
//                           bloc.add(ChangeSelectFirmByIdEvent(
//                               id: state.selectFirms[index].idFirm,
//                               selectedFirms: state.selectFirms));
//                           // setState(() {});
//                         }),
//                         icon: !state.selectFirms[index].selected
//                             ? const Icon(Icons.add)
//                             : const Icon(Icons.done)),
//                   );
//                 })),
//           );
//         } else if (state is FirmLoadingState) {
//           return Scaffold(
//             appBar: AppBar(
//               // Here we take the value from the MyHomePage object that was created by
//               // the App.build method, and use it to set our appbar title.
//               title: Text(widget.title),
//             ),
//             body: Center(
//               // Center is a layout widget. It takes a single child and positions it
//               // in the middle of the parent.
//               child: Column(
//                 // Column is also a layout widget. It takes a list of children and
//                 // arranges them vertically. By default, it sizes itself to fit its
//                 // children horizontally, and tries to be as tall as its parent.
//                 //
//                 // Invoke "debug painting" (press "p" in the console, choose the
//                 // "Toggle Debug Paint" action from the Flutter Inspector in Android
//                 // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//                 // to see the wireframe for each widget.
//                 //
//                 // Column has various properties to control how it sizes itself and
//                 // how it positions its children. Here we use mainAxisAlignment to
//                 // center the children vertically; the main axis here is the vertical
//                 // axis because Columns are vertical (the cross axis would be
//                 // horizontal).
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   const Text(
//                     'You have pushed the button this many times:',
//                   ),
//                   Text(
//                     '$_counter',
//                     style: Theme.of(context).textTheme.headline4,
//                   ),
//                   // Text(state.firms.length.toString()),
//                 ],
//               ),
//             ),
//             floatingActionButton: FloatingActionButton(
//               onPressed: _incrementCounter,
//               tooltip: 'Increment',
//               child: const Icon(Icons.add),
//             ), // This trailing comma makes auto-formatting nicer for build methods.
//           );
//         } else {
//           return Scaffold(
//             body: Container(color: Colors.blue),
//           );
//         }
//       },
//     );

// final bloc = getIt.get<DocumentBloc>()..add(GetAllDocumentsEvent());
//     return BlocBuilder<DocumentBloc, DocumentState>(
//       bloc: bloc,
//       builder: (context, state) {
//         if (state is DocumentLoadedState) {
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text('All documents'),
//             ),
//             body: ListView.builder(
//                 itemCount: state.documents.length,
//                 itemBuilder: ((context, index) {
//                   return ListTile(
//                     title: Row(
//                       children: [
//                         Text(state.documents[index].idDocument),
//                         const SizedBox(width: 10),
//                         Text(state.documents[index].type.toString()),
//                         const SizedBox(width: 10),
//                         Text(state.documents[index].subType.toString()),
//                         const SizedBox(width: 10),
//                         Text(state.documents[index].year.toString()),
//                       ],
//                     ),
//                     trailing: IconButton(
//                         onPressed: (() {
//                           // bloc.add(ChangeSelectFirmByIdEvent(
//                           //     id: state.selectFirms[index].idFirm,
//                           //     selectedFirms: state.selectFirms));
//                           // setState(() {});
//                         }),
//                         icon: state.documents[index].idOld == null
//                             ? const Icon(Icons.add)
//                             : const Icon(Icons.done)),
//                   );
//                 })),
//           );
//         } else if (state is FirmLoadingState) {
//           return Scaffold(
//             appBar: AppBar(
//               // Here we take the value from the MyHomePage object that was created by
//               // the App.build method, and use it to set our appbar title.
//               title: Text(widget.title),
//             ),
//             body: Center(
//               // Center is a layout widget. It takes a single child and positions it
//               // in the middle of the parent.
//               child: Column(
//                 // Column is also a layout widget. It takes a list of children and
//                 // arranges them vertically. By default, it sizes itself to fit its
//                 // children horizontally, and tries to be as tall as its parent.
//                 //
//                 // Invoke "debug painting" (press "p" in the console, choose the
//                 // "Toggle Debug Paint" action from the Flutter Inspector in Android
//                 // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//                 // to see the wireframe for each widget.
//                 //
//                 // Column has various properties to control how it sizes itself and
//                 // how it positions its children. Here we use mainAxisAlignment to
//                 // center the children vertically; the main axis here is the vertical
//                 // axis because Columns are vertical (the cross axis would be
//                 // horizontal).
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   const Text(
//                     'You have pushed the button this many times:',
//                   ),
//                   Text(
//                     '$_counter',
//                     style: Theme.of(context).textTheme.headline4,
//                   ),
//                   // Text(state.firms.length.toString()),
//                 ],
//               ),
//             ),
//             floatingActionButton: FloatingActionButton(
//               onPressed: _incrementCounter,
//               tooltip: 'Increment',
//               child: const Icon(Icons.add),
//             ), // This trailing comma makes auto-formatting nicer for build methods.
//           );
//         } else {
//           return Scaffold(
//             body: Container(color: Colors.blue),
//           );
//         }
//       },
//     );
