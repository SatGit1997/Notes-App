import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{
  /// step 1 private constructor
  DbHelper._();

  /// step 2 creating a static global instance to this class
  //static final DbHelper instance = DbHelper._();  //variable  or

  static DbHelper getInstance() => DbHelper._();    // function

  Database? mDb;
  /// open DB
  Future<Database> initDB() async{
    mDb = mDb ?? await openDB();
    print("Db opened!!");
    return mDb!;
  }

  Future<Database> openDB() async{
    var dirPath = await getApplicationDocumentsDirectory();
    var dbPath  = join(dirPath.path, "noteDB.db");


    return openDatabase(dbPath, version: 1, onCreate: (db, version){

      /// create tables
      db.execute("create table note ( n_id integer primary key autoincrement, n_title text, n_desc text)");
      print("Db created!!");
    });
  }

  /// insert
 Future<bool> addNote({required String title, required String desc}) async{

    Database db = await initDB();

    int rowsEffected = await db.insert("note", {
      "n_title" : title,
      "n_desc"  : desc,
    });

    if(rowsEffected > 0){
      return true;
    }else {
      return false;
    }


 }
///select
  Future<List<Map<String,dynamic>>> fetchAllNote() async{
    Database db = await initDB();

   List<Map<String, dynamic>> allNotes = await db.query("note");

   return allNotes;
  }
///update
  Future<bool> updateNote({required String title, required String desc, required int id}) async{
    Database db = await initDB();

    int rowEffected = await db.update("note", {
      "n_title" : title,
      "n_desc" : desc,
    }, where:  "n_id = $id");
     return rowEffected>0;


  }
///delete

  Future<bool> deleteNote({required int id}) async {
    Database db = await initDB();

    int rowsEffected = await db.delete("note", where: "n_id = ?", whereArgs: ['$id']);
    return rowsEffected>0;
  }

  ///checked


}