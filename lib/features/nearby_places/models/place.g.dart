// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) => Place(
      uid: json['uid'] as String?,
      name: json['name'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      address: json['address'] as String?,
      rating: json['rating'] as String?,
    )..imgUrl = json['imgUrl'] as String?;

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'rating': instance.rating,
      'imgUrl': instance.imgUrl,
    };
