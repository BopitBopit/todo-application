import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/blocs/todo_event.dart';
import 'package:todo_app/models/todo_list_model.dart';

import '../blocs/todo_bloc.dart';
import 'todo_form.dart';

class TodoCard extends StatelessWidget {
  final TodoModel detail;
  const TodoCard({Key? key, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todosBloc = BlocProvider.of<TodosBloc>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.longestSide;
    DateTime dateLocal = DateFormat('yyyy-MM-dd').parse(detail.date).toLocal();
    String day = dateLocal.day.toString();
    String date = '${dateLocal.year}-${dateLocal.month}-${dateLocal.day}';
    onOpenUpdateFormDialog(TodoModel detail) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return TodoForm(todo: detail);
          });
    }

    return SizedBox(
      height: height * 0.15,
      child: Card(
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 8,
        child: Stack(children: [
          Positioned(
            top: 12,
            left: 12,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      day.padLeft(2, '0'),
                      style: const TextStyle(fontSize: 22, color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: width * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        detail.title,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        softWrap: true,
                        style:
                            const TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      Text(
                        date,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      Text(
                        detail.description ?? 'Not Description',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: GestureDetector(
              onTap: () => todosBloc.add(UpdateTodos(detail, true)),
              child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Icon(
                    detail.status == 'COMPLETE'
                        ? Icons.check_circle_outlined
                        : Icons.circle,
                    size: 40,
                    color: Colors.white,
                  )),
            ),
          ),
          Positioned(
            bottom: 12,
            right: 12,
            child: GestureDetector(
              onTap: () => onOpenUpdateFormDialog(detail),
              child: const Text("view/edit",
                  style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline)),
            ),
          ),
        ]),
      ),
    );
  }
}
