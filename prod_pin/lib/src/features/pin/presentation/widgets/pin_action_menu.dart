import 'package:flutter/material.dart';
import 'package:prod_pin/src/core/index.dart';

import '../../../../common/widgets/status_badge.dart';
import '../../data/entities/post.dart';

class PinActionMenuWeb extends StatelessWidget {
  final Post post;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onLinkTap;
  final ValueChanged<PinImageGenerationStatus> onCycleImageStatus;
  final ValueChanged<PinStatus> onStatusChanged;

  const PinActionMenuWeb({
    super.key,
    required this.post,
    required this.onEdit,
    required this.onDelete,
    required this.onLinkTap,
    required this.onCycleImageStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    bool isPublished = post.status == PinStatus.published;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ImageGenBadge(
          value: post.imageGenerated,
          onApply: onCycleImageStatus,
          disable: isPublished,
        ),
        const SizedBox(width: 12),
        StatusBadge(
          status: post.status,
          onApply: onStatusChanged,
          disable: isPublished,
        ),
        const SizedBox(width: 12),
        if (!isPublished) ...[
          Tooltip(
            message: 'Affiliate Link',
            child: GestureDetector(
              onTap: onLinkTap,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: colors.published,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: colors.published.withValues(alpha: 0.2),
                ),
                child: Icon(
                  Icons.link,
                  size: 22,
                  color: colors.published,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Tooltip(
            message: 'Edit',
            child: GestureDetector(
              onTap: onEdit,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: colors.ready,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: colors.ready.withValues(alpha: 0.2),
                ),
                child: Icon(
                  Icons.edit_outlined,
                  size: 22,
                  color: colors.ready,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Tooltip(
            message: 'Delete',
            child: GestureDetector(
              onTap: onDelete,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: colors.accentMuted,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: colors.error,
                ),
                child: Icon(
                  Icons.delete_outline,
                  size: 24,
                  color: colors.accentMuted,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class PinActionMenuMobile extends StatelessWidget {
  final Post post;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onLinkTap;
  final ValueChanged<PinImageGenerationStatus> onImageStatus;
  final ValueChanged<PinStatus> onPublishStatus;

  const PinActionMenuMobile({
    super.key,
    required this.post,
    required this.onEdit,
    required this.onDelete,
    required this.onLinkTap,
    required this.onImageStatus,
    required this.onPublishStatus,
  });

  @override
  Widget build(BuildContext context) {
    if (post.status == PinStatus.published) return SizedBox.shrink();

    final colors = context.appColors;

    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, color: colors.textSecondary),
      color: colors.surfaceElevated,
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'link',
          onTap: onLinkTap,
          child: Text('Affiliated Link'),
        ),
        PopupMenuItem(
          value: 'image_status',
          onTap: () {
            AppUtils.showItemSheet<PinImageGenerationStatus>(
              context,
              selectedValue: post.imageGenerated,
              label: 'Image Generation Status',
              values: PinImageGenerationStatus.values,
              onApplyPressed: onImageStatus,
              labelBuilder: (status) => status.label,
            );
          },
          child: Text('Image Generation Status'),
        ),
        PopupMenuItem(
          value: 'publish_status',
          onTap: () {
            AppUtils.showItemSheet<PinStatus>(
              context,
              selectedValue: post.status,
              label: 'Image Generation Status',
              values: PinStatus.values,
              onApplyPressed: onPublishStatus,
              labelBuilder: (status) => status.label,
            );
          },
          child: const Text('Publish Status'),
        ),
        PopupMenuItem(
          value: 'edit',
          onTap: onEdit,
          child: Text('Edit'),
        ),
        PopupMenuItem(
          value: 'delete',
          onTap: onDelete,
          child: Text(
            'Delete',
            style: TextStyle(color: context.appColors.error),
          ),
        ),
      ],
    );
  }
}
