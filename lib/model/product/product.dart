import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "price")
  double? price;

  @JsonKey(name: "imageUrl")
  String? imageUrl; // Single image URL

  @JsonKey(name: "imageNames")
  List<String>? imageNames;

  Product(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.imageNames,
      this.imageUrl});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
