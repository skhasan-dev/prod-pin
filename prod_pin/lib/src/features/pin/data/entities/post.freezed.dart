// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Post {
  @JsonKey(name: '_id')
  String get id;
  @JsonKey(name: 'amazon_url')
  String get amazonUrl;
  @JsonKey(name: 'affiliated_link')
  String? get affiliatedLink;
  @JsonKey(name: 'image_urls')
  List<String> get imageUrls;
  Category get category;
  @JsonKey(name: 'pinterest_title')
  String? get pinterestTitle;
  @JsonKey(name: 'pinterest_description')
  String? get pinterestDescription;
  List<String> get tags;
  @JsonKey(name: 'overlay_text')
  String? get overlayText;
  PinStatus get status;
  @JsonKey(name: 'image_generated')
  PinImageGenerationStatus get imageGenerated;
  DateTime get createdAt;
  DateTime get updatedAt;

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PostCopyWith<Post> get copyWith =>
      _$PostCopyWithImpl<Post>(this as Post, _$identity);

  /// Serializes this Post to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Post &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amazonUrl, amazonUrl) ||
                other.amazonUrl == amazonUrl) &&
            (identical(other.affiliatedLink, affiliatedLink) ||
                other.affiliatedLink == affiliatedLink) &&
            const DeepCollectionEquality().equals(other.imageUrls, imageUrls) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.pinterestTitle, pinterestTitle) ||
                other.pinterestTitle == pinterestTitle) &&
            (identical(other.pinterestDescription, pinterestDescription) ||
                other.pinterestDescription == pinterestDescription) &&
            const DeepCollectionEquality().equals(other.tags, tags) &&
            (identical(other.overlayText, overlayText) ||
                other.overlayText == overlayText) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.imageGenerated, imageGenerated) ||
                other.imageGenerated == imageGenerated) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      amazonUrl,
      affiliatedLink,
      const DeepCollectionEquality().hash(imageUrls),
      category,
      pinterestTitle,
      pinterestDescription,
      const DeepCollectionEquality().hash(tags),
      overlayText,
      status,
      imageGenerated,
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'Post(id: $id, amazonUrl: $amazonUrl, affiliatedLink: $affiliatedLink, imageUrls: $imageUrls, category: $category, pinterestTitle: $pinterestTitle, pinterestDescription: $pinterestDescription, tags: $tags, overlayText: $overlayText, status: $status, imageGenerated: $imageGenerated, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $PostCopyWith<$Res> {
  factory $PostCopyWith(Post value, $Res Function(Post) _then) =
      _$PostCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      @JsonKey(name: 'amazon_url') String amazonUrl,
      @JsonKey(name: 'affiliated_link') String? affiliatedLink,
      @JsonKey(name: 'image_urls') List<String> imageUrls,
      Category category,
      @JsonKey(name: 'pinterest_title') String? pinterestTitle,
      @JsonKey(name: 'pinterest_description') String? pinterestDescription,
      List<String> tags,
      @JsonKey(name: 'overlay_text') String? overlayText,
      PinStatus status,
      @JsonKey(name: 'image_generated') PinImageGenerationStatus imageGenerated,
      DateTime createdAt,
      DateTime updatedAt});

  $CategoryCopyWith<$Res> get category;
}

