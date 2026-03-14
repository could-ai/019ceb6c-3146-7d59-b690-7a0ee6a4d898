import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet & Account', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2C3E50), Color(0xFF000000)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Equity (USDT)', style: TextStyle(color: Colors.grey, fontSize: 16)),
                  const SizedBox(height: 8),
                  const Text('12,450.00', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildBalanceItem('Available Margin', '10,000.00'),
                      _buildBalanceItem('Used Margin', '2,450.00'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_downward, color: Colors.white),
                    label: const Text('Deposit USDT', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF26A69A),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () => _showActionDialog(context, 'Deposit USDT', 'Select Network (ERC20/TRC20)'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_upward, color: Colors.white),
                    label: const Text('Withdraw', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2C2C2C),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () => _showActionDialog(context, 'Withdraw USDT', 'Enter withdrawal address'),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            const Text('Recent Transactions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            
            // Mock Transactions
            _buildTransactionTile('Deposit', 'TRC20', '+5,000.00 USDT', 'Completed', true),
            _buildTransactionTile('Withdrawal', 'ERC20', '-1,200.00 USDT', 'Completed', false),
            _buildTransactionTile('Deposit', 'TRC20', '+8,650.00 USDT', 'Completed', true),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceItem(String label, String amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 4),
        Text(amount, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
      ],
    );
  }

  Widget _buildTransactionTile(String type, String network, String amount, String status, bool isPositive) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: const Color(0xFF1E1E1E),
        child: Icon(
          isPositive ? Icons.arrow_downward : Icons.arrow_upward,
          color: isPositive ? const Color(0xFF26A69A) : Colors.white,
        ),
      ),
      title: Text(type),
      subtitle: Text(network, style: const TextStyle(color: Colors.grey)),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(amount, style: TextStyle(fontWeight: FontWeight.bold, color: isPositive ? const Color(0xFF26A69A) : Colors.white)),
          Text(status, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  void _showActionDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: Text(title),
        content: Text('$content\n\n(Note: Please connect a Supabase project to enable real wallet operations and backend integration.)'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}
