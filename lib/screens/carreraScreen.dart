

import 'package:flutter/material.dart';
import 'package:login/assets/global_values.dart';
import 'package:login/database/agendadb.dart';
import 'package:login/models/carrera_model.dart';
import 'package:login/widgets/CardCarreraWidget.dart';

class CarreraScreen extends StatefulWidget {
  const CarreraScreen({super.key});

  @override
  State<CarreraScreen> createState() => _CarreraScreenState();
}

class _CarreraScreenState extends State<CarreraScreen> {
  AgendaDB? agendaDB;

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carreras"),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/carrera').then((value) {
                    setState(() {});
                  }),
              icon: Icon(Icons.task))
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: GlobalValues.flagTask,
          builder: (context, value, _) {
            return FutureBuilder(
                future: agendaDB!.GETALLCARRERA(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Carrera>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CardCarreraWidget(
                              carreraModel: snapshot.data![index],
                              agendaDB: agendaDB);
                        });
                  } else {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("NO HAY CARRERAS REGISTRADAS"),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }
                });
          }),
    );
  }
}
