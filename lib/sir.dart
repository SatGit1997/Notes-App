/*
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{

  /// step 1 private constructor
  DbHelper._();

  /// step 2 creating a static global instance to this class
  //static final DbHelper instance = DbHelper._();

  static DbHelper getInstance() => DbHelper._();

  Database? mDB;

  ///open DB
  Future<Database> initDB() async{

    mDB = mDB ?? await openDB();
    print("db opened!!");
    return mDB!;

    */
/*if(mDB!=null){
      return mDB!;
    } else {
      mDB = await openDB();
      return mDB!;
    }*//*


  }

  Future<Database> openDB() async{
    /// data/data/com.skvksv.dkvmd/databases/noteDb.db
    var dirPath = await getApplicationDocumentsDirectory();
    var dbPath = join(dirPath.path, "noteDB.db");

    return openDatabase(dbPath, version: 1, onCreate: (db, version){

      print("db created!!");
      ///create tables
      db.execute("create table note ( n_id integer primary key autoincrement, n_title text, n_desc text)");

    });

  }

  ///insert
  Future<bool> addNote({required String title, required String desc}) async{

    Database db = await initDB();

    int rowsEffected = await db.insert("note", {
      "n_title" : title,
      "n_desc" : desc,
    });

    return rowsEffected>0;

  }

  ///select
  Future<List<Map<String, dynamic>>> fetchAllNote() async{

    Database db = await initDB();

    List<Map<String, dynamic>> allNotes = await db.query("note"); /// select * from note

    return allNotes;
  }


  ///update
  Future<bool> updateNote({required String title, required String desc, required int id}) async{

    Database db = await initDB();

    int rowsEffected = await db.update("note", {
      "n_title" : title,
      "n_desc" : desc,
    }, where: "n_id = $id");

    return rowsEffected>0;

  }
///delete

}*/

///homePage



/*

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  DbHelper dbHelper = DbHelper.getInstance();
  List<Map<String, dynamic>> mData = [];

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  void getNotes() async {
    mData = await dbHelper.fetchAllNote();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: mData.isNotEmpty
          ? ListView.builder(
          itemCount: mData.length,
          itemBuilder: (_, index) {
            return ListTile(
              title: Text(mData[index]["n_title"]),
              subtitle: Text(mData[index]["n_desc"]),
              trailing: SizedBox(
                width: 120,
                child: Row(
                  children: [
                    IconButton(onPressed: () async{
                      bool check = await dbHelper.updateNote(title: "Update Note", desc: "Updated Desc", id: mData[index]["n_id"]);
                      if(check){
                        getNotes();
                      }
                    }, icon: Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ],
                ),
              ),
            );
          })
          : Center(
        child: Text('No notes yet!!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(40))),
              backgroundColor: Colors.orange,
              */
/*isDismissible: false,*//*

              enableDrag: false,
              context: context,
              builder: (_) {
                return Container(
                  padding: EdgeInsets.all(11),
                  height: 500,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(40))),
                  child: Column(
                    children: [
                      Text(
                        'Add Note',
                        style: TextStyle(fontSize: 21),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          label: Text('Title*'),
                          hintText: "Enter your title here..",
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11)),
                        ),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      TextField(
                        controller: descController,
                        minLines: 4,
                        maxLines: 4,
                        decoration: InputDecoration(
                          label: Text('Desc*'),
                          hintText: "Enter your description here..",
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11)),
                        ),
                      ),
                      SizedBox(
                        height: 21,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                              onPressed: () async{
                                if (titleController.text.isNotEmpty &&
                                    descController.text.isNotEmpty) {
                                  bool check = await dbHelper.addNote(
                                      title: titleController.text.toString(),
                                      desc: descController.text.toString());

                                  if(check){
                                    Navigator.pop(context);
                                    getNotes();
                                  } else {
                                    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: Note not added!!")));
                                  }
                                } else {
                                  //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: Please fill all the required blanks!!")));
                                }


                              },
                              child: Text('Add')),
                          SizedBox(
                            width: 11,
                          ),
                          OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel')),
                        ],
                      ),
                    ],
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}*/
