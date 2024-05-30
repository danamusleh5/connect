import 'dart:convert';
import 'dart:io';

class ToDo {
  String id;
  String todoText;
  bool isDone;
  String priority;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
    required this.priority,
  });

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['id'],
      todoText: json['todoText'],
      isDone: json['isDone'] ?? false,
      priority: json['priority'] ?? 'Relatively Soon', // Default priority
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'todoText': todoText,
    'isDone': isDone,
    'priority': priority,
  };

  static List<ToDo> todoList = [];

  static void addTodoItem(String text, String priority) {
    var newId = DateTime.now().millisecondsSinceEpoch.toString();
    var newItem = ToDo(id: newId, todoText: text, priority: priority);
    todoList.add(newItem);
  }

  static Future<void> saveToDoListToFile(String filePath) async {
    var jsonList = todoList.map((todo) => todo.toJson()).toList();
    var jsonString = json.encode(jsonList);
    await File(filePath).writeAsString(jsonString);
  }

  static Future<void> loadToDoListFromFile(String filePath) async {
    var file = File(filePath);
    if (await file.exists()) {
      var jsonString = await file.readAsString();
      var jsonList = json.decode(jsonString) as List<dynamic>;
      todoList = jsonList.map((item) => ToDo.fromJson(item)).toList();
    }
  }
}
