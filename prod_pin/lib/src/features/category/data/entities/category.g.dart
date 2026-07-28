// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Category _$CategoryFromJson(Map<String, dynamic> json) => _Category(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      coverImage: json['coverImage'] as String?,
      totalPins: (json['totalPins'] as num?)?.toInt(),
      maxPins: (json['maxPins'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$CategoryToJson(_Category instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'coverImage': instance.coverImage,
      'totalPins': instance.totalPins,
      'maxPins': instance.maxPins,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
