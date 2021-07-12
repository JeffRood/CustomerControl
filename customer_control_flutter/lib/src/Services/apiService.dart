import 'package:customer_control_flutter/src/Models/InputModels/PersonInputModel.dart';
import 'package:customer_control_flutter/src/Models/ViewModels/PersonViewModels.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ApiService {
  var client = http.Client();
  static String api = "https://9a5cda8d17db.ngrok.io/";
  ApiService._privateConstructor();
  static final ApiService _instance = ApiService._privateConstructor();

  factory ApiService() {
    return _instance;
  }

  Future<List<PersonViewModel>> getAllPersons() async {
    var response = await Dio().get(
      api + 'Person',
    );
    Iterable list = response.data;
    var resultRequest =
        list.map((model) => PersonViewModel.fromJson(model)).toList();

    return resultRequest;
  }

  Future createPerson(PersonInputModel person) async {
    print(person.toString());
    print(person.toJson());

    var response = await Dio().post(api + 'Person', data: person.toJson());

    var result = response.data;

    return result;
  }
}
