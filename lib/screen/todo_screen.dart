import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/controller/todo_controller.dart';
import 'package:todo_getx/models/todo.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key, this.index});
  final int? index;
  @override
  Widget build(BuildContext context) {
    final TodoContoller todoContoller = Get.find();
    String text = '';
    if (index != null) {
      text = todoContoller.todos[index!].text;
    }
    TextEditingController textcontroller = TextEditingController(text: text);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Get.width * 0.05),
          child: Column(
            children: [
              Expanded(
                  child: TextField(
                controller: textcontroller,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'What you want to accomplish ?',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 999,
                style: const TextStyle(fontSize: 25),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text(
                        'Cancle',
                        style: TextStyle(color: Colors.white),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        if (index == null) {
                          todoContoller.todos
                              .add(Todo(text: textcontroller.text));
                        } else {
                          var edit = todoContoller.todos[index!];
                          edit.text = textcontroller.text;
                          todoContoller.todos[index!] = edit;
                        }
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      child: Text((index == null) ? 'Add' : "Update",
                          style: const TextStyle(color: Colors.white)))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
