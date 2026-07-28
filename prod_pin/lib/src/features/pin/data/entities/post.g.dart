// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Post _$PostFromJson(Map<String, dynamic> json) => _Post(
      id: json['_id'] as String,
      amazonUrl: json['amazon_url'] as String,
      affiliatedLink: json['affiliated_link'] as String?,
      imageUrls: (json['image_urls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      category: Category.fromJson(json['category'] as Map<String, dynamic>),
      pinterestTitle: json['pinterest_title'] as String?,
      pinterestDescription: json['pinterest_description'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      overlayText: json['overlay_text'] as String?,
      status: $enumDecode(_$PinStatusEnumMap, json['status']),
      imageGenerated: $enumDecode(
          _$PinImageGenerationStatusEnumMap, json['image_generated']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$PostToJson(_Post instance) => <String, dynamic>{
      '_id': instance.id,
      'amazon_url': instance.amazonUrl,
      'affiliated_link': instance.affiliatedLink,
      'image_urls': instance.imageUrls,
      'category': instance.category,
      'pinterest_title': instance.pinterestTitle,
      'pinterest_description': instance.pinterestDescription,
      'tags': instance.tags,
      'overlay_text': instance.overlayText,
      'status': _$PinStatusEnumMap[instance.status]!,
      'image_generated':
          _$PinImageGenerationStatusEnumMap[instance.imageGenerated]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$PinStatusEnumMap = {
  PinStatus.draft: 'draft',
  PinStatus.ready: 'ready',
  PinStatus.published: 'published',
};

const _$PinImageGenerationStatusEnumMap = {
  PinImageGenerationStatus.yetToGenerate: 'yet_to_generate',
  PinImageGenerationStatus.partiallyGenerated: 'partially_generated',
  PinImageGenerationStatus.generated: 'generated',
};
