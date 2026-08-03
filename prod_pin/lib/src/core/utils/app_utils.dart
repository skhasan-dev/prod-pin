import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:prod_pin/src/common/index.dart'
    show ProdPinTextField, ProdPinButton;
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

  static void copyToClipboard(BuildContext context, String text, String label) {
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

  static Future<void> showItemSheet<T extends Enum>(
    BuildContext context, {
    required T? selectedValue,
    required List<T> values,
    required void Function(T) onApplyPressed,
    required String Function(T) labelBuilder,
    String? label,
    Widget? description,
    String? positiveActionLabel,
    String? negativeActionLabel,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();

    final selectedValueNotifier = ValueNotifier<T?>(selectedValue);

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.appColors.surface,
      showDragHandle: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7,
              minHeight: MediaQuery.of(context).size.height * 0.25,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                right: 20,
                left: 20,
                bottom: 32,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label ?? 'Items',
                    style: context.appTextStyles.titleMedium,
                  ),
                  const SizedBox(height: 24),
                  if (description != null) ...[
                    description,
                    const SizedBox(height: 24),
                  ],
                  Divider(color: context.appColors.surfaceElevated),
                  Flexible(
                    child: ValueListenableBuilder(
                      valueListenable: selectedValueNotifier,
                      builder: (context, selectedValue, child) {
                        return RadioGroup<T>(
                          onChanged: (newRadioValue) {
                            selectedValueNotifier.value = newRadioValue;
                          },
                          groupValue: selectedValueNotifier.value,
                          child: ListView.separated(
                            padding: EdgeInsets.zero,
                            itemBuilder: (_, index) {
                              final value = values[index];

                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                title: Text(
                                  labelBuilder.call(value),
                                  style: context.appTextStyles.bodyMedium,
                                ),
                                onTap: () {
                                  selectedValueNotifier.value = value;
                                },
                                trailing: Radio<T>(
                                  value: value,
                                  activeColor: context.appColors.accent,
                                  side: BorderSide(
                                    color: context.appColors.textMuted,
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (_, __) => Divider(
                              color: context.appColors.surfaceElevated,
                            ),
                            itemCount: values.length,
                            shrinkWrap: true,
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(color: context.appColors.surfaceElevated),
                  const SizedBox(height: 24),
                  Row(
                    spacing: 8,
                    children: [
                      Expanded(
                        child: ProdPinButton(
                          onPressed: () => context.pop(),
                          isSecondary: true,
                          label: negativeActionLabel ?? 'CANCEL',
                        ),
                      ),
                      Expanded(
                        child: ProdPinButton(
                          onPressed: () {
                            final value = selectedValueNotifier.value;
                            if (value != null) {
                              onApplyPressed.call(value);
                              context.pop();
                            }
                          },
                          label: positiveActionLabel ?? 'APPLY',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
