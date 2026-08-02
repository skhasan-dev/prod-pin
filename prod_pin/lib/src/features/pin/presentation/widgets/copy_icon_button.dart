import 'package:flutter/material.dart';
import 'package:prod_pin/src/core/index.dart';

class CopyIconButton extends StatelessWidget {
  final VoidCallback onTap;

  const CopyIconButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.copy_outlined,
        size: 18,
        color: context.appColors.textSecondary,
      ),
      onPressed: onTap,
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(),
    );
  }
}
