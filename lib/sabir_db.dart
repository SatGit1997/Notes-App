import 'package:database/db_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var titleController = TextEditingController();
  var descController = TextEditingController();
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

  void clearFields() {
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
      backgroundColor: Colors.amber.withOpacity(0.85),
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
                  IconButton(
                    onPressed: () {
                      // Handle update logic here
                    },
                    icon: Icon(Icons.update),
                  ),
                  IconButton(
                    onPressed: () {

                    },
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        },
      )
          : Center(
        child: Text('No Notes yet!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
            ),
            context: context,
            builder: (_) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  padding: EdgeInsets.all(16),
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Add Note', style: TextStyle(fontSize: 20)),
                        SizedBox(height: 20),
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
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
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
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () async {
                                if (titleController.text.isNotEmpty &&
                                    descController.text.isNotEmpty) {
                                  bool check = await dbHelper.addNote(
                                    title: titleController.text.trim(),
                                    desc: descController.text.trim(),
                                  );
                                  if (check) {
                                    print("Note added successfully!");
                                    getNotes();
                                    clearFields();
                                    Navigator.pop(context);
                                  } else {
                                    print("Failed to add note");
                                  }
                                } else {
                                  print("Title and Description cannot be empty");
                                }
                              },
                              child: Text("Add"),
                            ),
                            SizedBox(width: 10),
                            OutlinedButton(
                              onPressed: () {
                                clearFields();
                                Navigator.pop(context);
                              },
                              child: Text("Cancel"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: Colors.amber,
        child: Icon(Icons.add),
      ),
    );
  }
}
