import 'package:flutter/material.dart';
import 'package:login/assets/global_values.dart';
import 'package:login/database/agendadb.dart';
import 'package:login/models/profesor_model.dart';
import 'package:login/models/profesor_model.dart';
import 'package:login/screens/add_profe.dart';
import 'package:login/screens/add_task.dart';

class CardProfesorWidget extends StatelessWidget {
  CardProfesorWidget({super.key, required this.profesorModel, this.agendaDB});

  Profesor profesorModel;
  AgendaDB? agendaDB;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.amber),
      child: Row(
        children: [
          Column(
            children: [
              Text(profesorModel.nomProfe!),
              Text(profesorModel.email!),
              Text(profesorModel.idCarrera! as String),
            ],
          ),
          Expanded(child: Container()),
          Column(
            children: [
              GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddProfesor(profesorModel: profesorModel))),
                  child: Image.asset(
                    'assets/fresa.png',
                    height: 50,
                  )),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Mensaje del sistema'),
                          content: const Text('¿Deseas eliminar al profesor?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  agendaDB!
                                      .DELETE(
                                          'tblProfesor', profesorModel.idProfe!)
                                      .then((value) {
                                    Navigator.pop(context);
                                    GlobalValues.flagTask.value =
                                        !GlobalValues.flagTask.value;
                                  });
                                },
                                child: Text('Si')),
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('No'))
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.delete))
            ],
          )
        ],
      ),
    );
  }
}
