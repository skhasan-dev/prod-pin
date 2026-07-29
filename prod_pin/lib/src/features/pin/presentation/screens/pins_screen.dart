import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prod_pin/src/common/index.dart';
import 'package:provider/provider.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/index.dart' show getIt;
import '../../../../core/navigation/app_routes.dart';
import '../../../../core/utils/enums.dart';
import '../../../category/data/entities/category.dart';
import '../../../category/presentation/view_model/category_view_model.dart';
import '../../data/entities/post.dart';
import '../view_model/pins_view_model.dart';
import '../widgets/affiliated_link_dialog.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../widgets/pin_list_tile.dart';

class PinsScreen extends StatefulWidget {
  final Category category;

  const PinsScreen({super.key, required this.category});

  @override
  State<PinsScreen> createState() => _PinsScreenState();
}

class _PinsScreenState extends State<PinsScreen> {
  late final PinsViewModel pinsViewModel = getIt<PinsViewModel>();
  late final CategoryViewModel categoryViewModel = getIt<CategoryViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await pinsViewModel.getPosts(categoryId: widget.category.id ?? '');
    });
  }

  void _openFilters() {
    final colors = context.appColors;
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => FilterBottomSheet(
        initialStatus: pinsViewModel.statusFilter,
        initialImageGenerated: pinsViewModel.imageGeneratedFilter,
        initialDateFrom: pinsViewModel.dateFrom,
        initialDateTo: pinsViewModel.dateTo,
        onApply: (status, imageGenerated, from, to) {
          pinsViewModel.updateFilters(
            status: status,
            imageGenerated: imageGenerated,
            from: from,
            to: to,
            clearFrom: from == null,
            clearTo: to == null,
          );
          pinsViewModel.getPosts(categoryId: widget.category.id ?? '');
        },
        onClear: () {
          pinsViewModel.clearFilters();
          pinsViewModel.getPosts(categoryId: widget.category.id ?? '');
        },
      ),
    );
  }

  Future<void> _confirmDeleteCategory() async {
    final colors = context.appColors;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colors.surface,
        title: Text(
          'Delete Category',
          style: TextStyle(color: context.appColors.textPrimary),
        ),
        content: Text(
          'This will not delete the pins inside it. Continue?',
          style: TextStyle(color: context.appColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Delete',
              style: TextStyle(color: context.appColors.error),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      final failure =
          await categoryViewModel.deleteCategory(widget.category.id ?? '');
      if (failure == null && mounted) context.pop();
    }
  }

  Future<void> _confirmDeletePost(String postId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: context.appColors.surface,
        title: Text(
          'Delete Pin',
          style: TextStyle(color: context.appColors.textPrimary),
        ),
        content: Text(
          'This action cannot be undone.',
          style: TextStyle(color: context.appColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Delete',
              style: TextStyle(color: context.appColors.error),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      pinsViewModel.deletePost(postId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final category = widget.category;
    final colors = context.appColors;
    final textStyles = context.appTextStyles;

    return ChangeNotifierProvider.value(
      value: pinsViewModel,
      child: Scaffold(
        appBar: ProdPinAppBar(
          title: category.name ?? '',
          showBackButton: true,
          actions: [
            Selector<PinsViewModel, int>(
              selector: (_, vm) => vm.posts.length,
              builder: (_, count, __) {
                final isFull =
                    category.maxPins != null && count >= category.maxPins!;
                return GestureDetector(
                  onTap: isFull
                      ? null
                      : () async {
                          final result = await context.push(
                            AppRoutes.addPin,
                            extra: category,
                          );
                          if (result == true) {
                            await pinsViewModel.getPosts(
                              categoryId: widget.category.id ?? '',
                            );
                          }
                        },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: context.appColors.surface,
                      border: Border.all(
                        color: context.appColors.textSecondary
                            .withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      spacing: 8,
                      children: [
                        const Icon(Icons.add, size: 20),
                        Text(
                          'Create Pin',
                          style: context.appTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.w500,
                            color: context.appColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: Selector<PinsViewModel, bool>(
          selector: (_, vm) => vm.isLoading,
          builder: (_, isLoading, __) {
            if (isLoading) return const Center(child: ProdPinLoader());
            return Selector<PinsViewModel, List<Post>>(
              selector: (_, vm) => vm.posts,
              builder: (_, posts, __) {
                final pinCount = posts.length;
                final isFull =
                    category.maxPins != null && pinCount >= category.maxPins!;
                return Column(
                  children: [
                    if (category.maxPins != null)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Row(
                          spacing: 20,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: LinearProgressIndicator(
                                        value: (pinCount / category.maxPins!)
                                            .clamp(0, 1),
                                        minHeight: 6,
                                        backgroundColor: colors.surfaceElevated,
                                        valueColor: AlwaysStoppedAnimation(
                                          isFull ? colors.accent : colors.ready,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '$pinCount / ${category.maxPins} pins',
                                    style: textStyles.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            Selector<PinsViewModel, bool>(
                              selector: (_, vm) => vm.hasActiveFilters,
                              builder: (_, hasFilters, __) => GestureDetector(
                                onTap: _openFilters,
                                child: Icon(
                                  Icons.filter_list,
                                  color: hasFilters
                                      ? colors.accent
                                      : colors.textPrimary,
                                  size: 28,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (isFull)
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: colors.accent.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: colors.accent.withValues(alpha: 0.4),
                          ),
                        ),
                        child: Text(
                          'Category is full. Delete a pin to add more.',
                          style: TextStyle(color: colors.accent, fontSize: 12),
                        ),
                      ),
                    Expanded(
                      child: posts.isEmpty
                          ? EmptyStateWidget(
                              message: 'No pins yet. Add your first one!',
                              icon: Icons.push_pin_outlined,
                              actionLabel: isFull ? null : 'Add Pin',
                              onAction: isFull
                                  ? null
                                  : () => context.push(
                                        AppRoutes.addPin,
                                        extra: category,
                                      ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              itemCount: posts.length,
                              itemBuilder: (context, index) {
                                final post = posts[index];
                                return PinListTile(
                                  post: post,
                                  onTap: () => context
                                      .push(AppRoutes.pinDetailPath(post.id)),
                                  onEdit: () => context
                                      .push(AppRoutes.editPinPath(post.id)),
                                  onDelete: () => _confirmDeletePost(post.id),
                                  onLinkTap: () async {
                                    final link = await showAffiliatedLinkDialog(
                                      context,
                                      currentLink: post.affiliatedLink,
                                    );
                                    if (link != null) {
                                      pinsViewModel.updatePost(
                                          post.id, {'affiliated_link': link});
                                    }
                                  },
                                  onCycleImageStatus: (nextStatus) =>
                                      pinsViewModel.updatePost(post.id, {
                                    'image_generated': nextStatus.jsonValue,
                                  }),
                                  onStatusChanged: (status) =>
                                      pinsViewModel.updatePost(
                                    post.id,
                                    {
                                      'status': status.jsonValue,
                                    },
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
