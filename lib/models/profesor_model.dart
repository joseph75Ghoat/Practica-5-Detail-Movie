class Profesor {
  int? idProfe;
  String? nomProfe;
  int? idCarrera;
  String? email;

  Profesor({this.idProfe, this.nomProfe, this.idCarrera, this.email});

  factory Profesor.fromMap(Map<String, dynamic> map) {
    return Profesor(
      idProfe: map['idProfe'],
      nomProfe: map['nomProfe'],
      idCarrera: map['idCarrera'],
      email: map['email'],
    );
  }
}