/// @nodoc
class _$PostCopyWithImpl<$Res> implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._self, this._then);

  final Post _self;
  final $Res Function(Post) _then;

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amazonUrl = null,
    Object? affiliatedLink = freezed,
    Object? imageUrls = null,
    Object? category = null,
    Object? pinterestTitle = freezed,
    Object? pinterestDescription = freezed,
    Object? tags = null,
    Object? overlayText = freezed,
    Object? status = null,
    Object? imageGenerated = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amazonUrl: null == amazonUrl
          ? _self.amazonUrl
          : amazonUrl // ignore: cast_nullable_to_non_nullable
              as String,
      affiliatedLink: freezed == affiliatedLink
          ? _self.affiliatedLink
          : affiliatedLink // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrls: null == imageUrls
          ? _self.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category,
      pinterestTitle: freezed == pinterestTitle
          ? _self.pinterestTitle
          : pinterestTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      pinterestDescription: freezed == pinterestDescription
          ? _self.pinterestDescription
          : pinterestDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _self.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      overlayText: freezed == overlayText
          ? _self.overlayText
          : overlayText // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as PinStatus,
      imageGenerated: null == imageGenerated
          ? _self.imageGenerated
          : imageGenerated // ignore: cast_nullable_to_non_nullable
              as PinImageGenerationStatus,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategoryCopyWith<$Res> get category {
    return $CategoryCopyWith<$Res>(_self.category, (value) {
      return _then(_self.copyWith(category: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Post].
extension PostPatterns on Post {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Post value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Post() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Post value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Post():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Post value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Post() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: '_id') String id,
            @JsonKey(name: 'amazon_url') String amazonUrl,
            @JsonKey(name: 'affiliated_link') String? affiliatedLink,
            @JsonKey(name: 'image_urls') List<String> imageUrls,
            Category category,
            @JsonKey(name: 'pinterest_title') String? pinterestTitle,
            @JsonKey(name: 'pinterest_description')
            String? pinterestDescription,
            List<String> tags,
            @JsonKey(name: 'overlay_text') String? overlayText,
            PinStatus status,
            @JsonKey(name: 'image_generated')
            PinImageGenerationStatus imageGenerated,
            DateTime createdAt,
            DateTime updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Post() when $default != null:
        return $default(
            _that.id,
            _that.amazonUrl,
            _that.affiliatedLink,
            _that.imageUrls,
            _that.category,
            _that.pinterestTitle,
            _that.pinterestDescription,
            _that.tags,
            _that.overlayText,
            _that.status,
            _that.imageGenerated,
            _that.createdAt,
            _that.updatedAt);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: '_id') String id,
            @JsonKey(name: 'amazon_url') String amazonUrl,
            @JsonKey(name: 'affiliated_link') String? affiliatedLink,
            @JsonKey(name: 'image_urls') List<String> imageUrls,
            Category category,
            @JsonKey(name: 'pinterest_title') String? pinterestTitle,
            @JsonKey(name: 'pinterest_description')
            String? pinterestDescription,
            List<String> tags,
            @JsonKey(name: 'overlay_text') String? overlayText,
            PinStatus status,
            @JsonKey(name: 'image_generated')
            PinImageGenerationStatus imageGenerated,
            DateTime createdAt,
            DateTime updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Post():
        return $default(
            _that.id,
            _that.amazonUrl,
            _that.affiliatedLink,
            _that.imageUrls,
            _that.category,
            _that.pinterestTitle,
            _that.pinterestDescription,
            _that.tags,
            _that.overlayText,
            _that.status,
            _that.imageGenerated,
            _that.createdAt,
            _that.updatedAt);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            @JsonKey(name: '_id') String id,
            @JsonKey(name: 'amazon_url') String amazonUrl,
            @JsonKey(name: 'affiliated_link') String? affiliatedLink,
            @JsonKey(name: 'image_urls') List<String> imageUrls,
            Category category,
            @JsonKey(name: 'pinterest_title') String? pinterestTitle,
            @JsonKey(name: 'pinterest_description')
            String? pinterestDescription,
            List<String> tags,
            @JsonKey(name: 'overlay_text') String? overlayText,
            PinStatus status,
            @JsonKey(name: 'image_generated')
            PinImageGenerationStatus imageGenerated,
            DateTime createdAt,
            DateTime updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Post() when $default != null:
        return $default(
            _that.id,
            _that.amazonUrl,
            _that.affiliatedLink,
            _that.imageUrls,
            _that.category,
            _that.pinterestTitle,
            _that.pinterestDescription,
            _that.tags,
            _that.overlayText,
            _that.status,
            _that.imageGenerated,
            _that.createdAt,
            _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Post implements Post {
  const _Post(
      {@JsonKey(name: '_id') required this.id,
      @JsonKey(name: 'amazon_url') required this.amazonUrl,
      @JsonKey(name: 'affiliated_link') this.affiliatedLink,
      @JsonKey(name: 'image_urls') required final List<String> imageUrls,
      required this.category,
      @JsonKey(name: 'pinterest_title') this.pinterestTitle,
      @JsonKey(name: 'pinterest_description') this.pinterestDescription,
      final List<String> tags = const [],
      @JsonKey(name: 'overlay_text') this.overlayText,
      required this.status,
      @JsonKey(name: 'image_generated') required this.imageGenerated,
      required this.createdAt,
      required this.updatedAt})
      : _imageUrls = imageUrls,
        _tags = tags;
  factory _Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  @JsonKey(name: 'amazon_url')
  final String amazonUrl;
  @override
  @JsonKey(name: 'affiliated_link')
  final String? affiliatedLink;
  final List<String> _imageUrls;
  @override
  @JsonKey(name: 'image_urls')
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  @override
  final Category category;
  @override
  @JsonKey(name: 'pinterest_title')
  final String? pinterestTitle;
  @override
  @JsonKey(name: 'pinterest_description')
  final String? pinterestDescription;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey(name: 'overlay_text')
  final String? overlayText;
  @override
  final PinStatus status;
  @override
  @JsonKey(name: 'image_generated')
  final PinImageGenerationStatus imageGenerated;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PostCopyWith<_Post> get copyWith =>
      __$PostCopyWithImpl<_Post>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PostToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Post &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amazonUrl, amazonUrl) ||
                other.amazonUrl == amazonUrl) &&
            (identical(other.affiliatedLink, affiliatedLink) ||
                other.affiliatedLink == affiliatedLink) &&
            const DeepCollectionEquality()
                .equals(other._imageUrls, _imageUrls) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.pinterestTitle, pinterestTitle) ||
                other.pinterestTitle == pinterestTitle) &&
            (identical(other.pinterestDescription, pinterestDescription) ||
                other.pinterestDescription == pinterestDescription) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.overlayText, overlayText) ||
                other.overlayText == overlayText) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.imageGenerated, imageGenerated) ||
                other.imageGenerated == imageGenerated) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      amazonUrl,
      affiliatedLink,
      const DeepCollectionEquality().hash(_imageUrls),
      category,
      pinterestTitle,
      pinterestDescription,
      const DeepCollectionEquality().hash(_tags),
      overlayText,
      status,
      imageGenerated,
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'Post(id: $id, amazonUrl: $amazonUrl, affiliatedLink: $affiliatedLink, imageUrls: $imageUrls, category: $category, pinterestTitle: $pinterestTitle, pinterestDescription: $pinterestDescription, tags: $tags, overlayText: $overlayText, status: $status, imageGenerated: $imageGenerated, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$PostCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$PostCopyWith(_Post value, $Res Function(_Post) _then) =
      __$PostCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      @JsonKey(name: 'amazon_url') String amazonUrl,
      @JsonKey(name: 'affiliated_link') String? affiliatedLink,
      @JsonKey(name: 'image_urls') List<String> imageUrls,
      Category category,
      @JsonKey(name: 'pinterest_title') String? pinterestTitle,
      @JsonKey(name: 'pinterest_description') String? pinterestDescription,
      List<String> tags,
      @JsonKey(name: 'overlay_text') String? overlayText,
      PinStatus status,
      @JsonKey(name: 'image_generated') PinImageGenerationStatus imageGenerated,
      DateTime createdAt,
      DateTime updatedAt});

  @override
  $CategoryCopyWith<$Res> get category;
}

