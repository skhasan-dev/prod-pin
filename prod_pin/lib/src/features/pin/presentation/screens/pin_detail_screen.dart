import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:prod_pin/src/common/index.dart';
import 'package:prod_pin/src/core/index.dart';
import 'package:prod_pin/src/features/pin/index.dart';
import 'package:provider/provider.dart';

class PinDetailScreen extends StatefulWidget {
  final String id;

  const PinDetailScreen({super.key, required this.id});

  @override
  State<PinDetailScreen> createState() => _PinDetailScreenState();
}

class _PinDetailScreenState extends State<PinDetailScreen> {
  late final PinDetailViewModel pinViewModel = getIt<PinDetailViewModel>();
  final _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    pinViewModel.getPost(widget.id);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _sectionHeader(String text, BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(text, style: context.appTextStyles.labelMedium),
      );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: pinViewModel,
      child: Selector<PinDetailViewModel, bool>(
        selector: (_, vm) => vm.isLoading,
        builder: (_, isLoading, __) {
          if (isLoading) {
            return const Scaffold(body: Center(child: ProdPinLoader()));
          }
          return Selector<PinDetailViewModel, dynamic>(
            selector: (_, vm) => vm.post,
            builder: (context, post, __) {
              if (post == null) {
                return const Scaffold(body: Center(child: ProdPinLoader()));
              }
              final colors = context.appColors;
              final textStyles = context.appTextStyles;

              return Scaffold(
                appBar: ProdPinAppBar(
                  title: post.pinterestTitle ?? 'Pin',
                  showBackButton: true,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () =>
                          context.push(AppRoutes.editPinPath(post.id)),
                    ),
                  ],
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (post.imageUrls.isNotEmpty) ...[
                          SizedBox(
                            height: 260,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: PageView.builder(
                                controller: _pageController,
                                itemCount: post.imageUrls.length,
                                onPageChanged: (i) =>
                                    setState(() => _currentPage = i),
                                itemBuilder: (context, index) => Image.network(
                                  post.imageUrls[index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  errorBuilder: (_, __, ___) => Container(
                                    color: colors.surfaceElevated,
                                    child: Icon(
                                      Icons.image_not_supported_outlined,
                                      color: colors.textMuted,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (post.imageUrls.length > 1) ...[
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                post.imageUrls.length,
                                (i) => AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  height: 6,
                                  width: i == _currentPage ? 18 : 6,
                                  decoration: BoxDecoration(
                                    color: i == _currentPage
                                        ? colors.accent
                                        : colors.divider,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                          ],
                          const SizedBox(height: 20),
                        ],
                        if (post.overlayText != null &&
                            post.overlayText!.isNotEmpty) ...[
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 36, horizontal: 20),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  colors.accentMuted,
                                  colors.accent,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              post.overlayText!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                        Row(
                          children: [
                            StatusBadge(status: post.status),
                            const SizedBox(width: 10),
                            ImageGenBadge(value: post.imageGenerated),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _sectionHeader('Pinterest Title', context),
                        Text(
                          post.pinterestTitle ?? '—',
                          style: textStyles.titleMedium,
                        ),
                        const SizedBox(height: 20),
                        _sectionHeader('Pinterest Description', context),
                        Text(
                          post.pinterestDescription ?? '—',
                          style: textStyles.bodyMedium,
                        ),
                        const SizedBox(height: 20),
                        _sectionHeader('Tags', context),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            ...post.tags.map((t) => TagChip(label: t)),
                          ],
                        ),
                        const SizedBox(height: 24),
                        _sectionHeader('Links', context),
                        _LinkRow(label: 'Amazon URL', url: post.amazonUrl),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _LinkRow(
                                label: 'Affiliated Link',
                                url: post.affiliatedLink ?? 'Not set',
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.edit_outlined,
                                size: 18,
                                color: colors.textSecondary,
                              ),
                              onPressed: () async {
                                final link = await showAffiliatedLinkDialog(
                                  context,
                                  currentLink: post.affiliatedLink,
                                );
                                if (link != null) {
                                  pinViewModel.updatePost(
                                      post.id, {'affiliated_link': link});
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        _sectionHeader('Category', context),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: colors.surfaceElevated,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            post.category.name,
                            style: textStyles.bodyMedium,
                          ),
                        ),
                        const SizedBox(height: 24),
                        _sectionHeader('Dates', context),
                        Text(
                          'Created: ${DateFormat.yMMMd().add_jm().format(post.createdAt)}',
                          style: textStyles.bodySmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Updated: ${DateFormat.yMMMd().add_jm().format(post.updatedAt)}',
                          style: textStyles.bodySmall,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _LinkRow extends StatelessWidget {
  final String label;
  final String url;

  const _LinkRow({required this.label, required this.url});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.appTextStyles.bodySmall),
        const SizedBox(height: 2),
        Text(
          url,
          style: TextStyle(color: context.appColors.accent, fontSize: 13),
        ),
      ],
    );
  }
}
