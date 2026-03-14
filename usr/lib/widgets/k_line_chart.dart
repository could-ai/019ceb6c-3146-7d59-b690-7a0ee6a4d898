import 'package:flutter/material.dart';
import 'dart:math';

class KLineChart extends StatelessWidget {
  const KLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    // 使用 LayoutBuilder 确保 CustomPaint 能够获取到明确的尺寸，防止在 Web 端渲染时尺寸为 0 导致报错
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          decoration: BoxDecoration(
            color: const Color(0xFF121212),
            border: Border.all(color: const Color(0xFF2C2C2C)),
          ),
          child: CustomPaint(
            size: Size(constraints.maxWidth, constraints.maxHeight),
            painter: _CandlestickPainter(),
          ),
        );
      }
    );
  }
}

class _CandlestickPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final paint = Paint()..strokeWidth = 1.5;
    final random = Random(42); // Fixed seed for consistent mock data
    
    final int candleCount = 40;
    final double candleWidth = size.width / candleCount;
    
    double currentPrice = size.height / 2;
    
    for (int i = 0; i < candleCount; i++) {
      final double open = currentPrice;
      final double close = open + (random.nextDouble() - 0.5) * 40;
      final double high = max(open, close) + random.nextDouble() * 20;
      final double low = min(open, close) - random.nextDouble() * 20;
      
      currentPrice = close; // Next candle starts near previous close
      
      final bool isUp = close <= open; // In Flutter canvas, smaller Y is higher up
      
      paint.color = isUp ? const Color(0xFF26A69A) : const Color(0xFFEF5350);
      
      final double x = i * candleWidth + candleWidth / 2;
      
      // Draw wick
      canvas.drawLine(Offset(x, high), Offset(x, low), paint);
      
      // Draw body
      final double bodyTop = min(open, close);
      final double bodyBottom = max(open, close);
      final double bodyHeight = max(2.0, bodyBottom - bodyTop); // Minimum 2px body
      
      canvas.drawRect(
        Rect.fromLTWH(x - candleWidth * 0.3, bodyTop, candleWidth * 0.6, bodyHeight),
        paint..style = PaintingStyle.fill,
      );
    }
    
    // Draw grid lines
    final gridPaint = Paint()
      ..color = const Color(0xFF2C2C2C)
      ..strokeWidth = 1;
      
    for (int i = 1; i < 5; i++) {
      final double y = size.height * (i / 5);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
