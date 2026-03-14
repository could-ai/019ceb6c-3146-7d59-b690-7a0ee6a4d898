import 'package:flutter/material.dart';
import '../models/market_data.dart';
import 'trade_screen.dart';

class MarketsScreen extends StatelessWidget {
  const MarketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Markets', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        itemCount: mockMarkets.length,
        itemBuilder: (context, index) {
          final market = mockMarkets[index];
          final isPositive = market.change24h >= 0;
          final color = isPositive ? const Color(0xFF26A69A) : const Color(0xFFEF5350);

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            title: Text(market.symbol, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            subtitle: Text(market.name, style: const TextStyle(color: Colors.grey)),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  market.price.toStringAsFixed(market.price < 10 ? 4 : 2),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${isPositive ? '+' : ''}${market.change24h}%',
                    style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TradeScreen(symbol: market)),
              );
            },
          );
        },
      ),
    );
  }
}
