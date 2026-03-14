import 'package:flutter/material.dart';
import 'markets_screen.dart';
import 'trade_screen.dart';
import 'wallet_screen.dart';
import '../models/market_data.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _currentIndex = 0;
  
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const MarketsScreen(),
      TradeScreen(symbol: mockMarkets[0]), // Default to Gold
      const WalletScreen(),
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        backgroundColor: const Color(0xFF1E1E1E),
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Markets'),
          BottomNavigationBarItem(icon: Icon(Icons.swap_vert), label: 'Trade'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
        ],
      ),
    );
  }
}
