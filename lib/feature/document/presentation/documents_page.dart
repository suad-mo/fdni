import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../core/dependency_injection/get_it.dart';
import '../../firm/presentation/blocs/document_bloc/document_bloc.dart';
import '../../firm/presentation/widgets/data_grid_widget.dart';
import '../../firm/presentation/widgets/horizontal_bar_chart_widget.dart';
import '../../firm/presentation/widgets/pie_widget.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final list = getIt.get<DocumentBloc>().state.existingYearTypDocument;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Direkcija za namjensku industriju'),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: list.entries
                .map<Widget>(
                  (e) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(e.key.toString()),
                      ...e.value.entries
                          .map(
                            (x) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(x.key.translationII),
                            ),
                          )
                          .toList()
                    ],
                  ),
                )
                .toList()

            //Text('$key: $value')
            ),
      ),
    );
  }
}
