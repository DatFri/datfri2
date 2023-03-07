// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notifications _$NotificationsFromJson(Map<String, dynamic> json) =>
    Notifications(
      userId: json['userId'] as String?,
      time: json['time'] as String?,
      title: json['title'] as String?,
      from: json['from'] as String?,
    );

Map<String, dynamic> _$NotificationsToJson(Notifications instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'time': instance.time,
      'title': instance.title,
      'from': instance.from,
    };
