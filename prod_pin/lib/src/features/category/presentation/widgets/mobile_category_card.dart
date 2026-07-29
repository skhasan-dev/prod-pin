import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prod_pin/src/core/index.dart';
import 'package:prod_pin/src/features/category/index.dart';

class MobileCategoryCard extends StatelessWidget {
  final Category category;
  final bool isFull;
  final VoidCallback onTap;

  const MobileCategoryCard({
    super.key,
    required this.category,
    required this.isFull,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasImage = category.coverImage != null;
    final colors = context.appColors;
    final textStyles = context.appTextStyles;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: hasImage
                      ? Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              category.coverImage!,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: colors.surfaceElevated,
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  color: colors.textMuted,
                                ),
                              ),
                            ),
                            const DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.35, 1],
                                  colors: [
                                    Colors.transparent,
                                    Color(0xE6000000),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          color: colors.surfaceElevated,
                          child: Icon(
                            Icons.category_outlined,
                            color: colors.textMuted,
                            size: 32,
                          ),
                        ),
                ),
                if (isFull)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: colors.accent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Full',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  left: 14,
                  right: 14,
                  bottom: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.name ?? '',
                        style: textStyles.titleMedium.copyWith(
                          color: hasImage ? Colors.white : colors.textPrimary,
                          fontWeight: FontWeight.w700,
                          shadows: hasImage
                              ? const [
                                  Shadow(
                                    color: Colors.black54,
                                    blurRadius: 10,
                                    offset: Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${category.totalPins ?? 0} pins · ${DateFormat.yMMM().format(category.createdAt ?? DateTime.now())}',
                        style: textStyles.bodySmall.copyWith(
                          color: hasImage
                              ? Colors.white.withValues(alpha: .9)
                              : colors.textSecondary,
                          shadows: hasImage
                              ? const [
                                  Shadow(
                                    color: Colors.black45,
                                    blurRadius: 8,
                                    offset: Offset(0, 1),
                                  ),
                                ]
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
