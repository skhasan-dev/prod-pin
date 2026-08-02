import 'package:flutter/material.dart';
import 'package:prod_pin/src/common/index.dart' show ProdPinTextField;
import 'package:prod_pin/src/core/index.dart' show ResponsiveContext;

class AppUtils {
  static Future<bool> showDeleteDialog(
    BuildContext context, {
    required String title,
    required String description,
    required String positiveActionLabel,
    required String negativeActionLabel,
  }) async {
    final res = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: context.appColors.surface,
        title: Text(
          title,
          style: TextStyle(color: context.appColors.textPrimary),
        ),
        content: Text(
          description,
          style: TextStyle(color: context.appColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(negativeActionLabel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              positiveActionLabel,
              style: TextStyle(color: context.appColors.error),
            ),
          ),
        ],
      ),
    );

    return res ?? false;
  }

  static Future<String?> showAffiliatedLinkDialog(
    BuildContext context, {
    required String? currentLink,
  }) {
    final controller = TextEditingController(text: currentLink ?? '');
    return showDialog<String>(
      context: context,
      builder: (context) {
        final colors = context.appColors;
        return AlertDialog(
          backgroundColor: colors.surface,
          title: Text(
            'Affiliated Link',
            style: TextStyle(color: colors.textPrimary),
          ),
          content: SizedBox(
            width: 360,
            child: ProdPinTextField(
              label: 'Link',
              controller: controller,
              hint: 'https://amzn.to/...',
              keyboardType: TextInputType.url,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(controller.text.trim()),
              child: Text('Save', style: TextStyle(color: colors.accent)),
            ),
          ],
        );
      },
    );
  }
}
