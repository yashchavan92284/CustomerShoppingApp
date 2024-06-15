import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "contactNumber")
  String? contactNumber;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "address")
  String? address;

  @JsonKey(name: "city")
  String? city;

  @JsonKey(name: "pinCode")
  String? pinCode;

  @JsonKey(name: "password")
  String? password;

  // @JsonKey(name: "addressProofDocument")
  // String? addressProofDocument; // URL of the address proof document image

  User({
    this.id,
    this.name,
    this.contactNumber,
    this.email,
    this.address,
    this.city,
    this.pinCode,
    this.password,
    // this.addressProofDocument,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
