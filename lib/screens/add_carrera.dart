import 'package:flutter/material.dart';
import 'package:login/assets/global_values.dart';
import 'package:login/database/agendadb.dart';
import 'package:login/models/carrera_model.dart';
import 'package:login/models/profesor_model.dart';

class AddCarrera extends StatefulWidget {
  AddCarrera({super.key, this.carrera});
  Carrera? carrera;
  Profesor? profesor;

  @override
  State<AddCarrera> createState() => _AddCarreraState();
}

class _AddCarreraState extends State<AddCarrera> {
  TextEditingController txtConIdCarrera = TextEditingController();
  TextEditingController txtConNomCarrera = TextEditingController();
  TextEditingController txtConNomProfesor = TextEditingController();
  TextEditingController txtConIdrProfesor = TextEditingController();

  String? dropDownValue = 'Carreras';
  List<String> dropDownValues = [
    'Sistemas Computacionales',
    'Industrial',
    'Gestion',
    'Bioquimica',
    'Mecanica',
    'Quimica',
    'Mecatronica',
    'Administracion',
    'Semiconductores',
    'Ambiental',
    'Electronica'
  ];
  AgendaDB? agendaDB;
  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
    if (widget.carrera != null) {
      txtConIdCarrera.text = widget.carrera!.idCarrera! as String;
      txtConNomCarrera.text = widget.carrera!.idCarrera! as String;
      txtConNomProfesor.text = widget.profesor!.idProfe! as String;
      txtConIdrProfesor.text = widget.profesor!.idProfe! as String;
    }
  }

  @override
  Widget build(BuildContext context) {
    final txtNameProfesor = TextFormField(
      decoration: const InputDecoration(
          label: Text('Profesor'), border: OutlineInputBorder()),
      controller: txtConNomProfesor,
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
          if (widget.carrera == null) {
            agendaDB!.INSERT('tblCarrera', {
              'nomProf': txtConNomProfesor.text,
              'sttCarrera': dropDownValue!.substring(0, 1)
            }).then((value) {
              var msj = (value > 0) ? 'La insercion fue correcta' : 'Error';
              var snackBar = const SnackBar(content: Text('Carrera saved'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.pop(context);
            });
          } else {
            agendaDB!.UPDATE('tblCarrera', {
              'idProfe': widget.carrera!.idCarrera,
              'nomProfe': txtConNomCarrera.text,
              //'sttTask': dropDownValue!.substring(0,1)
            }).then((value) {
              GlobalValues.flagTask.value = !GlobalValues.flagTask.value;
              var msj = (value > 0) ? 'La insercion fue correcta' : 'Error';
              var snackBar = const SnackBar(content: Text('Carrera saved'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.pop(context);
            });
          }
        },
        child: Text('Save Carrera'));

    return Scaffold(
      appBar: AppBar(
          title: widget.carrera == null
              ? Text('Add Carrera')
              : Text('Update Carrera')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            txtNameProfesor,
            //ddBStatus,
            btnGuardar
          ],
        ),
      ),
    );
  }
}
