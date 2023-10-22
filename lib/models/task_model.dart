class TaskModel {
  int? idTask;
  String? nameTask;
  String? dscTask;
  String? sttTask;
  String? fecExpiracion;
  String? fecRecordatorio;
  int? idProfe;

  TaskModel({
    this.idTask,
    this.nameTask,
    this.dscTask,
    this.sttTask,
    this.fecExpiracion,
    this.fecRecordatorio,
    this.idProfe,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      idTask: map['idTask'],
      nameTask: map['nameTask'],
      dscTask: map['dscTask'],
      sttTask: map['sttTask'],
      fecExpiracion: map['fecExpiracion'],
      fecRecordatorio: map['fecRecordatorio'],
      idProfe: map['idProfe'],
    );
  }
}
