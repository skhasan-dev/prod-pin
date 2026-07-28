import 'package:flutter/material.dart';
import 'package:prod_pin/src/core/utils/enums.dart';

import '../../core/extensions/context_extensions.dart';

class StatusBadge extends StatelessWidget {
  final PinStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final color = switch (status) {
      PinStatus.ready => colors.ready,
      PinStatus.published => colors.published,
      PinStatus.draft => colors.draft,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class ImageGenBadge extends StatelessWidget {
  final PinImageGenerationStatus value;

  const ImageGenBadge({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final color = switch (value) {
      PinImageGenerationStatus.partiallyGenerated => colors.partiallyGenerated,
      PinImageGenerationStatus.generated => colors.generated,
      PinImageGenerationStatus.yetToGenerate => colors.yetToGenerate,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        value.label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
