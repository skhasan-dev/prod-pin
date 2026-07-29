import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prod_pin/src/common/index.dart';
import 'package:provider/provider.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/index.dart' show getIt;
import '../view_model/edit_pin_view_model.dart';

class EditPinScreen extends StatefulWidget {
  final String id;

  const EditPinScreen({super.key, required this.id});

  @override
  State<EditPinScreen> createState() => _EditPinScreenState();
}

class _EditPinScreenState extends State<EditPinScreen> {
  late final EditPinViewModel editPinViewModel = getIt<EditPinViewModel>();

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _amazonUrlController;
  late final TextEditingController _rawTitleController;
  late final TextEditingController _rawDescriptionController;
  late final TextEditingController _affiliatedLinkController;
  List<String> _imageUrls = [];
  bool _regenerate = false;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    editPinViewModel.getPost(widget.id).then((_) => _initControllers());
  }

  void _initControllers() {
    final post = editPinViewModel.post;
    if (post == null || _initialized) return;
    _amazonUrlController = TextEditingController(text: post.amazonUrl);
    _rawTitleController =
        TextEditingController(text: post.pinterestTitle ?? '');
    _rawDescriptionController =
        TextEditingController(text: post.pinterestDescription ?? '');
    _affiliatedLinkController =
        TextEditingController(text: post.affiliatedLink ?? '');
    _imageUrls = [...post.imageUrls];
    _initialized = true;
    setState(() {});
  }

  @override
  void dispose() {
    if (_initialized) {
      _amazonUrlController.dispose();
      _rawTitleController.dispose();
      _rawDescriptionController.dispose();
      _affiliatedLinkController.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final body = <String, dynamic>{
      'amazon_url': _amazonUrlController.text.trim(),
      if (_affiliatedLinkController.text.trim().isNotEmpty)
        'affiliated_link': _affiliatedLinkController.text.trim(),
      'image_urls': _imageUrls,
      if (_regenerate) ...{
        'regenerate': true,
        'raw_title': _rawTitleController.text.trim(),
        'raw_description': _rawDescriptionController.text.trim(),
      },
    };

    final failure = await editPinViewModel.updatePost(widget.id, body);
    if (failure == null && mounted) context.pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;

    return ChangeNotifierProvider.value(
      value: editPinViewModel,
      child: Selector<EditPinViewModel, bool>(
        selector: (_, vm) => vm.isLoading,
        builder: (_, isLoading, __) {
          if (isLoading || !_initialized) {
            return const Scaffold(body: Center(child: ProdPinLoader()));
          }
          return Scaffold(
            appBar: const ProdPinAppBar(
              title: 'Edit Pin',
              subtitle: 'Update your Pinterest pin',
              showBackButton: true,
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                child: _buildCategoryForm(
                  Form(
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
                                  keyboardType: TextInputType.url,
                                  validator: (v) =>
                                      (v == null || v.trim().isEmpty)
                                          ? 'Amazon URL is required'
                                          : null,
                                ),
                                const SizedBox(height: 16),
                                ProdPinTextField(
                                  label: 'Affiliated Link (optional)',
                                  controller: _affiliatedLinkController,
                                  keyboardType: TextInputType.url,
                                ),
                                const SizedBox(height: 16),
                                ImageUrlListField(
                                  urls: _imageUrls,
                                  onUrlsChanged: (urls) =>
                                      setState(() => _imageUrls = urls),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: colors.surfaceElevated,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Regenerate AI Content',
                                          style: textStyles.titleMedium
                                              .copyWith(fontSize: 14),
                                        ),
                                      ),
                                      Switch(
                                        value: _regenerate,
                                        activeThumbColor: colors.accent,
                                        onChanged: (v) =>
                                            setState(() => _regenerate = v),
                                      ),
                                    ],
                                  ),
                                ),
                                if (_regenerate) ...[
                                  const SizedBox(height: 16),
                                  ProdPinTextField(
                                    label: 'Product Title (for AI)',
                                    controller: _rawTitleController,
                                    validator: (v) => _regenerate &&
                                            (v == null || v.trim().isEmpty)
                                        ? 'Required when regenerating'
                                        : null,
                                  ),
                                  const SizedBox(height: 16),
                                  ProdPinTextField(
                                    label: 'Product Description (for AI)',
                                    controller: _rawDescriptionController,
                                    maxLines: 4,
                                    validator: (v) => _regenerate &&
                                            (v == null || v.trim().isEmpty)
                                        ? 'Required when regenerating'
                                        : null,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ProdPinButton(
                          label: 'Update Pin',
                          isLoading: false,
                          onPressed: _submit,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryForm(Widget child) {
    Widget? form;
    if (context.isDesktop) {
      form = Card(
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

    return form ?? child;
  }
}
