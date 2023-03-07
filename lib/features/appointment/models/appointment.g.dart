// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) => Appointment(
      userId: json['userId'] as String?,
      placeId: json['placeId'] as String?,
      userName: json['userName'] as String?,
      placeName: json['placeName'] as String?,
      status: json['status'] as String?,
      userPhone: json['userPhone'] as String?,
      cartype: json['cartype'] as String?,
      kind: json['kind'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      paid: json['paid'] as bool? ?? false,
      amount: json['amount'] as String? ?? '10000',
    )..appointmentId = json['appointmentId'] as String?;

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'userId': instance.userId,
      'placeId': instance.placeId,
      'userName': instance.userName,
      'placeName': instance.placeName,
      'status': instance.status,
      'userPhone': instance.userPhone,
      'cartype': instance.cartype,
      'kind': instance.kind,
      'date': instance.date,
      'time': instance.time,
      'paid': instance.paid,
      'amount': instance.amount,
    };
