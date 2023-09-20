import 'package:flutter/material.dart';

class YearsTabWidget extends StatelessWidget {
  static const List<int> years = <int>[
    2023,
    2022,
    2021,
    2020,
    2016,
    2015,
    2014,
    2013,
    2012
  ];
  const YearsTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: years.length,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                isScrollable: true,
                tabs: [
                  ...years
                      .map((e) => Tab(
                            text: e.toString(),
                          ))
                      .toList()
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Center(
            //   child: Icon(Icons.tab),
            // ),
            // Center(
            //   child: Icon(Icons.outgoing_mail),
            // ),
            // Center(
            //   child: Icon(Icons.missed_video_call),
            // ),
            ...years
                .map((e) => Center(
                        child: Text(
                      e.toString(),
                    )))
                .toList(),
          ],
        ),
      ),
    );
  }
}
