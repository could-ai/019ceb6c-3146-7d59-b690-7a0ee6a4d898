import 'package:flutter/material.dart';
import '../models/market_data.dart';
import '../widgets/k_line_chart.dart';

class TradeScreen extends StatefulWidget {
  final MarketSymbol symbol;
  const TradeScreen({super.key, required this.symbol});

  @override
  State<TradeScreen> createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  int _leverage = 100;
  final List<int> _leverageOptions = [5, 10, 50, 100, 500, 1000];

  @override
  Widget build(BuildContext context) {
    final isPositive = widget.symbol.change24h >= 0;
    final color = isPositive ? const Color(0xFF26A69A) : const Color(0xFFEF5350);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.symbol.symbol),
        actions: [
          IconButton(icon: const Icon(Icons.star_border), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Price Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.symbol.price.toStringAsFixed(widget.symbol.price < 10 ? 4 : 2),
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color),
                    ),
                    Text(
                      '${isPositive ? '+' : ''}${widget.symbol.change24h}%',
                      style: TextStyle(fontSize: 16, color: color),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('24h High', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    Text((widget.symbol.price * 1.02).toStringAsFixed(2), style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 4),
                    const Text('24h Low', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    Text((widget.symbol.price * 0.98).toStringAsFixed(2), style: const TextStyle(fontSize: 14)),
                  ],
                )
              ],
            ),
          ),
          
          // K-Line Chart
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: KLineChart(),
            ),
          ),

          // Trading Controls
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Color(0xFF1E1E1E),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Leverage', style: TextStyle(color: Colors.grey)),
                    DropdownButton<int>(
                      value: _leverage,
                      dropdownColor: const Color(0xFF2C2C2C),
                      underline: const SizedBox(),
                      items: _leverageOptions.map((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text('${value}x', style: const TextStyle(fontWeight: FontWeight.bold)),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _leverage = newValue;
                          });
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEF5350),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          _showOrderDialog('Sell');
                        },
                        child: const Text('Sell', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF26A69A),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          _showOrderDialog('Buy');
                        },
                        child: const Text('Buy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderDialog(String action) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: Text('$action ${widget.symbol.symbol}'),
        content: Text('Execute $action order at Market Price with ${_leverage}x leverage?\n\n(Note: Connect Supabase to execute real trades)'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: action == 'Buy' ? const Color(0xFF26A69A) : const Color(0xFFEF5350),
            ),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Order placed successfully!')),
              );
            },
            child: const Text('Confirm', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
