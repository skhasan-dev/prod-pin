import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:prod_pin/src/core/index.dart';

class PinImageCarousel extends StatelessWidget {
  final List<String> urls;
  final int currentIndex;
  final void Function(int) onPageChanged;

  const PinImageCarousel({
    super.key,
    required this.urls,
    required this.currentIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CarouselSlider.builder(
            itemCount: urls.length,
            options: CarouselOptions(
              height: 260,
              viewportFraction: 1.0,
              enableInfiniteScroll: urls.length > 1,
              onPageChanged: (i, _) => onPageChanged(i),
            ),
            itemBuilder: (context, index, _) => Image.network(
              urls[index],
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (_, __, ___) => Container(
                color: colors.surfaceElevated,
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: colors.textMuted,
                  size: 36,
                ),
              ),
            ),
          ),
        ),
        if (urls.length > 1) ...[
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              urls.length,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                height: 6,
                width: i == currentIndex ? 18 : 6,
                decoration: BoxDecoration(
                  color: i == currentIndex ? colors.accent : colors.divider,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
