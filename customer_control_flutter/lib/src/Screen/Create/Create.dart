import 'dart:developer';

import 'package:cool_alert/cool_alert.dart';
import 'package:customer_control_flutter/src/Models/InputModels/AddressInputModel.dart';
import 'package:customer_control_flutter/src/Models/InputModels/PersonInputModel.dart';
import 'package:customer_control_flutter/src/Screen/List/List.dart';
import 'package:customer_control_flutter/src/Services/apiService.dart';
import 'package:customer_control_flutter/src/shared/Widget/upperCaseTextFormatter.dart';
import 'package:customer_control_flutter/src/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:toggle_switch/toggle_switch.dart';

class RegisterScreen extends StatefulWidget {
  PersonInputModel inputPerson = new PersonInputModel();

  bool isInValid = false;
  int toggleGender = 0;
  String? birthdayDate;
  final dateFormatter = new DateFormat('yyyy-MMM-dd');

  RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenbState createState() => _RegisterScreenbState();
}

class _RegisterScreenbState extends State<RegisterScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController firstLastNameController = TextEditingController();
  TextEditingController secondLastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController DocumentController = TextEditingController();
  List<TextEditingController> addressController = [];
  bool isLoading = false;

  var maskFormatterPhone = new MaskTextInputFormatter(mask: '(###) ###-####');
  var maskFormatterDocument = new MaskTextInputFormatter(mask: '###-#######-#');

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double statusBarHeight = mediaQuery.padding.top;
    double buttonsBarHeight = mediaQuery.padding.bottom;

    double screenHeight =
        (mediaQuery.size.height - statusBarHeight - buttonsBarHeight);
    final headerHeight = screenHeight * 0.1;
    final mainContainerHeight = screenHeight * 0.9;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Registrar Persona'),
        ),
        resizeToAvoidBottomInset: true,
        body: ListView(
          children: [
            Container(
              height: mainContainerHeight,
              width: mediaQuery.size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(mediaQuery.size.width * 0.05),
                  topRight: Radius.circular(mediaQuery.size.width * 0.05),
                ),
              ),
              child: SingleChildScrollView(
                // reverse: true,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: mediaQuery.viewInsets.bottom,
                  ),
                  child: Column(
                    children: [
                      _buildPersonform(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonform() {
    return Form(
      key: _formKey,
      child: Scrollbar(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: isLoading
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: [
                  _textFieldFirstName(),
                  _textFieldSecondName(),
                  _textFieldFirstLastNames(),
                  _textFieldSecondLastNames(),
                  birthday(),
                  toggleGender(),
                  _textFieldPhoneNumber(),
                  _textFieldDocument(),
                  _addressContainer(),
                  ElevatedButton(
                    onPressed: () async {
                      if (widget.birthdayDate == null) {
                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.error,
                          title: "Fecha de Nacimiento invalida.",
                          text: "Debe seleccionar una fecha de nacimiento.",
                        );
                        return;
                      }
                      await Future.delayed(Duration(milliseconds: 200));
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      setState(() {
                        isLoading = true;
                      });
                      mapDataformToModel();
                      print('mapped completed');
                      await createRequest();

                      Shared.navigationFadeTo(context, ListScreen());
                    },
                    child: Text('Registrar'),
                  )
                ],
              ),
      ),
    );
  }

  Future createRequest() async {
    var result = await ApiService().createPerson(widget.inputPerson);
    print(result);
    // return result;
  }

  Widget _viewAddrees() {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: (100 * addressController.length).toDouble(),
            child: ListView.builder(
              itemCount: addressController.length,
              itemBuilder: (BuildContext context, int index) {
                return _textFieldAddress(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _textFieldAddress(index) {
    print('ENTRE');
    print(index);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      // color: Color(0xffE8E8E8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        controller: addressController[index],
        inputFormatters: [
          UpperCaseTextFormatter(),
        ],
        validator: (value) {
          RegExp regex = RegExp(r'^[a-zA-Z]');
          if (value!.contains(' ')) {
            return "Este campo no debe contener espacios.";
          }
          if (!regex.hasMatch(value)) {
            return 'Debe ingresar un direccion';
          }
          if (value == null || value.isEmpty) {
            print(value);
            return 'Debe ingresar el nombre';
          }
          return null;
        },
        textAlign: TextAlign.center,
        decoration: new InputDecoration(
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(15.0),
            ),
          ),
          filled: true,
          hintText: "",
        ),
      ),
    );
  }

  Widget _addressContainer() {
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Direcciones",
                style: TextStyle(
                  fontSize: 18.0,
                )),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  addressController.add(TextEditingController());
                });
              },
              child: Text('Agregar Direccion'),
            )
          ],
        ),
        SizedBox(
          height: 12,
        ),
        addressController.length > 0 ? _viewAddrees() : Text(''),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }

  Widget _textFieldFirstName() {
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text("Primer Nombre",
              style: TextStyle(
                fontSize: 18.0,
              )),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          // color: Color(0xffE8E8E8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextFormField(
            controller: firstNameController,
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            validator: (value) {
              RegExp regex = RegExp(r'^[a-zA-Z]');
              if (value!.contains(' ')) {
                return "Este campo no debe contener espacios.";
              }
              if (!regex.hasMatch(value)) {
                return 'Debe ingresar un nombre valido.';
              }
              if (value == null || value.isEmpty) {
                print(value);
                return 'Debe ingresar el nombre';
              }
              return null;
            },
            textAlign: TextAlign.center,
            decoration: new InputDecoration(
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(15.0),
                ),
              ),
              filled: true,
              hintText: "",
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }

  Widget _textFieldSecondName() {
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text("Segundo Nombre",
              style: TextStyle(
                fontSize: 18.0,
              )),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          // color: Color(0xffE8E8E8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextFormField(
            controller: secondNameController,
            validator: (value) {
              if (value!.isEmpty) return null;
              RegExp regex = RegExp(r'^[a-zA-Z]');
              if (value.contains(' ')) {
                return "Este campo no debe contener espacios.";
              }
              if (!regex.hasMatch(value)) {
                return 'Debe ingresar un nombre valido.';
              }
              return null;
            },
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            textAlign: TextAlign.center,
            decoration: new InputDecoration(
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(15.0),
                ),
              ),
              filled: true,
              hintText: "",
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }

  Widget _textFieldFirstLastNames() {
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text("Primer Apellido",
              style: TextStyle(
                fontSize: 18.0,
              )),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          // color: Color(0xffE8E8E8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextFormField(
            controller: firstLastNameController,
            validator: (value) {
              RegExp regex = RegExp(r'^[a-zA-Z]');
              if (value!.contains(' ')) {
                return "Este campo no debe contener espacios.";
              }
              if (!regex.hasMatch(value)) {
                return 'Debe ingresar un nombre valido.';
              }
              if (value == null || value.isEmpty) {
                print(value);
                return 'Debe ingresar el Apellido';
              }
              return null;
            },
            textAlign: TextAlign.center,
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            decoration: new InputDecoration(
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(15.0),
                ),
              ),
              filled: true,
              hintText: "",
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }

  Widget _textFieldSecondLastNames() {
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text("Segundo Apellido",
              style: TextStyle(
                fontSize: 18.0,
              )),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          // color: Color(0xffE8E8E8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextFormField(
            controller: secondLastNameController,
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            validator: (value) {
              if (value!.isEmpty) return null;
              RegExp regex = RegExp(r'^[a-zA-Z]');
              if (value.contains(' ')) {
                return "Este campo no debe contener espacios.";
              }
              if (!regex.hasMatch(value)) {
                return 'Debe ingresar un nombre valido.';
              }
              return null;
            },
            textAlign: TextAlign.center,
            decoration: new InputDecoration(
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(15.0),
                ),
              ),
              filled: true,
              hintText: "",
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }

  Widget toggleGender() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text("Genero",
              style: TextStyle(
                fontSize: 18.0,
              )),
        ),
        SizedBox(
          height: 12,
        ),
        ToggleSwitch(
          totalSwitches: 2,
          minWidth: 110,
          initialLabelIndex: widget.toggleGender,
          cornerRadius: 20.0,
          activeFgColor: Colors.white,
          inactiveBgColor: Colors.grey,
          inactiveFgColor: Colors.white,
          labels: ['Masculino', 'Femenino'],
          icons: [FontAwesomeIcons.mars, FontAwesomeIcons.venus],
          activeBgColors: [
            [Colors.blue],
            [Colors.pink]
          ],
          onToggle: (index) {
            widget.toggleGender = index;
          },
        ),
      ],
    );
  }

  Widget _textFieldPhoneNumber() {
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text("Numero telefonico",
              style: TextStyle(
                fontSize: 18.0,
              )),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          // color: Color(0xffE8E8E8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextFormField(
            controller: phoneNumberController,
            inputFormatters: [maskFormatterPhone],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: new InputDecoration(
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(15.0),
                ),
              ),
              filled: true,
              hintText: "",
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }

  Widget _textFieldDocument() {
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text("No. Cedula",
              style: TextStyle(
                fontSize: 18.0,
              )),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          // color: Color(0xffE8E8E8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),

          child: TextFormField(
            controller: DocumentController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.contains(' ')) {
                return "El No. de Cedula no debe tener espacios.";
              }
              return null;
            },
            inputFormatters: [
              UpperCaseTextFormatter(),
              maskFormatterDocument,
            ],
            decoration: new InputDecoration(
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(15.0),
                ),
              ),
              filled: true,
              hintText: "",
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }

  Widget birthday() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Fecha de Nacimiento",
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            onPressed: () async {
              final dateSelected = await showDatePicker(
                context: context,
                initialDate: widget.inputPerson.birthDate ?? DateTime.now(),
                firstDate: DateTime(1900, 1, 1),
                lastDate: DateTime.now(),
              );

              widget.birthdayDate = dateSelected != null
                  ? widget.dateFormatter.format(dateSelected)
                  : null;
              setState(() => widget.inputPerson.birthDate = dateSelected);
            },
            child: Text(
              widget.birthdayDate ?? "Por favor, seleccione una fecha: ",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  mapDataformToModel() async {
    widget.inputPerson.firstName = firstNameController.text;
    widget.inputPerson.secondName = secondNameController.text;
    widget.inputPerson.firstLastName = firstLastNameController.text;
    widget.inputPerson.secondLastName = secondLastNameController.text;
    widget.inputPerson.phoneNumber = phoneNumberController.text;
    widget.inputPerson.gender = widget.toggleGender == 0 ? "M" : "F";
    widget.inputPerson.documentNumber = DocumentController.text;

    widget.inputPerson.addresses = addressController
        .map(
          (e) => AddressInputModel(
            description: e.text,
          ),
        )
        .toList();
  }
}
