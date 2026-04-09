import 'package:ceiba_technical_test/core/design/breakpoints/responsive_context.dart';
import 'package:flutter/material.dart';

class BaseGrid<T> extends StatelessWidget {
  const BaseGrid({
    super.key,
    required this.items,
    required this.card,
  });
  final List<T> items;
  final Widget Function(T item) card;

  static const double _spacing = 16;
  static const double _minCardWidthTablet = 320;
  static const double _minCardWidthDesktop = 360;

  int _columns(double maxWidth, bool isMobile, bool isTablet) {
    if (isMobile) return 1;

    final minCardWidth = isTablet ? _minCardWidthTablet : _minCardWidthDesktop;
    final maxColumns = isTablet ? 2 : 3;

    // Cuántas columnas caben sin que cada una quede por debajo de minCardWidth.
    for (var cols = maxColumns; cols >= 2; cols--) {
      final cardWidth = (maxWidth - ((cols - 1) * _spacing)) / cols;
      if (cardWidth >= minCardWidth) return cols;
    }
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.responsive(mobile: true, tablet: false);
    final isTablet = context.responsive(
      mobile: false,
      tablet: true,
      desktop: false,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final columns = _columns(maxWidth, isMobile, isTablet);
        final itemWidth = columns == 1
            ? maxWidth
            : (maxWidth - ((columns - 1) * _spacing)) / columns;

        return Wrap(
          spacing: _spacing,
          runSpacing: _spacing,
          children: List.generate(
            items.length,
            (index) {
              final item = items[index];
              return SizedBox(
                width: itemWidth,
                child: card(item),
              );
            },
          ),
        );
      },
    );
  }
}
