import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/main_theme.dart';
import '../blocs/todo_bloc.dart';
import '../blocs/todo_event.dart';

class TodoSearchForm extends StatefulWidget {
  final String? id, title;
  const TodoSearchForm({Key? key, this.id, this.title}) : super(key: key);

  @override
  State<TodoSearchForm> createState() => _TodoSearchFormState();
}

class _TodoSearchFormState extends State<TodoSearchForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _keywordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todoBloc = BlocProvider.of<TodosBloc>(context);
    double height = MediaQuery.of(context).size.longestSide;
    return AlertDialog(
      content: Form(
          key: _formKey,
          child: SizedBox(
            height: height * 0.1,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    child: TextField(
                      controller: _keywordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal)),
                        hintText: 'ex. meeting',
                        labelText: 'Search Title/Description',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text('Search TODO',
            style: TextStyle(color: mainTheme.secondaryHeaderColor)),
        const Text('Unspecified, For view all TODO',
            style: TextStyle(fontSize: 13, color: Colors.grey)),
      ]),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: const Text('CANCEL', style: TextStyle(color: Colors.grey)),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: const Text('SEARCH', style: TextStyle(color: Colors.blue)),
            onTap: () {
              todoBloc.add(FindTodos(_keywordController.text));
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
