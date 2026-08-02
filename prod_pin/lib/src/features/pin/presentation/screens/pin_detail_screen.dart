import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
                          _ImageCarousel(
                            urls: post.imageUrls,
                            currentIndex: _currentCarouselIndex,
                            onPageChanged: (i) =>
                                setState(() => _currentCarouselIndex = i),
                          ),
                        if (post.overlayText != null &&
                            post.overlayText!.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          _OverlayTextCard(text: post.overlayText!),
                        ],
                        const SizedBox(height: 16),
                        _MetadataRow(post: post),
                        const SizedBox(height: 20),
                        _CopyCard(
                          label: 'Pinterest Title',
                          content: post.pinterestTitle ?? '—',
                          onCopy: post.pinterestTitle != null
                              ? () => _copyToClipboard(
                                  post.pinterestTitle!, 'Title')
                              : null,
                        ),
                        const SizedBox(height: 12),
                        _CopyCard(
                          label: 'Pinterest Description',
                          content: post.pinterestDescription ?? '—',
                          onCopy: post.pinterestDescription != null
                              ? () => _copyToClipboard(
                                  post.pinterestDescription!, 'Description')
                              : null,
                        ),
                        const SizedBox(height: 12),
                        _TagsCard(
                          tags: post.tags,
                          onCopy: post.tags.isNotEmpty
                              ? () => _copyToClipboard(
                                  post.tags.map((t) => '#$t').join(' '), 'Tags')
                              : null,
                        ),
                        const SizedBox(height: 20),
                        _LinksSection(
                          amazonUrl: post.amazonUrl,
                          affiliatedLink: post.affiliatedLink,
                          onVisitProduct: () => _launchUrl(post.amazonUrl),
                          onCopyAffiliated: post.affiliatedLink != null
                              ? () => _copyToClipboard(
                                  post.affiliatedLink!, 'Affiliated link')
                              : null,
                          onAddAffiliated: () async {
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

// ── Image carousel ──────────────────────────────────────────────────────────

class _ImageCarousel extends StatelessWidget {
  final List<String> urls;
  final int currentIndex;
  final void Function(int) onPageChanged;

  const _ImageCarousel({
    required this.urls,
    required this.currentIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CarouselSlider.builder(
            itemCount: urls.length,
            options: CarouselOptions(
              height: 260,
              viewportFraction: 1.0,
              enableInfiniteScroll: urls.length > 1,
              onPageChanged: (i, _) => onPageChanged(i),
            ),
            itemBuilder: (context, index, _) => Image.network(
              urls[index],
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (_, __, ___) => Container(
                color: colors.surfaceElevated,
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: colors.textMuted,
                  size: 36,
                ),
              ),
            ),
          ),
        ),
        if (urls.length > 1) ...[
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              urls.length,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                height: 6,
                width: i == currentIndex ? 18 : 6,
                decoration: BoxDecoration(
                  color: i == currentIndex ? colors.accent : colors.divider,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// ── Overlay text ─────────────────────────────────────────────────────────────

class _OverlayTextCard extends StatelessWidget {
  final String text;

  const _OverlayTextCard({required this.text});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colors.accentMuted, colors.accent],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ── Status / category / dates row ────────────────────────────────────────────

class _MetadataRow extends StatelessWidget {
  final dynamic post;

  const _MetadataRow({required this.post});

  @override
  Widget build(BuildContext context) {
    final textStyles = context.appTextStyles;
    final colors = context.appColors;
    final created = DateFormat.yMMMd().format(post.createdAt);
    final updated = DateFormat.yMMMd().format(post.updatedAt);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            StatusBadge(status: post.status),
            ImageGenBadge(value: post.imageGenerated),
            _CategoryBadge(name: post.category.name),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Text(
            'Created $created · Updated $updated',
            style: textStyles.bodySmall.copyWith(color: colors.textMuted),
          ),
        ),
      ],
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  final String name;

  const _CategoryBadge({required this.name});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colors.surfaceElevated,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.divider),
      ),
      child: Text(
        name,
        style: TextStyle(
          color: colors.textSecondary,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ── Copy card (title / description) ─────────────────────────────────────────

class _CopyCard extends StatelessWidget {
  final String label;
  final String content;
  final VoidCallback? onCopy;

  const _CopyCard({
    required this.label,
    required this.content,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(label, style: textStyles.labelMedium),
              ),
              if (onCopy != null) _CopyIconButton(onTap: onCopy!),
            ],
          ),
          const SizedBox(height: 8),
          Text(content, style: textStyles.bodyMedium),
        ],
      ),
    );
  }
}

// ── Tags card ────────────────────────────────────────────────────────────────

class _TagsCard extends StatelessWidget {
  final List<String> tags;
  final VoidCallback? onCopy;

  const _TagsCard({required this.tags, required this.onCopy});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final textStyles = context.appTextStyles;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('Tags', style: textStyles.labelMedium),
              ),
              if (onCopy != null) _CopyIconButton(onTap: onCopy!),
            ],
          ),
          const SizedBox(height: 10),
          tags.isEmpty
              ? Text('No tags',
                  style: textStyles.bodySmall.copyWith(color: colors.textMuted))
              : Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: tags.map((t) => TagChip(label: t)).toList(),
                ),
        ],
      ),
    );
  }
}

// ── Copy icon button ─────────────────────────────────────────────────────────

class _CopyIconButton extends StatelessWidget {
  final VoidCallback onTap;

  const _CopyIconButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.copy_outlined,
        size: 18,
        color: context.appColors.textSecondary,
      ),
      onPressed: onTap,
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(),
    );
  }
}

// ── Links section ────────────────────────────────────────────────────────────

class _LinksSection extends StatelessWidget {
  final String amazonUrl;
  final String? affiliatedLink;
  final VoidCallback onVisitProduct;
  final VoidCallback? onCopyAffiliated;
  final VoidCallback onAddAffiliated;

  const _LinksSection({
    required this.amazonUrl,
    required this.affiliatedLink,
    required this.onVisitProduct,
    required this.onCopyAffiliated,
    required this.onAddAffiliated,
  });

  @override
  Widget build(BuildContext context) {
    final hasAffiliated = affiliatedLink != null && affiliatedLink!.isNotEmpty;

    return Row(
      children: [
        Expanded(
          child: _CtaButton(
            icon: Icons.open_in_new_rounded,
            label: 'Visit Product',
            onTap: onVisitProduct,
            isPrimary: true,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: hasAffiliated
              ? _CtaButton(
                  icon: Icons.link_rounded,
                  label: 'Copy Link',
                  onTap: onCopyAffiliated!,
                  isPrimary: false,
                )
              : _CtaButton(
                  icon: Icons.add_link_rounded,
                  label: 'Add Link',
                  onTap: onAddAffiliated,
                  isPrimary: false,
                  isDashed: true,
                ),
        ),
      ],
    );
  }
}

class _CtaButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;
  final bool isDashed;

  const _CtaButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isPrimary,
    this.isDashed = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isPrimary ? colors.accent : colors.surface,
          borderRadius: BorderRadius.circular(12),
          border: isDashed
              ? Border.all(color: colors.textMuted, width: 1)
              : isPrimary
                  ? null
                  : Border.all(color: colors.divider),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isPrimary ? Colors.white : colors.textSecondary,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isPrimary ? Colors.white : colors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
