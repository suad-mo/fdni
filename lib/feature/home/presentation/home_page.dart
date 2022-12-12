import 'package:fdni/feature/document/presentation/documents_page.dart';
import 'package:fdni/feature/firm/presentation/firms_page.dart';
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
        bottomNavigationBar: buildBottomBar(),
        body: buildPages(),
      );

  buildBottomBar() {
    const style = TextStyle(color: Colors.white);
    return BottomNavigationBar(
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
          icon: Icon(Icons.factory),
          label: 'Firms',
        ),
      ],
      onTap: (index) => setState(() => this.index = index),
    );
  }

  buildPages() {
    switch (index) {
      case 0:
        return DocumentsPage();
      case 1:
        return const FirmsPage();
      case 2:
        return const MyHomePage(
          title: 'Title',
        );
      default:
        return Container();
    }
  }
}
