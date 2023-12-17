import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quiz_hub/models/feedbackModel.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

class FeedbackHandlerSQLite{

  static Database? _feedbackDB;

  Future<Database?> get db async{
    if(_feedbackDB != null){
      return _feedbackDB;
    }
    _feedbackDB = await initDatabase();
    return _feedbackDB;
  }

  initDatabase()async{

    io.Directory documentDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentDirectory.path, 'feedbackNote.db');

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version)async{
    await db.execute(
      'CREATE TABLE teacherFeedback '
          '(id INTEGER PRIMARY KEY AUTOINCREMENT, teacherName TEXT NOT NULL, title TEXT NOT NULL, description TEXT NOT NULL)',
    );
  }

  Future<FeedbackModel> insert(FeedbackModel feedbackModel)async{

    var dbClient = await db;
    await dbClient!.insert('teacherFeedback', feedbackModel.toMap());
    return feedbackModel;
  }

  Future<List<FeedbackModel>> getFeedbackList()async{

    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query('teacherFeedback');
    return queryResult.map((e) => FeedbackModel.fromMap(e)).toList();
  }
}