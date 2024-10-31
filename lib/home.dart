import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/model/todo_model.dart';
import 'package:provider_app/provider/todo_provider.dart';

class MyHomeUiPage extends StatefulWidget {
  const MyHomeUiPage({super.key});

  @override
  State<MyHomeUiPage> createState() => _MyHomeUiPageState();
}

class _MyHomeUiPageState extends State<MyHomeUiPage> {
// add
  final _textController = TextEditingController();

  Future<void> _showDiaglog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add todo List'),
            content: TextField(
              controller: _textController,
              decoration: const InputDecoration(hintText: ('Write to do Item')),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    if (_textController.text.isEmpty) {
                      return;
                    }
                    context.read<TodoProvider>().addToDoList(new TODOModel(
                        title: _textController.text, isCompleate: false));

                    _textController.clear();

                    Navigator.pop(context);
                  },
                  child: Text('Submit'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Color(0xff622CA7),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40))),
              child: const Center(
                child: Text(
                  "This Flutter App",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            )),
            Expanded(
                flex: 3,
                child: ListView.builder(
                  itemBuilder: (context, itemIndex) {
                    return ListTile(
                      onTap: () {
                        provider
                            .todoStatusChange(provider.allTODOList[itemIndex]);
                      },
                      leading: MSHCheckbox(
                        value: provider.allTODOList[itemIndex].isCompleate,
                        size: 30,
                        colorConfig:
                            MSHColorConfig.fromCheckedUncheckedDisabled(
                          checkedColor: Colors.blue,
                        ),
                        style: MSHCheckboxStyle.stroke,
                        onChanged: (selected) {
                          provider.todoStatusChange(
                              provider.allTODOList[itemIndex]);
                        },
                      ),
                      title: Text(
                        provider.allTODOList[itemIndex].title,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            decoration:
                                provider.allTODOList[itemIndex].isCompleate ==
                                        true
                                    ? TextDecoration.lineThrough
                                    : null),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            provider.removeToDoList(
                                provider.allTODOList[itemIndex]);
                          },
                          icon: Icon(Icons.delete)),
                    );
                  },
                  itemCount: provider.allTODOList.length,
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff622CA7),
        onPressed: () {
          _showDiaglog();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
