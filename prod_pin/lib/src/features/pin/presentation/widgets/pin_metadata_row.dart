import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prod_pin/src/common/index.dart';
import 'package:prod_pin/src/core/index.dart';
import 'package:prod_pin/src/features/pin/index.dart';

class PinMetadataRow extends StatelessWidget {
  final Post post;
  final ValueChanged<PinImageGenerationStatus> onImageStatus;
  final ValueChanged<PinStatus> onPublishStatus;

  const PinMetadataRow({
    super.key,
    required this.post,
    required this.onImageStatus,
    required this.onPublishStatus,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = context.appTextStyles;
    final colors = context.appColors;
    final created = DateFormat.yMMMd().format(post.createdAt);
    final updated = DateFormat.yMMMd().format(post.updatedAt);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            StatusBadge(
              status: post.status,
              onApply: onPublishStatus,
              disable: post.status == PinStatus.published,
            ),
            ImageGenBadge(
              value: post.imageGenerated,
              onApply: onImageStatus,
              disable: post.status == PinStatus.published,
            ),
            _PinCategoryBadge(name: post.category.name ?? ''),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Text(
            'Created $created · Updated $updated',
            style: textStyles.bodySmall.copyWith(color: colors.textMuted),
          ),
        ),
      ],
    );
  }
}

class _PinCategoryBadge extends StatelessWidget {
  final String name;

  const _PinCategoryBadge({required this.name});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colors.surfaceElevated,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.divider),
      ),
      child: Text(
        name,
        style: TextStyle(
          color: colors.textSecondary,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
