import 'package:fdni/core/dependency_injection/get_it.dart';
import 'package:fdni/feature/document/presentation/widgets/bar_chart_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/enums/document_sub_type.dart';
import '../../../firm/presentation/blocs/all_data_bloc/all_data_bloc.dart';

class ExpandedReportsWidget extends StatefulWidget {
  const ExpandedReportsWidget({super.key});

  @override
  State<ExpandedReportsWidget> createState() => _ExpandedReportsWidgetState();
}

class _ExpandedReportsWidgetState extends State<ExpandedReportsWidget> {
  final List<bool> _isYearEx = [];
  final List<int> _yrs = [];

  // final List<bool> _isTypeEx = [];
  // final List<DocumentType> _types = [];

  Map<int, List<DocumentSubType>> list = {};

  @override
  void initState() {
    list = getIt.get<AllDataBloc>().state.existingReports;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      dividerColor: Colors.amber,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _isYearEx[index] = !isExpanded;
        });
      },
      children: [
        ...list.entries.map<ExpansionPanel>((e) {
          final year = e.key;
          final List<DocumentSubType> subTypes = e.value;
          setState(() {
            _isYearEx.add(false);
            _yrs.add(year);
          });
          return ExpansionPanel(
            headerBuilder: ((context, isExpanded) {
              return ListTile(
                title: Text(e.key.toString()),
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              );
            }),
            isExpanded: _isYearEx[_yrs.indexOf(e.key)],
            body: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  ...subTypes.reversed.map(
                    (s) {
                      final id = '$year-1-${s.id}';

                      // return PieYearDocumentSubType(
                      //   id: id,
                      //   chartTitle: s.translation,
                      // );
                      return BarChartWidget(idDocument: id);
                    },
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}

// ...list.entries.map<Widget>(
// (e) {
