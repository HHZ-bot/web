import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(ignoreUnannotated: true)
class Funversion {
  @JsonKey(name: "id", includeFromJson: true, includeToJson: false)
  int? id;

  @JsonKey(name: "platform", includeFromJson: true, includeToJson: false)
  String? platform;

  @JsonKey(name: "minimum", includeFromJson: true, includeToJson: false)
  String? minimum;

  @JsonKey(name: "suggest", includeFromJson: true, includeToJson: false)
  String? suggest;

  @JsonKey(name: "badge", includeFromJson: true, includeToJson: false)
  String? badge;

  @JsonKey(name: "download_url", includeFromJson: true, includeToJson: false)
  String? downloadUrl;

  @JsonKey(name: "pay_switch", includeFromJson: true, includeToJson: false)
  bool? paySwitch;

  Funversion({
    this.id,
    this.platform,
    this.minimum,
    this.suggest,
    this.badge,
    this.downloadUrl,
    this.paySwitch,
  });
}
