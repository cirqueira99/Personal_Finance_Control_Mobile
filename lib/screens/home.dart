import 'package:controle_financeiro/screens/costs/newCosts/newCost.dart';
import 'package:controle_financeiro/screens/principal/principal.dart';
import 'package:flutter/material.dart';

import 'accounts/accounts.dart';
import 'costs/costs.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int _selectedTab = 0;

  static const List<Widget> _screens = <Widget>[
    PrincipalPage(),
    CostsPage(),
    AccountsPage(),
  ];

  static final List<Color> _colorsTabs = <Color>[
    Colors.deepPurple,
    Colors.red.shade900,
    Colors.indigo,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        toolbarHeight: 30,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Início',
            backgroundColor: _colorsTabs[_selectedTab],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.trending_down),
            label: 'Custos',
            backgroundColor: _colorsTabs[_selectedTab],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_balance_wallet),
            label: 'Contas',
            backgroundColor: _colorsTabs[_selectedTab],
          ),
        ],
        currentIndex: _selectedIndex,
        selectedFontSize: 14,
        selectedItemColor: Colors.amber[500],
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.deepPurple,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=> const NewCost()),
          )
        },
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }
}
