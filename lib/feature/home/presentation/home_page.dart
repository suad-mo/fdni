import 'package:fdni/feature/document/presentation/documents_page.dart';
import 'package:fdni/feature/firm/presentation/firms_page.dart';
import 'package:fdni/feature/home/presentation/tabs/years_tab_widget.dart';
import 'package:fdni/main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
        // persistentFooterButtons: [Icon(Icons.add)],

        bottomNavigationBar: buildBottomBar(),
        body: buildPages(),
      );

  buildBottomBar() {
    // const style = TextStyle(color: Colors.white);
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).primaryColorDark,
      selectedItemColor: Colors.white70,
      unselectedItemColor: Colors.white24,
      currentIndex: index,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.factory),
          label: 'Firms',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.preview),
          label: 'Staistic',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
      ],
      onTap: (index) => setState(() => this.index = index),
    );
  }

  buildPages() {
    switch (index) {
      case 0:
        return const DocumentsPage();
      case 1:
        return const FirmsPage();
      case 2:
        return const MyHomePage(
          title: 'Title',
        );
      case 3:
        return const YearsTabWidget();
      default:
        return Container();
    }
  }
}
