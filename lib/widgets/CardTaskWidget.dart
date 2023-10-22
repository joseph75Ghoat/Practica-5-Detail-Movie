import 'package:flutter/material.dart';
import 'package:login/assets/global_values.dart';
import 'package:login/database/agendadb.dart';
import 'package:login/models/task_model.dart';
import 'package:login/screens/add_task.dart';

class CardTaskWidget extends StatelessWidget {
  CardTaskWidget({super.key, required this.taskModel, this.agendaDB});

// las llaves significasn nomnbrados

  TaskModel taskModel;
  AgendaDB? agendaDB;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.green),
      child: Row(
        children: [
          Column(
            children: [Text(taskModel.nameTask!), Text(taskModel.dscTask!)],
          ),
          Expanded(child: Container()),
          Column(
            children: [
            
             GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddTask(taskModel: taskModel))) ,
                child: Image.asset('assets/fresa.png',height: 50,)
                ),


           
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Mensaje del sistema'),
                          content: Text('¿Deseas Borrar la tarea?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  agendaDB!
                                      .DELETE('tblTareas', taskModel.idTask!)
                                      .then((value) {
                                    Navigator.pop(context);
                                    GlobalValues.flagTask.value =
                                        !GlobalValues.flagTask.value;
                                  });
                                },
                                child: Text('si')),
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('No')),
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
