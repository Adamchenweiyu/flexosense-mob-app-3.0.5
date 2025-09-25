import 'package:freezed_annotation/freezed_annotation.dart';

part 'response.freezed.dart';
part 'response.g.dart';

@Freezed(genericArgumentFactories: true)
class Res<T> with _$Res<T> {
  const factory Res({
    @JsonKey(name: 'data') required T data,
  }) = ResData;

  factory Res.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$ResFromJson(json, fromJsonT);
}
