class MarketSymbol {
  final String symbol;
  final String name;
  final double price;
  final double change24h;
  final String type;

  MarketSymbol({
    required this.symbol,
    required this.name,
    required this.price,
    required this.change24h,
    required this.type,
  });
}

final List<MarketSymbol> mockMarkets = [
  MarketSymbol(symbol: 'XAU/USD', name: 'Gold', price: 2350.50, change24h: 1.2, type: 'Metals'),
  MarketSymbol(symbol: 'XAG/USD', name: 'Silver', price: 28.45, change24h: -0.5, type: 'Metals'),
  MarketSymbol(symbol: 'BTC/USD', name: 'Bitcoin', price: 64230.00, change24h: 2.4, type: 'Crypto'),
  MarketSymbol(symbol: 'ETH/USD', name: 'Ethereum', price: 3450.75, change24h: 3.1, type: 'Crypto'),
  MarketSymbol(symbol: 'EUR/USD', name: 'Euro / US Dollar', price: 1.0852, change24h: 0.1, type: 'Forex'),
  MarketSymbol(symbol: 'GBP/USD', name: 'British Pound', price: 1.2640, change24h: -0.2, type: 'Forex'),
];
