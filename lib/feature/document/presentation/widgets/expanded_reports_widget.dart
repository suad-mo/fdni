import 'package:fdni/core/dependency_injection/get_it.dart';
import 'package:fdni/feature/document/presentation/widgets/pie_year_document_subtype.dart';
import 'package:fdni/feature/firm/presentation/blocs/document_bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/document_sub_type.dart';
import '../../../../core/enums/document_type.dart';
import '../../../firm/presentation/blocs/document_firm_bloc/document_firm_bloc.dart';

class ExpandedReportsWidget extends StatefulWidget {
  const ExpandedReportsWidget({super.key});

  @override
  State<ExpandedReportsWidget> createState() => _ExpandedReportsWidgetState();
}

class _ExpandedReportsWidgetState extends State<ExpandedReportsWidget> {
  List<bool> _isYearEx = [];
  List<int> _yrs = [];

  List<bool> _isTypeEx = [];
  List<DocumentType> _types = [];

  @override
  Widget build(BuildContext context) {
    var list = getIt.get<DocumentBloc>().state.existingReports;

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

                      return PieYearDocumentSubType(
                        id: id,
                        chartTitle: s.translation,
                      );
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
