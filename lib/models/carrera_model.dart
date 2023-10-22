class Carrera {
  int? idCarrera;
  String? nomCarrera;

  Carrera({this.idCarrera, this.nomCarrera});

  factory Carrera.fromMap(Map<String, dynamic> map) {
    return Carrera(
      idCarrera: map['idCarrera'],
      nomCarrera: map['nomCarrera'],
    );
  }
}
