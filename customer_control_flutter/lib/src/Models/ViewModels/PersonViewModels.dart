import 'dart:convert';

import 'AddressViewModel.dart';

PersonViewModel personViewModelFromJson(String str) =>
    PersonViewModel.fromJson(json.decode(str));

String personViewModelToJson(PersonViewModel data) =>
    json.encode(data.toJson());

class PersonViewModel {
  int? id;
  String? firstName;
  String? secondName;
  String? firstLastName;
  String? secondLastName;
  String? gender;
  String? birthDate;
  String? phoneNumber;
  String? documentNumber;
  List<AddressViewModel>? addresses;

  PersonViewModel(
      {this.id,
      this.firstName,
      this.secondName,
      this.firstLastName,
      this.secondLastName,
      this.gender,
      this.birthDate,
      this.phoneNumber,
      this.documentNumber,
      this.addresses});

  String getFullName() => "${this.firstName} ${this.firstLastName}";

  factory PersonViewModel.fromJson(Map<String, dynamic> json) =>
      PersonViewModel(
        id: json["id"],
        firstName: json["firstName"] ?? "",
        secondName: json["secondName"] ?? "",
        firstLastName: json["firstLastName"] ?? "",
        secondLastName: json["secondLastName"] ?? "",
        gender: json["gender"] ?? "",
        birthDate: json["birthDate"],
        phoneNumber: json["phoneNumber"] ?? "",
        documentNumber: json["documentNumber"] ?? "",
        addresses: json["addresses"] != null
            ? List<AddressViewModel>.from(
                json["addresses"].map(
                  (x) => AddressViewModel.fromJson(x),
                ),
              )
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "secondName": secondName,
        "firstLastName": firstLastName,
        "secondLastName": secondLastName,
        "gender": gender,
        "birthDate": birthDate,
        "phoneNumber": phoneNumber,
        "documentNumber": documentNumber,
        "addresses": addresses,
      };
}
