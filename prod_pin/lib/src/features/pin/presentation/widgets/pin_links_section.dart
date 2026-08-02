import 'package:flutter/material.dart';
import 'package:prod_pin/src/core/index.dart';

class PinLinksSection extends StatelessWidget {
  final String amazonUrl;
  final String? affiliatedLink;
  final VoidCallback onVisitProduct;
  final VoidCallback? onCopyAffiliated;
  final VoidCallback onAddAffiliated;

  const PinLinksSection({
    super.key,
    required this.amazonUrl,
    required this.affiliatedLink,
    required this.onVisitProduct,
    required this.onCopyAffiliated,
    required this.onAddAffiliated,
  });

  @override
  Widget build(BuildContext context) {
    final hasAffiliated = affiliatedLink != null && affiliatedLink!.isNotEmpty;

    return Row(
      children: [
        Expanded(
          child: _PinCtaButton(
            icon: Icons.open_in_new_rounded,
            label: 'Visit Product',
            onTap: onVisitProduct,
            isPrimary: true,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: hasAffiliated
              ? _PinCtaButton(
                  icon: Icons.link_rounded,
                  label: 'Copy Link',
                  onTap: onCopyAffiliated!,
                  isPrimary: false,
                )
              : _PinCtaButton(
                  icon: Icons.add_link_rounded,
                  label: 'Add Link',
                  onTap: onAddAffiliated,
                  isPrimary: false,
                  isDashed: true,
                ),
        ),
      ],
    );
  }
}

class _PinCtaButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;
  final bool isDashed;

  const _PinCtaButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isPrimary,
    this.isDashed = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isPrimary ? colors.accent : colors.surface,
          borderRadius: BorderRadius.circular(12),
          border: isDashed
              ? Border.all(color: colors.textMuted, width: 1)
              : isPrimary
                  ? null
                  : Border.all(color: colors.divider),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isPrimary ? Colors.white : colors.textSecondary,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isPrimary ? Colors.white : colors.textSecondary,
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
