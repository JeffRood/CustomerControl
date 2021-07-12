import 'dart:convert';

AddressViewModel addressViewModelFromJson(String str) =>
    AddressViewModel.fromJson(json.decode(str));

String addressViewModelToJson(AddressViewModel data) =>
    json.encode(data.toJson());

class AddressViewModel {
  int? id;
  String? description;

  AddressViewModel({
    this.id,
    this.description,
  });

  factory AddressViewModel.fromJson(Map<String, dynamic> json) =>
      AddressViewModel(
        id: json["id"],
        description: json["description"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
      };
}
