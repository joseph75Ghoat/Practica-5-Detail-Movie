import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:login/assets/global_values.dart';
import 'package:login/database/agendadb.dart';
import 'package:login/models/task_model.dart';
import 'package:intl/intl.dart';


class AddTask extends StatefulWidget {
  AddTask({super.key, this.taskModel});

  TaskModel? taskModel;

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  DateTime initSelectedDate = DateTime.now();
  DateTime endSelectedDate = DateTime.now();
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

  Future<void> _selectDateEnd(BuildContext context) async {
    final DateTime? picked = (await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 100),
        lastDate: DateTime(DateTime.now().year + 1)));

    if (picked != null && picked != endSelectedDate) {
      setState(() {
        print(endSelectedDate.toString().substring(0, 19));
        endSelectedDate = picked;
      });
    }
  }

  Future<void> _selectDateInit(BuildContext context) async {
    final DateTime? picked = (await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 100),
        lastDate: DateTime(DateTime.now().year + 1)));

    if (picked != null && picked != initSelectedDate) {
      setState(() {
        initSelectedDate = picked;
      });
    }
  }

  String? dropDownValue = "Pendiente";
  TextEditingController txtConName = TextEditingController();
  TextEditingController txtConDsc = TextEditingController();
  List<String> dropDownValues = ['Pendiente', 'Completado', 'En proceso'];

  AgendaDB? agendaDB;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    agendaDB = AgendaDB();
    if (widget.taskModel != null) {
      txtConName.text = widget.taskModel!.nameTask!;
      txtConDsc.text = widget.taskModel!.dscTask!;
      endSelectedDate = DateTime.parse(widget.taskModel!.fecExpiracion!);
      initSelectedDate = DateTime.parse(widget.taskModel!.fecRecordatorio!);
      switch (widget.taskModel!.sttTask) {
        case 'E':
          dropDownValue = "En proceso";
          break;
        case 'C':
          dropDownValue = "Completado";
          break;
        case 'P':
          dropDownValue = "Pendiente";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final txtNameTask = TextFormField(
      decoration: const InputDecoration(
          label: Text('Tarea'), border: OutlineInputBorder()),
      controller: txtConName,
    );

    final txtDscTask = TextField(
      decoration: const InputDecoration(
          label: Text('Descripcion'), border: OutlineInputBorder()),
      maxLines: 6,
      controller: txtConDsc,
    );

    final space = SizedBox(
      height: 10,
    );

    final DropdownButton ddBStatus = DropdownButton(
        value: dropDownValue,
        items: dropDownValues
            .map((status) =>
                DropdownMenuItem(value: status, child: Text(status)))
            .toList(),
        onChanged: (value) {
          dropDownValue = value;
          setState(() {});
        });

    final ElevatedButton btnGuardar = ElevatedButton(
        onPressed: () {
          print(endSelectedDate.toString().substring(0, 19));
          if (widget.taskModel == null) {
            agendaDB!.INSERT('tblTareas', {
              'nameTask': txtConName.text,
              'dscTask': txtConDsc.text,
              'sttTask': dropDownValue!.substring(0, 1),
              'fecExpiracion': endSelectedDate.toString().substring(0, 19),
              'fecRecordatorio': initSelectedDate.toString().substring(0, 19),
            }).then((value) {
              var msj = (value > 0)
                  ? 'La inserción fue exitosa!'
                  : 'Ocurrió un error';
              var snackbar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Navigator.pop(context);
            });
          } else {
            agendaDB!.UPDATE('tblTareas', {
              'idTask': widget.taskModel!.idTask,
              'nameTask': txtConName.text,
              'dscTask': txtConDsc.text,
              'sttTask': dropDownValue!.substring(0, 1),
              'fecExpiracion': endSelectedDate.toString().substring(0, 19),
              'fecRecordatorio': initSelectedDate.toString().substring(0, 19),
            }).then((value) {
              GlobalValues.flagTask.value = !GlobalValues.flagTask.value;
              var msj = (value > 0)
                  ? 'La actualización fue exitosa!'
                  : 'Ocurrió un error';
              var snackbar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Navigator.pop(context);
            });
          }
        },
        child: Text('Save Task'));

    return Scaffold(
      appBar: AppBar(
        title:
            widget.taskModel == null ? Text('Add Task') : Text('Update Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            txtNameTask,
            space,
            txtDscTask,
            space,
            ddBStatus,
            space,
            buildDateInitSelector(context, "Fecha Inicial"),
            buildDateEndSelector(context, "Fecha Final"),
            btnGuardar,
          ],
        ),
      ),
    );
  }

  Widget buildDateEndSelector(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        readOnly:
            true, // Evita que se pueda editar el campo de texto directamente
        controller: TextEditingController(
          text: dateFormat
              .format(endSelectedDate), // Muestra la fecha seleccionada
        ),

        decoration: InputDecoration(
          labelText: title,
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        onTap: () {
          _selectDateEnd(
              context); // Abre el selector de fecha al tocar en cualquier parte del campo
        },
        // Añade el sufijo del ícono para indicar que es un campo de fecha
      ),
    );
  }

  Widget buildDateInitSelector(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        readOnly:
            true, // Evita que se pueda editar el campo de texto directamente
        controller: TextEditingController(
          text: dateFormat
              .format(initSelectedDate), // Muestra la fecha seleccionada
        ),

        decoration: InputDecoration(
          labelText: title,
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        onTap: () {
          _selectDateInit(
              context); // Abre el selector de fecha al tocar en cualquier parte del campo
        },
        // Añade el sufijo del ícono para indicar que es un campo de fecha
      ),
    );
  }
}