/// @nodoc
class __$PostCopyWithImpl<$Res> implements _$PostCopyWith<$Res> {
  __$PostCopyWithImpl(this._self, this._then);

  final _Post _self;
  final $Res Function(_Post) _then;

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? amazonUrl = null,
    Object? affiliatedLink = freezed,
    Object? imageUrls = null,
    Object? category = null,
    Object? pinterestTitle = freezed,
    Object? pinterestDescription = freezed,
    Object? tags = null,
    Object? overlayText = freezed,
    Object? status = null,
    Object? imageGenerated = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_Post(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amazonUrl: null == amazonUrl
          ? _self.amazonUrl
          : amazonUrl // ignore: cast_nullable_to_non_nullable
              as String,
      affiliatedLink: freezed == affiliatedLink
          ? _self.affiliatedLink
          : affiliatedLink // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrls: null == imageUrls
          ? _self._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      category: null == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category,
      pinterestTitle: freezed == pinterestTitle
          ? _self.pinterestTitle
          : pinterestTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      pinterestDescription: freezed == pinterestDescription
          ? _self.pinterestDescription
          : pinterestDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _self._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      overlayText: freezed == overlayText
          ? _self.overlayText
          : overlayText // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as PinStatus,
      imageGenerated: null == imageGenerated
          ? _self.imageGenerated
          : imageGenerated // ignore: cast_nullable_to_non_nullable
              as PinImageGenerationStatus,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategoryCopyWith<$Res> get category {
    return $CategoryCopyWith<$Res>(_self.category, (value) {
      return _then(_self.copyWith(category: value));
    });
  }
}

// dart format on
