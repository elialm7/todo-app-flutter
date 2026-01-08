import 'package:hive/hive.dart';

class todoDatabase{
  final _myBox  = Hive.box("MyBox");
  List todoList = [];



  void createInitialData(){

    todoList = [
      ["Sal a correr!", false]
    ];
  }


  void loadData(){
    todoList = _myBox.get("todolist");
  }

  void updateData(){
    _myBox.put("todolist", todoList);
  }
}