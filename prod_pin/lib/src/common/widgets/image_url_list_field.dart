import 'package:flutter/material.dart';

import '../../core/extensions/context_extensions.dart';
import '../../core/extensions/string_extensions.dart';

class ImageUrlListField extends StatefulWidget {
  final List<String> urls;
  final ValueChanged<List<String>> onUrlsChanged;

  const ImageUrlListField({
    super.key,
    required this.urls,
    required this.onUrlsChanged,
  });

  @override
  State<ImageUrlListField> createState() => _ImageUrlListFieldState();
}

class _ImageUrlListFieldState extends State<ImageUrlListField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addUrl() {
    final value = _controller.text.trim();
    if (value.isEmpty) return;
    final updated = [...widget.urls, value];
    widget.onUrlsChanged(updated);
    _controller.clear();
  }

  void _removeUrl(String url) {
    widget.onUrlsChanged(widget.urls.where((u) => u != url).toList());
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Image URLs', style: textStyles.labelMedium),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                onSubmitted: (_) => _addUrl(),
                style: TextStyle(color: colors.textPrimary, fontSize: 14),
                decoration: const InputDecoration(
                  hintText: 'https://...',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: _addUrl,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.accent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: const Text('Add'),
              ),
            ),
          ],
        ),
        if (widget.urls.isNotEmpty) ...[
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.urls
                .map(
                  (url) => Chip(
                    label: Text(
                      url.truncate(28),
                      style: textStyles.bodySmall,
                    ),
                    backgroundColor: colors.surfaceElevated,
                    deleteIcon: Icon(
                      Icons.close,
                      size: 16,
                      color: colors.textSecondary,
                    ),
                    onDeleted: () => _removeUrl(url),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide.none,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ],
    );
  }
}
