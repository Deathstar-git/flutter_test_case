import 'package:freezed_annotation/freezed_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class ResponseData{
  int code;
  dynamic meta;
  List<dynamic>data;
  ResponseData({required this.code, this.meta, required this.data});
  factory ResponseData.fromJson(Map<String, dynamic> json) => _$ResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);

}