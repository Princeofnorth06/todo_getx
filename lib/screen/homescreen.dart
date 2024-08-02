import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/controller/todo_controller.dart';
import 'package:todo_getx/screen/todo_screen.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoContoller todoContoller = Get.put(TodoContoller());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('To-Do List',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.separated(
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (_) {
                  var removed = todoContoller.todos[index];
                  todoContoller.todos.removeAt(index);
                  Get.snackbar(
                      'Task Removed', 'The Task ${removed.text} is removed',
                      mainButton: TextButton(
                          onPressed: () {
                            todoContoller.todos.insert(index, removed);
                            if (Get.isSnackbarOpen) {
                              Get.closeAllSnackbars();
                            }
                          },
                          child: const Text('Undo')));
                },
                child: ListTile(
                  onTap: () {
                    Get.to(TodoScreen(
                      index: index,
                    ));
                  },
                  title: Text(
                    todoContoller.todos[index].text,
                    style: (todoContoller.todos[index].done)
                        ? const TextStyle(
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough)
                        : const TextStyle(color: Colors.black),
                  ),
                  leading: Checkbox(
                    value: todoContoller.todos[index].done,
                    onChanged: (v) {
                      var changed = todoContoller.todos[index];
                      changed.done = v!;
                      todoContoller.todos[index] = changed;
                    },
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
              );
            },
            separatorBuilder: (_, __) => const Divider(),
            itemCount: todoContoller.todos.length),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const TodoScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
