import 'dart:convert';

AddressInputModel addressViewModelFromJson(String str) =>
    AddressInputModel.fromJson(json.decode(str));

String addressViewModelToJson(AddressInputModel data) =>
    json.encode(data.toJson());

class AddressInputModel {
  String? description;

  AddressInputModel({
    this.description,
  });

  factory AddressInputModel.fromJson(Map<String, dynamic> json) =>
      AddressInputModel(
        description: json["description"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "description": "$description",
      };
}
