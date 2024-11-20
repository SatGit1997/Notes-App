import 'package:database/db_helper.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var titleController= TextEditingController();
  var descController = TextEditingController();
  DbHelper dbHelper = DbHelper.getInstance();
  List<Map<String, dynamic>> mData = [];

  @override
  void initState() {
    super.initState();
    getNotes();

  }
  void getNotes() async{
    mData = await dbHelper.fetchAllNote();
    setState(() {

    });
  }

  void clearFields(){
    titleController.clear();
    descController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        centerTitle: true,
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.amber.withOpacity(0.97),
      body: mData.isNotEmpty
          ? ListView.builder(
        itemCount: mData.length,
          itemBuilder: (_, index){
            return ListTile(
              leading: Text('${index+1}',style: TextStyle(fontSize: 20),),
              title: Text(mData[index]["n_title"]),
              subtitle: Text(mData[index]["n_desc"]),
              trailing: SizedBox(
                width: 120,
                child: Row(
                  children: [
                    IconButton(onPressed: () async{

                      titleController.text = mData[index]['n_title'];
                      descController.text = mData[index]['n_desc'];

                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(50))
                        ),
                          context: context,
                          builder: (_){
                            return getBottomSheetUI(isUpdate: true, nId: mData[index]["n_id"]);
                          });


                    }, icon: Icon(Icons.edit,color: Colors.blue,)
                    ),
                    IconButton(onPressed: ()async{
                      bool check = await dbHelper.deleteNote(id: mData[index]["n_id"]);
                      if(check){
                        getNotes();
                      }

                    }, icon: Icon(Icons.delete,color: Colors.red,)
                    )
                  ],
                ),
              ),
            );
      }) : Center(
        child: Text('No Notes yet!!'),),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{

          titleController.clear();
          descController.clear();

          showModalBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(50))),
              context: context, builder: (_){
            return getBottomSheetUI();
          });

        },backgroundColor: Colors.amber,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getBottomSheetUI({bool isUpdate = false, int nId = 0, }){
    return Container(
      padding: EdgeInsets.all(16),
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(50))
      ),
      child: Column(
        children: [
          Text(
            isUpdate ? 'Update Note' : 'Add Note',
          ),
          SizedBox(height: 20,),
          TextField(
            controller: titleController,
            decoration: InputDecoration(
                hintText: "Title",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    borderSide: BorderSide(
                        color: Colors.green,
                        width: 2
                    )
                )
            ),

          ),
          SizedBox(height: 10,),
          TextField(
            controller: descController,
            maxLines: 4,
            minLines: 4,
            decoration: InputDecoration(
                hintText: "Description",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    borderSide: BorderSide(
                        color: Colors.green,
                        width: 2
                    )
                )
            ),
          ),
          SizedBox(height: 30),
          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(onPressed: () async{
                if(titleController.text.isNotEmpty &&
                    descController.text.isNotEmpty) {
                  bool check = false;

                  if(isUpdate){
                     check = await dbHelper.updateNote(
                         title:titleController.text,
                         desc:descController.text, id: nId);
                  }else{
                    check = await dbHelper.addNote(
                  title: titleController.text.toString(),
                  desc: descController.text.toString());
                  }

                  if(check){
                    Navigator.pop(context);
                    getNotes();
                  }
                }
              },
                  child: Text(isUpdate ? "Update" : "Add")),
              SizedBox(width: 10),
              OutlinedButton(onPressed: (){
                clearFields();
                Navigator.pop(context);
              }, child: Text("Cancel"))
            ],
          )
        ],
      ),
    );
  }
}