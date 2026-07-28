import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prod_pin/src/core/index.dart';
import 'package:prod_pin/src/features/category/index.dart'
    show Category, $CategoryCopyWith;

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
abstract class Post with _$Post {
  const factory Post({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'amazon_url') required String amazonUrl,
    @JsonKey(name: 'affiliated_link') String? affiliatedLink,
    @JsonKey(name: 'image_urls') required List<String> imageUrls,
    required Category category,
    @JsonKey(name: 'pinterest_title') String? pinterestTitle,
    @JsonKey(name: 'pinterest_description') String? pinterestDescription,
    @Default([]) List<String> tags,
    @JsonKey(name: 'overlay_text') String? overlayText,
    required PinStatus status,
    @JsonKey(name: 'image_generated')
    required PinImageGenerationStatus imageGenerated,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
