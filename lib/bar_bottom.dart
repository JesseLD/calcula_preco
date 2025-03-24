import 'package:calcula_preco/sidebar.dart';
import 'package:flutter/material.dart';
import 'calculate_page.dart';
import 'gain_page.dart';
import 'maker_page.dart';

class bottom_bar extends StatefulWidget {
  const bottom_bar({super.key});

  @override
  State<bottom_bar> createState() => _bottom_barState();
}

class _bottom_barState extends State<bottom_bar> {
  int atual_page = 1;
  late PageController pages;

  @override
  void initState() {
    super.initState();
    pages = PageController(initialPage: atual_page);
  }

  setAtualPage(page) {
    setState(() {
      atual_page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pages,
        onPageChanged: setAtualPage,
        children: [sidebar(), calculate(), gain(), maker()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: atual_page,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Cálculo de Preço',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Lucro',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.construction),
            label: 'Formação de Preço',
          ),
        ],
        onTap: (page) {
          pages.animateToPage(
            page,
            duration: Duration(seconds: 1),
            curve: Curves.ease,
          );
        },
        iconSize: 30,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.inversePrimary,
      ),
    );
  }
}
