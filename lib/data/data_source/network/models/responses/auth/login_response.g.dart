// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginResponseImpl _$$LoginResponseImplFromJson(Map<String, dynamic> json) =>
    _$LoginResponseImpl(
      message: json['message'] as String?,
      expiresIn: (json['expiresIn'] as num?)?.toInt(),
      accessToken: json['sessionToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$$LoginResponseImplToJson(_$LoginResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'expiresIn': instance.expiresIn,
      'sessionToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
