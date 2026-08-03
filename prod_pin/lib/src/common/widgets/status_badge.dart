import 'package:flutter/material.dart';
import 'package:prod_pin/src/core/index.dart';

class StatusBadge extends StatelessWidget {
  final PinStatus status;
  final ValueChanged<PinStatus> onApply;
  final bool disable;

  const StatusBadge({
    super.key,
    required this.status,
    required this.onApply,
    this.disable = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final color = switch (status) {
      PinStatus.ready => colors.ready,
      PinStatus.published => colors.published,
      PinStatus.draft => colors.draft,
    };
    return GestureDetector(
      onTap: disable
          ? null
          : () {
              AppUtils.showItemSheet<PinStatus>(
                context,
                selectedValue: status,
                label: 'Publish Status',
                values: PinStatus.values,
                onApplyPressed: onApply,
                labelBuilder: (status) => status.label,
              );
            },
      child: Container(
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
      ),
    );
  }
}

class ImageGenBadge extends StatelessWidget {
  final PinImageGenerationStatus value;
  final ValueChanged<PinImageGenerationStatus> onApply;
  final bool disable;

  const ImageGenBadge({
    super.key,
    required this.value,
    required this.onApply,
    this.disable = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final color = switch (value) {
      PinImageGenerationStatus.partiallyGenerated => colors.partiallyGenerated,
      PinImageGenerationStatus.generated => colors.generated,
      PinImageGenerationStatus.yetToGenerate => colors.yetToGenerate,
    };
    return GestureDetector(
      onTap: disable
          ? null
          : () {
              AppUtils.showItemSheet<PinImageGenerationStatus>(
                context,
                selectedValue: value,
                label: 'Image Generation Status',
                values: PinImageGenerationStatus.values,
                onApplyPressed: onApply,
                labelBuilder: (status) => status.label,
              );
            },
      child: Container(
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
      ),
    );
  }
}
