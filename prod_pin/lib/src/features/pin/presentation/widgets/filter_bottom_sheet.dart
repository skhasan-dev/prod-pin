import 'package:flutter/material.dart';

import '../../../../common/widgets/prodpin_button.dart';
import '../../../../config/app_constants.dart';
import '../../../../core/extensions/context_extensions.dart';

class FilterBottomSheet extends StatefulWidget {
  final List<String> initialStatus;
  final List<String> initialImageGenerated;
  final DateTime? initialDateFrom;
  final DateTime? initialDateTo;
  final void Function(
    List<String> status,
    List<String> imageGenerated,
    DateTime? from,
    DateTime? to,
  ) onApply;
  final VoidCallback onClear;

  const FilterBottomSheet({
    super.key,
    required this.initialStatus,
    required this.initialImageGenerated,
    required this.initialDateFrom,
    required this.initialDateTo,
    required this.onApply,
    required this.onClear,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late final List<String> _status = [...widget.initialStatus];
  late final List<String> _imageGenerated = [...widget.initialImageGenerated];
  DateTime? _from;
  DateTime? _to;

  @override
  void initState() {
    super.initState();
    _from = widget.initialDateFrom;
    _to = widget.initialDateTo;
  }

  Future<void> _pickDate({required bool isFrom}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: (isFrom ? _from : _to) ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          _from = picked;
        } else {
          _to = picked;
        }
      });
    }
  }

  Widget _sectionTitle(String text, BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(text, style: context.appTextStyles.titleMedium),
      );

  Widget _toggleChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    final colors = context.appColors;
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      backgroundColor: colors.surfaceElevated,
      selectedColor: colors.accent.withValues(alpha: 0.25),
      checkmarkColor: colors.accent,
      labelStyle: TextStyle(
        color: selected ? colors.accent : colors.textSecondary,
        fontSize: 13,
      ),
      side: BorderSide(
        color: selected ? colors.accent : colors.divider,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Filters', style: textStyles.headlineMedium),
              const SizedBox(height: 20),
              _sectionTitle('Status', context),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: PostStatus.all
                    .map(
                      (s) => _toggleChip(
                        label: PostStatus.label(s),
                        selected: _status.contains(s),
                        onTap: () => setState(() {
                          _status.contains(s)
                              ? _status.remove(s)
                              : _status.add(s);
                        }),
                        context: context,
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 20),
              _sectionTitle('Image Generated', context),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ImageGenerated.all
                    .map(
                      (s) => _toggleChip(
                        label: ImageGenerated.label(s),
                        selected: _imageGenerated.contains(s),
                        onTap: () => setState(() {
                          _imageGenerated.contains(s)
                              ? _imageGenerated.remove(s)
                              : _imageGenerated.add(s);
                        }),
                        context: context,
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 20),
              _sectionTitle('Date Range', context),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _pickDate(isFrom: true),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: colors.divider),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        _from == null
                            ? 'From'
                            : '${_from!.year}-${_from!.month.toString().padLeft(2, '0')}-${_from!.day.toString().padLeft(2, '0')}',
                        style: TextStyle(color: colors.textPrimary),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _pickDate(isFrom: false),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: colors.divider),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        _to == null
                            ? 'To'
                            : '${_to!.year}-${_to!.month.toString().padLeft(2, '0')}-${_to!.day.toString().padLeft(2, '0')}',
                        style: TextStyle(color: colors.textPrimary),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: ProdPinButton(
                      label: 'Clear Filters',
                      isSecondary: true,
                      onPressed: () {
                        widget.onClear();
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ProdPinButton(
                      label: 'Apply Filters',
                      onPressed: () {
                        widget.onApply(_status, _imageGenerated, _from, _to);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
