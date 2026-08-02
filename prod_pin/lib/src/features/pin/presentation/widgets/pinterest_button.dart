import 'package:flutter/material.dart';
import 'package:prod_pin/src/core/index.dart';

class PinterestButton extends StatelessWidget {
  final VoidCallback onTap;

  const PinterestButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.accent),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.push_pin_outlined, size: 16, color: colors.accent),
            const SizedBox(width: 8),
            Text(
              'Post to Pinterest',
              style: TextStyle(
                color: colors.accent,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
