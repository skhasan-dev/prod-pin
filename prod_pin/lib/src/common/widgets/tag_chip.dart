import 'package:flutter/material.dart';

import '../../core/extensions/context_extensions.dart';

class TagChip extends StatelessWidget {
  final String label;

  const TagChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: context.appColors.surfaceElevated,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.appColors.textMuted,
          width: 0.5,
        ),
      ),
      child: Text(
        '#$label',
        style: context.appTextStyles.bodySmall
            .copyWith(color: context.appColors.textMuted),
      ),
    );
  }
}
