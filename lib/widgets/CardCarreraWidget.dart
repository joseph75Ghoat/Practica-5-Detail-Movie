
import 'package:flutter/material.dart';
import 'package:login/assets/global_values.dart';
import 'package:login/database/agendadb.dart';
import 'package:login/models/carrera_model.dart';
import 'package:login/models/carrera_model.dart';
import 'package:login/screens/add_task.dart';

class CardCarreraWidget extends StatefulWidget {
  const CardCarreraWidget(
      {super.key, required Carrera carreraModel, AgendaDB? agendaDB});

  @override
  State<CardCarreraWidget> createState() => _CardCarreraWidgetState();
}

class _CardCarreraWidgetState extends State<CardCarreraWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
