import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../common/widgets/image_url_list_field.dart';
import '../../../../common/widgets/prodpin_button.dart';
import '../../../../common/widgets/prodpin_text_field.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/index.dart' show getIt;
import '../../../category/data/entities/category.dart';
import '../view_model/add_pin_view_model.dart';

class AddPinScreen extends StatefulWidget {
  final Category category;

  const AddPinScreen({super.key, required this.category});

  @override
  State<AddPinScreen> createState() => _AddPinScreenState();
}

class _AddPinScreenState extends State<AddPinScreen> {
  late final AddPinViewModel addPinViewModel = getIt<AddPinViewModel>();

  final _formKey = GlobalKey<FormState>();
  final _amazonUrlController = TextEditingController();
  final _rawTitleController = TextEditingController();
  final _rawDescriptionController = TextEditingController();
  final _affiliatedLinkController = TextEditingController();
  List<String> _imageUrls = [];

  @override
  void dispose() {
    _amazonUrlController.dispose();
    _rawTitleController.dispose();
    _rawDescriptionController.dispose();
    _affiliatedLinkController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final body = {
      'amazon_url': _amazonUrlController.text.trim(),
      'raw_title': _rawTitleController.text.trim(),
      'raw_description': _rawDescriptionController.text.trim(),
      if (_affiliatedLinkController.text.trim().isNotEmpty)
        'affiliated_link': _affiliatedLinkController.text.trim(),
      'image_urls': _imageUrls,
      'category': widget.category.id,
    };

    final failure = await addPinViewModel.createPost(body);
    if (failure == null && mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;

    return ChangeNotifierProvider.value(
      value: addPinViewModel,
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Pin')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProdPinTextField(
                            label: 'Amazon URL',
                            controller: _amazonUrlController,
                            hint: 'https://amazon.in/dp/...',
                            keyboardType: TextInputType.url,
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'Amazon URL is required'
                                : null,
                          ),
                          const SizedBox(height: 16),
                          ProdPinTextField(
                            label: 'Product Title (for AI)',
                            controller: _rawTitleController,
                            hint: 'Raw product title',
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'Product title is required'
                                : null,
                          ),
                          const SizedBox(height: 16),
                          ProdPinTextField(
                            label: 'Product Description (for AI)',
                            controller: _rawDescriptionController,
                            hint: 'Raw product description',
                            maxLines: 4,
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'Product description is required'
                                : null,
                          ),
                          const SizedBox(height: 16),
                          ProdPinTextField(
                            label: 'Affiliated Link (optional)',
                            controller: _affiliatedLinkController,
                            hint: 'https://amzn.to/...',
                            keyboardType: TextInputType.url,
                          ),
                          const SizedBox(height: 16),
                          ImageUrlListField(
                            urls: _imageUrls,
                            onUrlsChanged: (urls) =>
                                setState(() => _imageUrls = urls),
                          ),
                          const SizedBox(height: 16),
                          Text('Category', style: textStyles.labelMedium),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: colors.surfaceElevated,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              widget.category.name ?? '',
                              style: TextStyle(
                                color: colors.textPrimary,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Selector<AddPinViewModel, bool>(
                    selector: (_, vm) => vm.isLoading,
                    builder: (_, isLoading, __) => ProdPinButton(
                      label: 'Create Pin & Generate',
                      isLoading: isLoading,
                      onPressed: _submit,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
