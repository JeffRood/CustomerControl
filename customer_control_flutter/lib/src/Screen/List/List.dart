import 'dart:async';

import 'package:customer_control_flutter/src/Models/ViewModels/PersonViewModels.dart';
import 'package:customer_control_flutter/src/Screen/Create/Create.dart';
import 'package:customer_control_flutter/src/Services/apiService.dart';
import 'package:customer_control_flutter/src/shared/shared.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  bool search = false;
  TextEditingController controller = TextEditingController();
  late Completer<void> _refreshCompleter;
  Stream<List<PersonViewModel>> personList =
      new Stream.fromFuture(ApiService().getAllPersons());

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double statusBarHeight = mediaQuery.padding.top;
    double buttonsBarHeight = mediaQuery.padding.bottom;
    double screenHeight =
        (mediaQuery.size.height - statusBarHeight - buttonsBarHeight);

    double sizeSmallContainer = screenHeight * 0.1;
    double sizeMediumContainer = screenHeight * 0.4;

    double sizeLargeContainer = screenHeight * 0.8;

    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              children: <Widget>[
                TitleComtaimer(sizeSmallContainer),
                SearchContainer(sizeSmallContainer),
                bodyContainer(sizeLargeContainer, context),
              ],
            ),
            floatingActionButton: Container(
              height: sizeMediumContainer * 0.25,
              width: sizeMediumContainer * 0.25,
              child: FloatingActionButton(
                onPressed: () =>
                    (Shared.navigationFadeTo(context, RegisterScreen())),
                backgroundColor: Colors.purple[700],
                child: Icon(
                  Icons.add,
                  size: 45,
                ),
              ), // This trailing comma makes auto-formatting nicer for build methods.
            )));
  }

  Widget SearchContainer(double containerSize) {
    return Container(
      color: Colors.indigo[900],
      height: containerSize,
      width: MediaQuery.of(context).size.width,
      child: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  key: Key("searchform"),
                  textInputAction: TextInputAction.search,
                  onEditingComplete: () => onSearch(),
                  controller: controller,
                  decoration: InputDecoration(
                    hoverColor: Colors.transparent,
                    contentPadding: new EdgeInsets.symmetric(horizontal: 20.0),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.search,
                        size: 30,
                        color: Colors.grey,
                      ),
                      onPressed: () => onSearch(),
                    ),
                    filled: true,
                    fillColor: Color(0xffF8F9F5),
                    hintText: "Buscar Persona",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onSearch() {
    FocusScope.of(context).requestFocus(FocusNode());
    search = true;
    final String filterText = controller.text;
    return null;
  }

  Widget TitleComtaimer(double containersize) {
    return Container(
      color: Colors.indigo[900],
      height: containersize,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Personas',
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget bodyContainer(double containersize, BuildContext context) {
    return Container(
      height: containersize,
      width: MediaQuery.of(context).size.width,
      // color: Colors.blue,
      child: PersonListView(context, containersize),
    );
  }

  Widget PersonListView(BuildContext context, double parentHeight) {
    return Scrollbar(
      child: StreamBuilder(
          stream: personList,
          builder: (context, AsyncSnapshot<List<PersonViewModel>> snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: (snapshot.data?.length ?? 0),
                    itemBuilder: (context, index) {
                      return personRow(snapshot.data![index], parentHeight);
                    },
                  )
                : loadingIndicator();
          }),
    );
  }

  Widget loadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget personRow(PersonViewModel person, double parentHeight) {
    return person.getFullName().toLowerCase().contains(controller.text)
        ? GestureDetector(
            onTap: () => {},
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    color: Colors.grey,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(left: 5, right: 20, top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: parentHeight * 0.1,
                      width: parentHeight * 0.1,
                      child: Center(
                        child: Text(
                          (person.firstName![0] + person.firstLastName![0])
                              .toUpperCase(),
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      decoration: new BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      width: parentHeight * 0.01,
                    ),
                    Text(
                      person.getFullName(),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Text('');
  }
}
