import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prod_pin/src/common/index.dart' show ProdPinTextField;
import 'package:prod_pin/src/core/index.dart' show ResponsiveContext;
import 'package:url_launcher/url_launcher.dart' as launcher;

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

  static void copyToClipboard(
      BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copied!'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static Future<void> openUrl(BuildContext context, String url) async {
    if (kDebugMode) {
      copyToClipboard(context, url, 'URL');
      log(url, name: 'openUrl');
    }

    final uri = Uri.tryParse(url);
    if (uri == null) return;
    if (!await launcher.launchUrl(uri,
        mode: launcher.LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open link')),
        );
      }
    }
  }

  static Widget wrapDesktopCard(BuildContext context, Widget child) {
    if (!context.isDesktop) return child;
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: context.appColors.surfaceElevated.withValues(alpha: .2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: child,
      ),
    );
  }
}
