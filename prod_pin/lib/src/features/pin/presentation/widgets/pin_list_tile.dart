import 'package:flutter/material.dart';
import 'package:prod_pin/src/common/index.dart';
import 'package:prod_pin/src/core/index.dart';

import '../../data/entities/post.dart';
import 'pin_action_menu.dart';

class PinListTile extends StatelessWidget {
  final Post post;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onLinkTap;
  final ValueChanged<PinImageGenerationStatus> onCycleImageStatus;
  final ValueChanged<PinStatus> onStatusChanged;

  const PinListTile({
    super.key,
    required this.post,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    required this.onLinkTap,
    required this.onCycleImageStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;
    final visibleTags = post.tags.take(3).toList();
    final remaining = post.tags.length - visibleTags.length;

    return InkWell(
      onTap: onTap,
      hoverColor: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: post.imageUrls.isNotEmpty
                  ? Image.network(
                      post.imageUrls.first,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _placeholder(colors),
                    )
                  : _placeholder(colors),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.pinterestTitle ?? post.amazonUrl,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyles.titleMedium.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  if (context.isMobile)
                    Row(
                      spacing: 12,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (post.status != PinStatus.published)
                          ImageGenBadge(
                            value: post.imageGenerated,
                            onApply: onCycleImageStatus,
                            disable: true,
                          ),
                        StatusBadge(
                          status: post.status,
                          onApply: onStatusChanged,
                          disable: true,
                        ),
                      ],
                    )
                  else
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        ...visibleTags.map((t) => TagChip(label: t)),
                        if (remaining > 0)
                          Text(
                            '+$remaining more',
                            style: textStyles.bodySmall,
                          ),
                      ],
                    ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (context.isMobile)
              PinActionMenuMobile(
                post: post,
                onEdit: onEdit,
                onDelete: onDelete,
                onLinkTap: onLinkTap,
                onImageStatus: onCycleImageStatus,
                onPublishStatus: onStatusChanged,
              )
            else
              PinActionMenuWeb(
                post: post,
                onEdit: onEdit,
                onDelete: onDelete,
                onLinkTap: onLinkTap,
                onCycleImageStatus: onCycleImageStatus,
                onStatusChanged: onStatusChanged,
              ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder(colors) => Container(
        height: 50,
        width: 50,
        color: colors.surfaceElevated,
        child: Icon(
          Icons.image_outlined,
          color: colors.textMuted,
          size: 20,
        ),
      );
}
