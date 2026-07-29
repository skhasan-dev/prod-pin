import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/extensions/context_extensions.dart';

class ProdPinAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final bool showBackButton;
  final bool returnTrueOnPop;

  const ProdPinAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
    this.showBackButton = false,
    this.returnTrueOnPop = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      toolbarHeight: subtitle == null ? 72 : 82,
      automaticallyImplyLeading: false,
      titleSpacing: 20,
      leadingWidth: showBackButton ? 60 : 0,
      leading: showBackButton
          ? Center(
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        context.appColors.textSecondary.withValues(alpha: .25),
                  ),
                ),
                child: IconButton(
                  onPressed: () => context.pop(returnTrueOnPop),
                  icon: const Icon(Icons.arrow_back_rounded, size: 22),
                  splashRadius: 22,
                ),
              ),
            )
          : null,
      actions: actions,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: context.appTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(
              subtitle!,
              style: context.appTextStyles.bodySmall.copyWith(
                color: context.appColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(subtitle == null ? 72 : 82);
}
