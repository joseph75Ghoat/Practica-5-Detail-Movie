import 'dart:async';
import 'dart:io';
import 'package:login/models/carrera_model.dart';
import 'package:login/models/popular_model.dart';
import 'package:login/models/profesor_model.dart';
import 'package:login/models/task_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AgendaDB {
  static final nameDB = 'AGENDADB';
  static final versionDB = 1;

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database!;
    return _database = await _initDatabase();
  }

  Future<Database?> _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path, nameDB);
    return openDatabase(pathDB, version: versionDB, onCreate: _createTables);
  }

  FutureOr<void> _createTables(Database db, int version) {
    String query =
        '''CREATE TABLE tblTareas( 
      idTask INTEGER PRIMARY KEY,
      nameTask VARCHAR(50),
      dscTask VARCHAR(50),
      sttTask BYTE,
      fecExpiracion DATETIME,
      fecRecordatorio DATETIME,
      idProfesor INTEGER, FOREIGN KEY (idProfesor) REFERENCES tblProfesor(idProfe));''';

    String query2 =
        '''CREATE TABLE tblCarrera(
      idCarrera INTEGER PRIMARY KEY,
      nameCarrera VARCHAR(50));''';

    String query3 =
        '''CREATE TABLE tblProfesor(
      idProfe INTEGER PRIMARY KEY, 
      nameProfe VARCHAR(50), 
      idCarrera INTEGER, 
      email VARCHAR(50), 
      FOREIGN KEY (idCarrera) REFERENCES tblProfesor(idCarrera));''';
      
      String query4 =
      '''CREATE TABLE tblFavoriteMovies(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    movieId INTEGER,
    title TEXT,
    posterPath TEXT
  );''';

  db.execute(query4);
    db.execute(query2);
    db.execute(query3);
    db.execute(query);
  }

  Future<int> INSERT(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.insert(tblName, data);
  }

  Future<int> UPDATE(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.update(tblName, data,
        where: 'idTask = ?', whereArgs: [data['idTask']]);
  }

  Future<int> DELETE(String tblName, int idTask) async {
    var conexion = await database;
    return conexion!.delete(tblName, where: 'idTask = ?', whereArgs: [idTask]);
  }

  Future<List<TaskModel>> GETALLTASK() async {
    var conexion = await database;
    var result = await conexion!.query('tblTareas');
    return result.map((task) => TaskModel.fromMap(task)).toList();
  }

  Future<List<Profesor>> GETALLPROFESOR() async {
    var conexion = await database;
    var result = await conexion!.query('tblProfesor');
    return result.map((profesor) => Profesor.fromMap(profesor)).toList();
  }

  Future<List<Carrera>> GETALLCARRERA() async {
    var conexion = await database;
    var result = await conexion!.query('tblCarrera');
    return result.map((carrera) => Carrera.fromMap(carrera)).toList();
  }

  Future<List<TaskModel>> ListarTareasPendientes() async {
    var conexion = await database;
    var result = await conexion!
        .query('tblTareas', where: 'sttTask = ?', whereArgs: ['P']);
    return result.map((task) => TaskModel.fromMap(task)).toList();
  }

  Future<List<TaskModel>> ListarTareasRealizadas() async {
    var conexion = await database;
    var result = await conexion!
        .query('tblTareas', where: 'sttTask = ?', whereArgs: ['C']);
    return result.map((task) => TaskModel.fromMap(task)).toList();
  }

  Future<List<TaskModel>> ListarTareasProceso() async {
    var conexion = await database;
    var result = await conexion!
        .query('tblTareas', where: 'sttTask = ?', whereArgs: ['E']);
    return result.map((task) => TaskModel.fromMap(task)).toList();
  }

  Future<List<PopularModel>> GETALLPOPULAR() async {
    var conexion = await database;
    var result = await conexion!.query('tblPopular');
    return result.map((event) => PopularModel.fromMap(event)).toList();
  }

  Future<List<PopularModel>> GETPOPULAR(int id) async {
    var conexion = await database;
    var result = await conexion!.query('tblPopular', where: 'id=$id');
    return result.map((event) => PopularModel.fromMap(event)).toList();
  }

  // Nueva base de datos para películas favoritas

   Future<int> insertFavoriteMovie(Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.insert('tblFavoriteMovies', data);
  }

  Future<int> deleteFavoriteMovie(int movieId) async {
    var conexion = await database;
    return conexion!.delete('tblFavoriteMovies', where: 'movieId = ?', whereArgs: [movieId]);
  }

  Future<List<Map<String, dynamic>>?> getAllFavoriteMovies() async {
    var conexion = await database;
    return conexion!.query('tblFavoriteMovies');
  }


  


}
