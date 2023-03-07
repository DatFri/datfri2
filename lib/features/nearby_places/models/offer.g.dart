// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Offer _$OfferFromJson(Map<String, dynamic> json) => Offer(
      uid: json['uid'] as String?,
      title: json['title'] as String?,
      off: json['off'] as String?,
      imgUrl: json['imgUrl'] as String?,
      place: json['place'] as String?,
    );

Map<String, dynamic> _$OfferToJson(Offer instance) => <String, dynamic>{
      'uid': instance.uid,
      'title': instance.title,
      'off': instance.off,
      'imgUrl': instance.imgUrl,
      'place': instance.place,
    };
