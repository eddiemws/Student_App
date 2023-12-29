import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });
}

class AssignmentsPage extends StatefulWidget {
  const AssignmentsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AssignmentsPageState createState() => _AssignmentsPageState();
}

class _AssignmentsPageState extends State<AssignmentsPage> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    TextEditingController newTodoController = TextEditingController();

    void addNewTodo() {
      String newTodoText = newTodoController.text.trim();
      if (newTodoText.isNotEmpty) {
        FirebaseFirestore.instance.collection('todos').add({
          'todoText': newTodoText,
          'isDone': false,
        });
        newTodoController.clear();
      }
    }

    void deleteTodo(String todoId) {
      FirebaseFirestore.instance.collection('todos').doc(todoId).delete();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                const SizedBox(height: 10,),
                searchBox(),
                Container(
                  margin: const EdgeInsets.only(
                    top: 50,
                    bottom: 20,
                  ),
                  child: const Text(
                    'My Assignments',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: ToDoList.builder(deleteTodo, searchQuery), // Pass the deleteTodo function and searchQuery
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin:
                        const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(
                            0.0,
                            0.0,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextFormField(
                      controller: newTodoController,
                      decoration: const InputDecoration(
                          hintText: 'add new Assignment',
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      addNewTodo();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(220, 16, 240, 248),
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                    ),
                    child: const Text(
                      '+',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.purpleAccent,
          borderRadius: BorderRadius.circular(20.0)),
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
            size: 20.0,
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}

class ToDoList extends StatelessWidget {
  final Function(String) deleteTodo;
  final String searchQuery; // Add this line

  const ToDoList({
    required this.deleteTodo,
    required this.searchQuery,
    Key? key,
  }) : super(key: key);

  factory ToDoList.builder(Function(String) deleteTodo, String searchQuery) {
    return ToDoList(deleteTodo: deleteTodo, searchQuery: searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('todos').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ToDo> todos = snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return ToDo(
              id: doc.id,
              todoText: data['todoText'],
              isDone: data['isDone'],
            );
          }).toList();

          // Filter todos based on searchQuery
          List<ToDo> filteredTodos = todos.where((todo) {
            return todo.todoText!
                .toLowerCase()
                .contains(searchQuery.toLowerCase());
          }).toList();

          return ListView.builder(
            itemCount: filteredTodos.length,
            itemBuilder: (context, index) {
              ToDo todo = filteredTodos[index];
              return ToDoItem(todo: todo, deleteTodo: deleteTodo);
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final Function(String) deleteTodo;

  const ToDoItem({
    required this.todo,
    required this.deleteTodo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      child: ListTile(
        onTap: () {
          print('Clicked on TodoList');
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white70,
        leading: Checkbox(
          value: todo.isDone,
          onChanged: (newValue) {
            // Handle the checkbox value change
            // Update the todo.isDone property and update Firestore if needed
            FirebaseFirestore.instance
                .collection('todos')
                .doc(todo.id)
                .update({'isDone': newValue});
          },
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 16,
            color: todo.isDone ? Colors.black : Colors.purple,
            decoration:
                todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(2),
          margin: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            onPressed: () {
              deleteTodo(todo.id!);
              print('Clicked on delete Icon');
            },
            icon: const Icon(
              Icons.delete,
            ),
            iconSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}


  ));
}
