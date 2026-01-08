import 'package:flutter/material.dart';
import 'package:flutter_todoapp/data/database.dart';
import 'package:flutter_todoapp/util/dialog_box.dart';
import 'package:flutter_todoapp/util/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box("MyBox");

  final _saveTextController = TextEditingController();  
  todoDatabase db = todoDatabase();

  @override
  void initState() {
   

   //if this is the first time ever opening the app
   if(_myBox.get("todolist") == null){
    db.createInitialData();
   }else {
    db.loadData();
   }
    
  }



  void checkBoxChanged(bool? value, int index){

    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });

    db.updateData();

  }

  void saveNewTask(){

    setState(() {
      db.todoList.add([_saveTextController.text, false]);
      _saveTextController.clear();
    });
    Navigator.of(context).pop();

  db.updateData();
  }

  void createNewTask(){
    showDialog(context: context, builder: (context){
      return DialogBox(
        controller: _saveTextController,
        onSave: saveNewTask,
        onCancel: ()=> Navigator.of(context).pop(),
      );
    });
  }

void deleteTask(int index){

  setState(() {
    db.todoList.removeAt(index);
  });
  db.updateData();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
       appBar: AppBar(
         title: Text("TO DO"),
         centerTitle: true,
         elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: db.todoList.length,
            itemBuilder: (context, index){
              return TodoTile(onChanged: (value)=> checkBoxChanged(value, index),
              taskCompleted: db.todoList[index][1],
              taskName: db.todoList[index][0],
              onDelete: (context)=> deleteTask(index),
              );
            },

        )

    );
  }
}