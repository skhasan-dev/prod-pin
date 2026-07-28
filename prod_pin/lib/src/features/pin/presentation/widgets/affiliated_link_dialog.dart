import 'package:flutter/material.dart';

import '../../../../common/widgets/prodpin_text_field.dart';
import '../../../../core/extensions/context_extensions.dart';

Future<String?> showAffiliatedLinkDialog(
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
            onPressed: () => Navigator.of(context).pop(controller.text.trim()),
            child: Text('Save', style: TextStyle(color: colors.accent)),
          ),
        ],
      );
    },
  );
}
