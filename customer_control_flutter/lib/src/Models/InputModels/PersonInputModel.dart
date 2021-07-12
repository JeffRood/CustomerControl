import 'dart:convert';
import 'dart:developer';

import 'package:customer_control_flutter/src/Models/InputModels/AddressInputModel.dart';

PersonInputModel personViewModelFromJson(String str) =>
    PersonInputModel.fromJson(json.decode(str));

String personViewModelToJson(PersonInputModel data) =>
    json.encode(data.toJson());

class PersonInputModel {
  int? id;
  String? firstName;
  String? secondName;
  String? firstLastName;
  String? secondLastName;
  String? gender;
  DateTime? birthDate;
  String? phoneNumber;
  String? documentNumber;
  List<AddressInputModel>? addresses;

  PersonInputModel(
      {this.firstName,
      this.secondName,
      this.firstLastName,
      this.secondLastName,
      this.gender,
      this.birthDate,
      this.phoneNumber,
      this.documentNumber,
      this.addresses});

  factory PersonInputModel.fromJson(Map<String, dynamic> json) =>
      PersonInputModel(
        firstName: json["firstName"] ?? "",
        secondName: json["secondName"] ?? "",
        firstLastName: json["firstLastName"] ?? "",
        secondLastName: json["secondLastName"] ?? "",
        gender: json["gender"] ?? "",
        birthDate: json["birthDate"],
        phoneNumber: json["phoneNumber"] ?? "",
        documentNumber: json["documentNumber"] ?? "",
        addresses: json["addresses"] != null
            ? List<AddressInputModel>.from(
                json["addresses"].map(
                  (x) => AddressInputModel.fromJson(x),
                ),
              )
            : null,
      );

  Map<String, dynamic> toJson() => {
        "firstName": "$firstName",
        "secondName": "$secondName",
        "firstLastName": "$firstLastName",
        "secondLastName": "$secondLastName",
        "gender": "$gender",
        "documentNumber": "$documentNumber",
        "birthDate": "${birthDate!.toIso8601String()}",
        "phoneNumber": "$phoneNumber",
        "addresses": addresses?.map((e) => e.toJson()).toList(),
      };
}
