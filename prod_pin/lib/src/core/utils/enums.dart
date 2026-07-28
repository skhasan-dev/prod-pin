import 'package:freezed_annotation/freezed_annotation.dart';

enum PinStatus {
  @JsonValue('draft')
  draft(label: 'Draft'),
  @JsonValue('ready')
  ready(label: 'Ready'),
  @JsonValue('published')
  published(label: 'Published');

  const PinStatus({required this.label});

  final String label;
}

enum PinImageGenerationStatus {
  @JsonValue('yet_to_generate')
  yetToGenerate(label: 'Yet to Generate'),
  @JsonValue('partially_generated')
  partiallyGenerated(label: 'Partially Generated'),
  @JsonValue('generated')
  generated(label: 'Generated');

  const PinImageGenerationStatus({required this.label});

  final String label;
}

extension PinStatusX on PinStatus {
  String get jsonValue => switch (this) {
        PinStatus.draft => 'draft',
        PinStatus.ready => 'ready',
        PinStatus.published => 'published',
      };
}

extension PinImageGenerationStatusX on PinImageGenerationStatus {
  String get jsonValue => switch (this) {
        PinImageGenerationStatus.yetToGenerate => 'yet_to_generate',
        PinImageGenerationStatus.partiallyGenerated => 'partially_generated',
        PinImageGenerationStatus.generated => 'generated',
      };

  PinImageGenerationStatus get next {
    final all = PinImageGenerationStatus.values;
    return all[(all.indexOf(this) + 1) % all.length];
  }
}
