import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(ignoreUnannotated: true)
class Funproduct {
  @JsonKey(name: "id", includeFromJson: true, includeToJson: false)
  int? id;

  @JsonKey(name: "product_level", includeFromJson: true, includeToJson: false)
  int? productLevle;

  @JsonKey(name: "product_name", includeFromJson: true, includeToJson: false)
  String? productName;

  @JsonKey(name: "product_time", includeFromJson: true, includeToJson: false)
  int? productTime;

  @JsonKey(name: "product_value", includeFromJson: true, includeToJson: false)
  int? productValue;

  @JsonKey(name: "product_banner", includeFromJson: true, includeToJson: false)
  String? productBanner;

  @JsonKey(name: "discount_value", includeFromJson: true, includeToJson: false)
  int? discountValue;

  @JsonKey(name: "discount_start", includeFromJson: true, includeToJson: false)
  String? discountStart;

  @JsonKey(name: "discount_stop", includeFromJson: true, includeToJson: false)
  String? discountStop;

  @JsonKey(name: "product_detail", includeFromJson: true, includeToJson: false)
  String? productDetail;

  Funproduct({
    this.id,
    this.productLevle,
    this.productName,
    this.productTime,
    this.productValue,
    this.productBanner,
    this.discountValue,
    this.discountStart,
    this.discountStop,
    this.productDetail,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is Funproduct &&
        other.productLevle == productLevle &&
        other.productName == productName &&
        other.productTime == productTime &&
        other.productValue == productValue &&
        other.productBanner == productBanner &&
        other.discountValue == discountValue &&
        other.discountStart == discountStart &&
        other.discountStop == discountStop &&
        other.productDetail == productDetail;
  }

  @override
  int get hashCode => Object.hash(
        productLevle,
        productName,
        productTime,
        productValue,
        productBanner,
        discountValue,
        discountStart,
        discountStop,
        productDetail,
      );
}
