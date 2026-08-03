import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  int _currentCarouselIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final failure = await pinViewModel.getPost(widget.id);
      failure?.showError(context);
    });
  }

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
          return Selector<PinDetailViewModel, Post?>(
            selector: (_, vm) => vm.post,
            builder: (context, post, __) {
              if (post == null) {
                return const Scaffold(body: Center(child: ProdPinLoader()));
              }

              return PopScope(
                canPop: false,
                onPopInvokedWithResult: (didPop, res) {
                  if (didPop) return;
                  context.pop(true);
                },
                child: Scaffold(
                  appBar: ProdPinAppBar(
                    title: post.pinterestTitle ?? 'Pin',
                    showBackButton: true,
                    actions: [
                      if (post.status != PinStatus.published)
                        IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          onPressed: () =>
                              context.push(AppRoutes.editPinPath(post.id)),
                        ),
                    ],
                  ),
                  body: SafeArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (post.imageUrls.isNotEmpty)
                            PinImageCarousel(
                              urls: post.imageUrls,
                              currentIndex: _currentCarouselIndex,
                              onPageChanged: (i) =>
                                  setState(() => _currentCarouselIndex = i),
                            ),
                          if (post.overlayText != null &&
                              post.overlayText!.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            PinOverlayTextCard(text: post.overlayText!),
                          ],
                          const SizedBox(height: 16),
                          PinMetadataRow(
                            post: post,
                            onImageStatus: (status) async {
                              final failure = await pinViewModel.updatePost(
                                post.id,
                                {'image_generated': status.jsonValue},
                              );

                              failure?.showError(context);
                            },
                            onPublishStatus: (status) async {
                              final failure = await pinViewModel.updatePost(
                                post.id,
                                {'status': status.jsonValue},
                              );
                              failure?.showError(context);
                            },
                          ),
                          const SizedBox(height: 20),
                          CopyCard(
                            label: 'Pinterest Title',
                            content: post.pinterestTitle ?? '—',
                            onCopy: post.pinterestTitle != null
                                ? () => AppUtils.copyToClipboard(
                                    context, post.pinterestTitle!, 'Title')
                                : null,
                          ),
                          const SizedBox(height: 12),
                          CopyCard(
                            label: 'Pinterest Description',
                            content: post.pinterestDescription ?? '—',
                            onCopy: post.pinterestDescription != null
                                ? () => AppUtils.copyToClipboard(context,
                                    post.pinterestDescription!, 'Description')
                                : null,
                          ),
                          const SizedBox(height: 12),
                          PinTagsCard(
                            tags: post.tags,
                            onCopy: post.tags.isNotEmpty
                                ? () => AppUtils.copyToClipboard(
                                    context,
                                    post.tags.map((t) => '#$t').join(' '),
                                    'Tags')
                                : null,
                          ),
                          const SizedBox(height: 20),
                          PinLinksSection(
                            amazonUrl: post.amazonUrl,
                            affiliatedLink: post.affiliatedLink,
                            onVisitProduct: () =>
                                AppUtils.openUrl(context, post.amazonUrl),
                            onCopyAffiliated: post.affiliatedLink != null
                                ? () => AppUtils.copyToClipboard(context,
                                    post.affiliatedLink!, 'Affiliated link')
                                : null,
                            onAddAffiliated: () async {
                              final link =
                                  await AppUtils.showAffiliatedLinkDialog(
                                context,
                                currentLink: post.affiliatedLink,
                              );
                              if (link != null) {
                                pinViewModel.updatePost(
                                    post.id, {'affiliated_link': link});
                              }
                            },
                          ),
                          const SizedBox(height: 12),
                          if (post.imageGenerated ==
                              PinImageGenerationStatus.generated)
                            PinterestButton(
                              onTap: () => AppUtils.openUrl(
                                  context, _buildPinterestUrl(post).toString()),
                            ),
                        ],
                      ),
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

Uri _buildPinterestUrl(Post post) {
  final destination = post.affiliatedLink ?? post.amazonUrl;
  final allTags = [...post.tags, 'affiliated'];
  final parts = [
    post.pinterestDescription ?? '',
    allTags.map((t) => '#$t').join(' '),
  ].where((s) => s.isNotEmpty).toList();
  final description = parts.join('\n\n');

  return Uri.https('www.pinterest.com', '/pin/create/button/', {
    if (post.imageUrls.isNotEmpty) 'media': post.imageUrls.first,
    'url': destination,
    if (description.isNotEmpty) 'description': description,
  });
}
