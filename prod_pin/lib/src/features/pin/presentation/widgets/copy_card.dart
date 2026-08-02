import 'package:flutter/material.dart';
import 'package:prod_pin/src/core/index.dart';
import 'package:prod_pin/src/features/pin/presentation/widgets/copy_icon_button.dart';

class CopyCard extends StatelessWidget {
  final String label;
  final String content;
  final VoidCallback? onCopy;

  const CopyCard({
    super.key,
    required this.label,
    required this.content,
    required this.onCopy,
  });

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
              Expanded(child: Text(label, style: textStyles.labelMedium)),
              if (onCopy != null) CopyIconButton(onTap: onCopy!),
            ],
          ),
          const SizedBox(height: 8),
          Text(content, style: textStyles.bodyMedium),
        ],
      ),
    );
  }
}
