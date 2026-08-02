import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:prod_pin/src/common/index.dart';
import 'package:prod_pin/src/core/index.dart';
import 'package:prod_pin/src/features/pin/index.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
    pinViewModel.getPost(widget.id);
  }

  void _copyToClipboard(String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copied!'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (kDebugMode) {
      _copyToClipboard(url, 'Copied URL');
      log(url, name: 'Pinterest URL');
    }

    final uri = Uri.tryParse(url);
    if (uri == null) return;
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open link')),
        );
      }
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
                        PinMetadataRow(post: post),
                        const SizedBox(height: 20),
                        CopyCard(
                          label: 'Pinterest Title',
                          content: post.pinterestTitle ?? '—',
                          onCopy: post.pinterestTitle != null
                              ? () => _copyToClipboard(
                                  post.pinterestTitle!, 'Title')
                              : null,
                        ),
                        const SizedBox(height: 12),
                        CopyCard(
                          label: 'Pinterest Description',
                          content: post.pinterestDescription ?? '—',
                          onCopy: post.pinterestDescription != null
                              ? () => _copyToClipboard(
                                  post.pinterestDescription!, 'Description')
                              : null,
                        ),
                        const SizedBox(height: 12),
                        PinTagsCard(
                          tags: post.tags,
                          onCopy: post.tags.isNotEmpty
                              ? () => _copyToClipboard(
                                  post.tags.map((t) => '#$t').join(' '), 'Tags')
                              : null,
                        ),
                        const SizedBox(height: 20),
                        PinLinksSection(
                          amazonUrl: post.amazonUrl,
                          affiliatedLink: post.affiliatedLink,
                          onVisitProduct: () => _launchUrl(post.amazonUrl),
                          onCopyAffiliated: post.affiliatedLink != null
                              ? () => _copyToClipboard(
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
                            onTap: () =>
                                _launchUrl(_buildPinterestUrl(post).toString()),
                          ),
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
