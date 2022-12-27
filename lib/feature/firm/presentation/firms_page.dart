import 'package:flutter/material.dart';

import '../../../core/enums/firm.dart';
import 'pages/firm_doc_page.dart';

class FirmsPage extends StatelessWidget {
  const FirmsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Privredna društva'),

          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          // leading: Icon(Icons.bar_chart),
        ),
        body: SizedBox(
          width: double.infinity,
          child: ListView.builder(
              // controller: ScrollController(),
              // padding: EdgeInsets.all(0),
              itemCount: Firm.values.length,
              itemBuilder: ((context, index) {
                final firm = Firm.values[index];
                if (firm.id > 0) {
                  return ListTile(
                    // contentPadding: EdgeInsets.all(4),
                    // enabled: false,
                    dense: true,
                    autofocus: true,
                    focusColor: Colors.amber,
                    selected: false,
                    onTap: () {
                      Navigator.push(
                        context,
                        FirmDocPage.route(firm: firm),
                      );
                    },
                    title: Text(
                      firm.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(' - (${firm.shortName})'),
                    minLeadingWidth: 16,
                    horizontalTitleGap: 16,
                    leading: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.amber,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        margin: EdgeInsets.zero,
                        alignment: Alignment.center,
                        width: 30,
                        height: 30,
                        child: Text(
                          firm.id.toString(),
                          style: const TextStyle(fontSize: 12),
                        )),
                  );
                }
                return Container();
              })),
        ),
      ),
    );
  }
}
