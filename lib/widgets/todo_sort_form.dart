import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/main_theme.dart';
import '../blocs/todo_bloc.dart';
import '../blocs/todo_event.dart';

class TodoSortForm extends StatefulWidget {
  const TodoSortForm({Key? key}) : super(key: key);

  @override
  State<TodoSortForm> createState() => _TodoSortFormState();
}

class _TodoSortFormState extends State<TodoSortForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _selectType = 'title';
  String _selectSort = 'less-more';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todoBloc = BlocProvider.of<TodosBloc>(context);
    double height = MediaQuery.of(context).size.longestSide;
    var type = [
      "title",
      "status",
      "date",
    ];
    var sort = [
      "more-less",
      "less-more",
    ];
    return AlertDialog(
      content: Form(
          key: _formKey,
          child: SizedBox(
            height: height * 0.25,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputDecorator(
                  decoration: InputDecoration(
                      errorStyle:
                          const TextStyle(color: Colors.redAccent, fontSize: 16.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectType,
                      isDense: true,
                      onChanged: (newValue) {
                        setState(() {
                          _selectType = newValue ?? 'title';
                        });
                      },
                      items: type.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InputDecorator(
                  decoration: InputDecoration(
                      errorStyle: const TextStyle(
                          color: Colors.redAccent, fontSize: 16.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectSort,
                      isDense: true,
                      onChanged: (newValue) {
                        setState(() {
                          _selectSort = newValue ?? 'more-less';
                        });
                      },
                      items: sort.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          )),
      title: Text('Sort TODO',
          style: TextStyle(color: mainTheme.secondaryHeaderColor)),
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
            child: const Text('SORT', style: TextStyle(color: Colors.blue)),
            onTap: () {
              todoBloc.add(SortTodos(_selectType,
                  sortMoreToLess: _selectSort == 'more-less' ? true : false));
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
