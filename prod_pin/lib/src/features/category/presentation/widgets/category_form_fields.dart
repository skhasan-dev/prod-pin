import 'package:flutter/material.dart';

import '../../../../common/widgets/prodpin_text_field.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';

class CategoryFormFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController coverImageController;
  final TextEditingController maxPinsController;

  const CategoryFormFields({
    super.key,
    required this.nameController,
    required this.coverImageController,
    required this.maxPinsController,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProdPinTextField(
          label: 'Title',
          controller: nameController,
          hint: 'e.g. Home Decor',
          validator: (v) =>
              (v == null || v.trim().isEmpty) ? 'Title is required' : null,
        ),
        const SizedBox(height: 16),
        ProdPinTextField(
          label: 'Cover Image URL (optional)',
          controller: coverImageController,
          hint: 'https://...',
          keyboardType: TextInputType.url,
        ),
        AnimatedBuilder(
          animation: coverImageController,
          builder: (context, _) {
            final url = coverImageController.text.trim();
            if (!url.isValidUrl) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  url,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 140,
                    color: colors.surfaceElevated,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.broken_image_outlined,
                      color: colors.textMuted,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        ProdPinTextField(
          label: 'Max Pins (optional)',
          controller: maxPinsController,
          hint: 'e.g. 20',
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
