import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prod_pin/src/common/index.dart';
import 'package:prod_pin/src/core/index.dart';
import 'package:prod_pin/src/features/category/index.dart';
import 'package:provider/provider.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final AddCategoryViewModel addCategoryViewModel =
      getIt<AddCategoryViewModel>();

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _coverImageController = TextEditingController();
  final _maxPinsController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _coverImageController.dispose();
    _maxPinsController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    addCategoryViewModel.create(
      name: _nameController.text.trim(),
      coverImage: _coverImageController.text.trim().isEmpty
          ? null
          : _coverImageController.text.trim(),
      maxPins: int.tryParse(_maxPinsController.text.trim()),
    );

    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: addCategoryViewModel,
      child: Scaffold(
        appBar: const ProdPinAppBar(
          title: 'Add Category',
          subtitle: 'Create a new Pinterest category',
        ),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: _buildCategoryForm(
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: CategoryFormFields(
                              nameController: _nameController,
                              coverImageController: _coverImageController,
                              maxPinsController: _maxPinsController,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ProdPinButton(
                            label: 'Create Category',
                            isLoading: _isSaving,
                            onPressed: _submit,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
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
