import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prod_pin/src/core/index.dart';
import 'package:prod_pin/src/features/category/index.dart';
import 'package:provider/provider.dart';

import '../../../../common/widgets/prodpin_button.dart';

class EditCategoryScreen extends StatefulWidget {
  final Category category;

  const EditCategoryScreen({super.key, required this.category});

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  final EditCategoryViewModel editCategoryViewModel =
      getIt<EditCategoryViewModel>();

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _coverImageController;
  late final TextEditingController _maxPinsController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _nameController = TextEditingController(text: widget.category.name);
      _coverImageController =
          TextEditingController(text: widget.category.coverImage ?? '');
      _maxPinsController = TextEditingController(
        text: widget.category.maxPins?.toString() ?? '',
      );
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _coverImageController.dispose();
    _maxPinsController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    editCategoryViewModel.update(
      id: widget.category.id ?? '',
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
      value: editCategoryViewModel,
      child: Scaffold(
        appBar: AppBar(title: const Text('Edit Category')),
        body: Selector<EditCategoryViewModel, bool>(
          selector: (_, vm) => vm.isLoading,
          builder: (_, isLoading, __) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
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
                      const SizedBox(height: 16),
                      ProdPinButton(
                        label: 'Update Category',
                        isLoading: isLoading,
                        onPressed: _submit,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
