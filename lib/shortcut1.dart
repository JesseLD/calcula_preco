import 'package:calcula_preco/calculate_page.dart';
import 'package:calcula_preco/gain_page.dart';
import 'package:calcula_preco/maker_page.dart';
import 'package:calcula_preco/modifier_page.dart';
import 'package:flutter/material.dart';

class shortcut1 extends StatefulWidget {
  const shortcut1({super.key});

  @override
  State<shortcut1> createState() => _shortcut1State();
}

class _shortcut1State extends State<shortcut1> {
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
        children: [calculate(), modifier(), gain(), maker()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: atual_page,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calcular de Preço',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.change_circle),
            label: 'Modificador de Preço',
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
