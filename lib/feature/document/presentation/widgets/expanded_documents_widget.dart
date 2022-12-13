import 'package:flutter/material.dart';

import '../../../../core/enums/document_sub_type.dart';
import '../../../../core/enums/document_type.dart';

class ExpandedDocumentsWidget extends StatefulWidget {
  final Map<int, Map<DocumentType, List<DocumentSubType>>> list;
  const ExpandedDocumentsWidget({super.key, required this.list});

  @override
  State<ExpandedDocumentsWidget> createState() =>
      _ExpandedDocumentsWidgetState();
}

class _ExpandedDocumentsWidgetState extends State<ExpandedDocumentsWidget> {
  List<bool> _isYearEx = [];
  List<int> _yrs = [];

  List<bool> _isTypeEx = [];
  List<DocumentType> _types = [];

  // @override
  // void initState() {
  //   List<bool> a = [];
  //   List<bool> b = [];
  //   widget.list.forEach((key, value) {
  //     a.add(false);
  //     for (var _ in value.entries) {
  //       b.add(false);
  //     }
  //   });
  //   _isYearEx = a;
  //   _isTypeEx = b;

  //   super.initState();
  // }

  // bool getIsExpandedByIndex(int index) => _years[index].values.first;

  // bool changeIsExpandedByIndex(int index) => _years[index].values.first;

  @override
  Widget build(BuildContext context) {
    final list = widget.list;

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
          final types = e.value;
          setState(() {
            _isYearEx.add(false);
            _yrs.add(year);
          });
          return ExpansionPanel(
              headerBuilder: ((context, isExpanded) {
                return ListTile(
                  title: Text(e.key.toString()),
                  // enableFeedback: false,
                  trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: (() {}),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 50),
                  // selected: true,
                  // selectedColor: Colors.amber,
                  leading: IconButton(
                    icon: Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more),
                    onPressed: () {
                      setState(() {
                        _isYearEx[_yrs.indexOf(year)] = !isExpanded;
                      });
                    },
                  ),
                  // isThreeLine: false,
                  // subtitle: Text('Subtitle'),
                  horizontalTitleGap: 0,
                );
              }),
              isExpanded: _isYearEx[_yrs.indexOf(e.key)],
              body: Container(
                margin: EdgeInsets.only(left: 40),
                child: ExpansionPanelList(
                  expandedHeaderPadding:
                      const EdgeInsets.symmetric(horizontal: 26),
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      _isTypeEx[index] = !isExpanded;
                    });
                  },
                  children: [
                    ...types.entries.map<ExpansionPanel>((a) {
                      final type = a.key;
                      setState(() {
                        _isTypeEx.add(false);
                        _types.add(type);
                      });
                      return ExpansionPanel(
                        headerBuilder:
                            (BuildContext context, bool isExpanded) => ListTile(
                          title: Text(type.translation),
                        ),
                        body: Column(
                          children: [
                            ...a.value.map<Widget>((e) => Text(e.translation)),
                          ],
                        ),
                        isExpanded: _isTypeEx[_types.indexOf(type)],
                      );
                    }).toList(),
                  ],
                ),
              ));
        }).toList(),
      ],
    );
  }
}

// ...list.entries.map<Widget>(
// (e) {
