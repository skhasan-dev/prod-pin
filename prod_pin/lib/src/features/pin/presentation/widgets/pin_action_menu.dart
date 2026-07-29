import 'package:flutter/material.dart';
import 'package:prod_pin/src/core/utils/enums.dart';

import '../../../../common/widgets/status_badge.dart';
import '../../../../core/extensions/context_extensions.dart';
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

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // InkWell(
        //   onTap: () => onCycleImageStatus(post.imageGenerated.next),
        //   borderRadius: BorderRadius.circular(20),
        //   child: ImageGenBadge(value: post.imageGenerated),
        // ),
        // const SizedBox(width: 8),
        // DropdownButtonHideUnderline(
        //   child: DropdownButton<PinStatus>(
        //     value: post.status,
        //     dropdownColor: colors.surfaceElevated,
        //     style: TextStyle(color: colors.textPrimary, fontSize: 12),
        //     items: PinStatus.values
        //         .map(
        //           (s) => DropdownMenuItem(
        //             value: s,
        //             child: StatusBadge(status: s),
        //           ),
        //         )
        //         .toList(),
        //     onChanged: (v) {
        //       if (v != null) onStatusChanged(v);
        //     },
        //   ),
        // ),
        ImageGenBadge(value: post.imageGenerated),
        const SizedBox(width: 12),
        StatusBadge(status: post.status),
        const SizedBox(width: 12),
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
    );
  }
}

class PinActionMenuMobile extends StatelessWidget {
  final Post post;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onLinkTap;
  final ValueChanged<PinImageGenerationStatus> onCycleImageStatus;
  final ValueChanged<PinStatus> onStatusChanged;

  const PinActionMenuMobile({
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

    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, color: colors.textSecondary),
      color: colors.surfaceElevated,
      onSelected: (value) {
        switch (value) {
          case 'link':
            onLinkTap();
          case 'image_status':
            onCycleImageStatus(post.imageGenerated.next);
          case 'edit':
            onEdit();
          case 'delete':
            onDelete();
          case 'status_draft':
            onStatusChanged(PinStatus.draft);
          case 'status_ready':
            onStatusChanged(PinStatus.ready);
          case 'status_published':
            onStatusChanged(PinStatus.published);
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'link', child: Text('Affiliated Link')),
        PopupMenuItem(
          value: 'image_status',
          child: Text(
            'Cycle Image Status (${post.imageGenerated.label})',
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(value: 'status_draft', child: Text('Set: Draft')),
        const PopupMenuItem(value: 'status_ready', child: Text('Set: Ready')),
        const PopupMenuItem(
          value: 'status_published',
          child: Text('Set: Published'),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(value: 'edit', child: Text('Edit')),
        PopupMenuItem(
          value: 'delete',
          child: Text(
            'Delete',
            style: TextStyle(color: context.appColors.error),
          ),
        ),
      ],
    );
  }
}
