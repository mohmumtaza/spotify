import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:spotify/provider/list_provider.dart';
import 'package:spotify/view/add_list.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<TodoScreen> {
  late TodoProvider todoProvider;
  @override
  void initState() {
    todoProvider = Provider.of<TodoProvider>(context, listen: false);
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF212325),
          title: Text(
            "Catatan untuk Kurir",
            style: GoogleFonts.kanit(color: Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddTodoScreen()));
          },
          child: const Icon(Icons.add),
        ),
        body: Consumer<TodoProvider>(
          builder: (context, todoProvider, child) {
            return todoProvider.todos.isEmpty
                ? Center(
                    child: Text(
                      "Tidak ada Catatan",
                      style: GoogleFonts.kanit(color: Colors.white),
                    ),
                  )
                : ListView.builder(
                    itemCount: todoProvider.todos.length,
                    itemBuilder: (context, index) => Card(
                          elevation: 10,
                          shadowColor: Colors.white,
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: todoProvider.todos[index].isDone,
                                      onChanged: (value) {
                                        setState(() {
                                          todoProvider.todos[index].isDone =
                                              value!;
                                          todoProvider.updateTodo(
                                            index,
                                            todoProvider.todos[index],
                                          );
                                        });
                                      },
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              todoProvider.todos[index].title,
                                              style: GoogleFonts.kanit(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "(${todoProvider.todos[index].createdAt.day}-${todoProvider.todos[index].createdAt.month}-${todoProvider.todos[index].createdAt.year})",
                                              style: GoogleFonts.kanit(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        Text(
                                          todoProvider.todos[index].description,
                                          style: GoogleFonts.kanit(
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      todoProvider.removeTodo(index);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ));
          },
        ));
  }

  void getData() async {
    await todoProvider.getTodo();
  }
}