import 'dart:convert';

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

  PersonViewModel({
    this.id,
    this.firstName,
    this.secondName,
    this.firstLastName,
    this.secondLastName,
    this.gender,
    this.birthDate,
    this.phoneNumber,
    this.documentNumber,
  });

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
      };
}
