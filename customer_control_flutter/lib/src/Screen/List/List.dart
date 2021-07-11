
import 'dart:async';
import 'dart:ffi';

import 'package:customer_control_flutter/src/Models/ViewModels/PersonViewModels.dart';
import 'package:flutter/material.dart';



class ListScreen extends StatefulWidget {
  final title = 'Jeffry';
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late Completer<void> _refreshCompleter;

  @override
  Widget build(BuildContext context) {
 final mediaQuery = MediaQuery.of(context);
    double statusBarHeight = mediaQuery.padding.top;
    double buttonsBarHeight = mediaQuery.padding.bottom;
    double screenHeight =
        (mediaQuery.size.height - statusBarHeight - buttonsBarHeight - 30);

    double titleContainer = screenHeight * 0.2;
    double listContainer = screenHeight * 0.8;

        return SafeArea(
          child: Scaffold(
    
      body: Column(
          children: <Widget>[
            TitleComtaimer(titleContainer),
            bodyContainer(listContainer)

          ],
        ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    )
    );

    
  }


Widget TitleComtaimer(double containersize) {
  return Container(
    height: containersize,
    color:  Colors.red,
    child: Text('hola'),
  );
}

Widget bodyContainer(double containersize) {
  return Container(
    height: containersize,
    color:  Colors.blue,
    child: Text('hola'),
  );
}

 Widget PersonListView(List<PersonViewModel> Persons,
      BuildContext context, double parentHeight) {
    return Scrollbar(
      child: RefreshIndicator(
        child: ListView.builder(
          itemCount: Persons.length,
          itemBuilder: (context, index) {
            return personRow(Persons[index], parentHeight);
          },
        ),
        onRefresh: () {
          // BlocProvider.of<MyWorkBloc>(context).add(MyWorkRefresh());
          return _refreshCompleter.future;
          //  return Void
        },
      ),
    );
  }

    Widget personRow(PersonViewModel vehicle, double parentHeight) {
   
    return GestureDetector(
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
            
          ),
        ),
      ),
    );
  }
}
