import 'package:flutter/material.dart';
import 'package:prod_pin/src/common/index.dart';
import 'package:prod_pin/src/core/index.dart';
import 'package:prod_pin/src/features/pin/presentation/widgets/copy_icon_button.dart';

class PinTagsCard extends StatelessWidget {
  final List<String> tags;
  final VoidCallback? onCopy;

  const PinTagsCard({super.key, required this.tags, required this.onCopy});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text('Tags', style: textStyles.labelMedium)),
              if (onCopy != null) CopyIconButton(onTap: onCopy!),
            ],
          ),
          const SizedBox(height: 10),
          tags.isEmpty
              ? Text(
                  'No tags',
                  style: textStyles.bodySmall.copyWith(color: colors.textMuted),
                )
              : Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: tags.map((t) => TagChip(label: t)).toList(),
                ),
        ],
      ),
    );
  }
}
