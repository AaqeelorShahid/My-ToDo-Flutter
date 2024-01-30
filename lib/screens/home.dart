import 'package:flutter/material.dart';
import 'package:my_todo/constants/colors.dart';
import 'package:my_todo/models/todo.dart';
import 'package:my_todo/widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<TODO> _searchList = [];

  final todoList = TODO.todoList();
  final _todoController = TextEditingController();

  @override
  void initState() {
    _searchList = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdgrey,
        appBar: _appBar(),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                children: [
                  seachBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 50, bottom: 20),
                          child: const Text(
                            'ToDOs',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                        ),
                        for (TODO todo in _searchList.reversed)
                          ToDoItem(
                            todoItem: todo,
                            onToDoChanged: _handleToDoChange,
                            onDeleteItem: _handleToDoDelete,
                          )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 30,
                        right: 20,
                        left: 20,
                      ),
                      padding: const EdgeInsets.only(
                        left: 15,
                        bottom: 7,
                        top: 7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Enter the text',
                          border: InputBorder.none,
                        ),
                        controller: _todoController,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 30,
                      right: 15,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        _addToDoList(_todoController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        elevation: 10,
                        minimumSize: Size(60, 60),
                      ),
                      child: const Text(
                        '+',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  void _handleToDoChange(TODO todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _handleToDoDelete(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoList(String value) {
    setState(() {
      todoList.add(TODO(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: value));
    });
    _todoController.clear();
  }

  void _searchFunction(String value) {
    List<TODO> results = [];
    if (value.isNotEmpty) {
      results = todoList
          .where((item) =>
              item.todoText!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    } else {
      results = todoList;
    }

    setState(() {
      _searchList = results;
    });
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: tdgrey,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.menu, color: Colors.black, size: 30),
          SizedBox(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/notes.png'),
            ),
          ),
        ],
      ),
    );
  }

  Widget seachBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _searchFunction(value),
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
              size: 25,
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              minWidth: 25,
            ),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white70)),
      ),
    );
  }
}
