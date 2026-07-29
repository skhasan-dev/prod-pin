import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prod_pin/src/common/index.dart';
import 'package:prod_pin/src/core/index.dart';
import 'package:prod_pin/src/features/index.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CategoryViewModel categoryViewModel = getIt<CategoryViewModel>();

  @override
  void initState() {
    super.initState();
    categoryViewModel.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: categoryViewModel,
      child: Scaffold(
        appBar: ProdPinAppBar(
          title: 'ProdPin',
          titleTextStyle: context.appTextStyles.headlineMedium.copyWith(
            fontWeight: FontWeight.w700,
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                final result = await context.push(AppRoutes.addCategory);
                if (result == true) {
                  categoryViewModel.getCategories();
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: context.appColors.surface,
                  border: Border.all(
                    color:
                        context.appColors.textSecondary.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  spacing: 8,
                  children: [
                    const Icon(Icons.add, size: 20),
                    Text(
                      'Add Category',
                      style: context.appTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w500,
                        color: context.appColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Selector<CategoryViewModel, bool>(
          selector: (_, vm) => vm.isLoading,
          builder: (_, isLoading, __) {
            if (isLoading) return const CircularProgressIndicator();
            return Selector<CategoryViewModel, List<Category>>(
              selector: (_, vm) => vm.categories,
              builder: (_, categories, __) {
                return categories.isEmpty
                    ? EmptyStateWidget(
                        message: 'No categories yet. Add your first one!',
                        icon: Icons.category_outlined,
                        actionLabel: 'Add Category',
                        onAction: () async {
                          final result =
                              await context.push(AppRoutes.addCategory);
                          if (result == true) {
                            categoryViewModel.getCategories();
                          }
                        },
                      )
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          final columns = context.categoryGridColumns;
                          if (columns == 1) {
                            return ListView.separated(
                              padding: const EdgeInsets.all(16),
                              itemCount: categories.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 14),
                              itemBuilder: (context, index) {
                                final category = categories[index];
                                return CategoryCard(
                                  category: category,
                                  isFull: categoryViewModel
                                      .isCategoryFull(category),
                                  onTap: () => context.push(
                                    AppRoutes.categoryDetail,
                                    extra: category,
                                  ),
                                );
                              },
                            );
                          }
                          return GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: columns,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 1.285,
                            ),
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              return CategoryCard(
                                category: category,
                                isFull:
                                    categoryViewModel.isCategoryFull(category),
                                onTap: () => context.push(
                                  AppRoutes.categoryDetail,
                                  extra: category,
                                ),
                                onEdit: () async {
                                  final result = await context.push(
                                    AppRoutes.editCategoryPath(
                                      category.id ?? '',
                                    ),
                                    extra: category,
                                  );
                                  log('result: $result', name: 'After Edit');
                                  if (result == true) {
                                    categoryViewModel.getCategories();
                                  }
                                },
                              );
                            },
                          );
                        },
                      );
              },
            );
          },
        ),
      ),
    );
  }
}
